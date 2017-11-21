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

@interface ViewController ()

@property (nonatomic,copy) NSString *cache;
//@property (nonatomic,strong) MyView *testView;
@property (nonatomic,weak) MyView *testView;
@property (nonatomic,copy) NSMutableArray *arr;

@end

@implementation ViewController

//set 方法
- (void)setCache:(NSString *)url
{
    NSString *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    _cache = [cache stringByAppendingString:url];
}

//- (NSMutableArray *)arr
//{
//    if (!_arr) {
//        _arr = [[NSMutableArray alloc] init];
//    }
//    return _arr;
//}

- (void)setArr:(NSMutableArray *)arr
{
    if (!_arr) {
        _arr = [arr mutableCopy];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view, typically from a nib.
    
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
    NSLog(@"%@\n %@",person.name,person.date);
    
    [Person shareName];
    [person shareName];
    
    /*
     如果类中方法只声明，没有实现，在程序运行的时候会崩
     */
    
    self.cache = @"wangjitao";
    
    //多线程
    //dispatch_queue_t q = dispatch_queue_create("cn.creat", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"主线程 %@",[NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"我是新线程  %@",[NSThread currentThread]);
        
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
}

- (void)removeViews:(UIButton *)sender {
    
    NSLog(@"点击了按钮");
    
    [self.testView removeFromSuperview];
    
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
