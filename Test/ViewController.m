//
//  ViewController.m
//  Test
//
//  Created by 王纪涛 on 2017/10/25.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Category.h"
#import "MyView.h"

#import<MobileVLCKit/MobileVLCKit.h>
#import <objc/message.h>

#define M_MIN(a,b) (a>b ? b : a) //创建宏

/*
 autorelease并不是根据作用域来决定释放时机的。那到底是依据什么呢？答案是：runloop。
 简单说，runloop就是iOS中的消息循环机制，当一个runloop结束时系统才会一次性清理掉被autorelease处理过的对象.其实本质上说是在本次runloop迭代结束时清理掉被本次迭代期间被放到autorelease pool中的对象的。
 至于何时runloop结束并没有固定的duration！
 
 释放时机是基于runloop而不是作用域；通过autorelease pool手动干预释放；循环多次时当心要对autorelease进行优化。
 
 ****向一个对象发送- autorelease消息，就是将这个对象加入到当前AutoreleasePoolPage的栈顶next指针指向的位置。
 */

/*
 在iOS中有三种常用的遍历方法：for、forin、enumerateObjectsUsingBlcok
 */

@interface ViewController ()
//{
//    NSString *_cache;
//}

@property (nonatomic,copy) NSString *cache;
//@property (nonatomic,strong) MyView *testView;
@property (nonatomic,weak) MyView *testView;
@property (nonatomic,copy) NSMutableArray *arr;

@property (nonatomic,strong)VLCMediaPlayer *mediaPlayer;



@end

@implementation ViewController

@synthesize cache = _cache;

//set 方法
- (void)setCache:(NSString *)url
{
    NSString *cache_ = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    _cache = [cache_ stringByAppendingString:url];
}

- (NSString *)cache
{
    return _cache;
}



- (void)setArr:(NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [arr mutableCopy];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
    
    int a = M_MIN(9, 7);
    NSLog(@"最小值%d",a);
    
    NSMutableArray *arr1 = [[NSMutableArray alloc] init];
    self.arr = arr1;
    [arr1 addObject:@"1"];
    [self.arr addObject:@"2"];
    /*
    1、可变数组arr声明时如果使用copy,之后添加不了元素---这就是深拷贝（指针、内容全都都复制，生成了一个新的对象）;
    2、如果想添加元素要重写setter方法，使用【mutblecopy】
     */
    NSLog(@"%p########%p",arr1,self.arr);
    NSLog(@"%@########%@",arr1,self.arr);
    
    
    Person *person = [[Person alloc] init];
    person.newProperty = @"使用运行时在类别中扩展的属性";
    NSLog(@"%@ %@  %@",person.name,person.date,person.newProperty);
    
    /*
     runtim调用对象方法
     */
    if ([person respondsToSelector:@selector(runTimeEat)]) {
        [person performSelector:@selector(runTimeEat)];
    }
    //objc_msgSend(person, @selector(runTimeEat));
    
    
    /*
     如果类中方法只声明，没有实现，在程序运行的时候会崩
     */
    [Person shareName];
    [person shareName];
    
    /*
     self.的使用是调用了对象的setter和getter方法，一般可以理解为 =左边调用setter；=右边调用getter方法
     注意：但是不能同时重写对象的setter 和 getter 方法；
          如果同时写了这两个方法，那么系统就不会自动生成成员变量方法了，所以就会报错说找不到成员变量方法。
     想要同时重写这两个方法可以有两种方法：
          1、使用@synthesize cache = _cache;
          2、可以先自己手动生成成员变量方法 NSString *_cache;
     
     这里扩展基础知识
     @property 声明了一些成员变量的访问方法（控制多线程成员变量的访问环境、提供成员变量访问方法的声明、控制成员变量的访问权限）
      @property不但可以在interface，在协议protocol.和类别category中也可以使用。
     @synthesize 定义了由property声明的方法,也可以更改成员变量的名称；
     
     他们之前的对应关系是:property 声明方法 -> h文件中申明getter和setter方法
                      synthesize 定义方法 -> m文件中实现getter和setter方法
     博文链接：http://www.jianshu.com/p/bcf734db475c
     */
    self.cache = @"wangjitao";
    
    
    //多线程
    //dispatch_queue_t q = dispatch_queue_create("cn.creat", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"主线程 %@",[NSThread currentThread]);
    NSLog(@"¥¥¥¥¥¥¥%@",[NSRunLoop currentRunLoop]);//mainrunloop
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"我是新线程  %@",[NSThread currentThread]);
        NSLog(@"$$$$$%@",[NSRunLoop currentRunLoop]);//每个线程会有一个自己的runloop
        
    });
    
    NSLog(@"主线程 %@",[NSThread currentThread]);
    
    MyView *myView = [[MyView alloc] init];
    myView.frame = CGRectMake(50, 50, 200, 200);
    myView.backgroundColor = [UIColor redColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.text = @"这是一个试图";
    [myView addSubview:label];
    
    self.testView = myView;
    [self.view addSubview:myView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 300, 100, 60);
    [btn setTitle:@"移除子视图" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(removeViews:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    UIButton *logBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logBtn.frame = CGRectMake(100, 400, 100, 60);
    [logBtn setTitle:@"打印" forState:UIControlStateNormal];
    [logBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [logBtn addTarget:self action:@selector(logbtnOnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:logBtn];
    
    UIView *videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 200)];
    [self.view addSubview:videoView];
    
    /*
    VLCMediaPlayer *player = [[VLCMediaPlayer alloc] initWithOptions:nil];
    self.mediaPlayer = player;
    self.mediaPlayer.drawable = videoView;
    self.mediaPlayer.media = [VLCMedia mediaWithPath:[[NSBundle mainBundle] pathForResource:@"a" ofType:@"wmv"]];
    [self.mediaPlayer play];
     */
}

- (void)removeViews:(UIButton *)sender {
    
    NSLog(@"点击了按钮");
    
    [self.testView removeFromSuperview];
    
    /*
     addsubview 父类会对对象进行一次强引用，
     1、使用strong修饰 相当于进行了两次强引用 所以此时retaincount=2
     2、使用weak修饰 只有一次强引用 remove后对象会被销毁
     */
    
    NSLog(@"%p||||",self.testView);
}

- (void)logbtnOnClick:(UIButton *)sender {
    
    NSLog(@"%p验证",self.testView);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
