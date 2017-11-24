//
//  Person.h
//  Test
//
//  Created by 王纪涛 on 2017/11/3.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TopButDelegate <NSObject>//协议

- (void)transButIndex:(NSInteger)index;//协议方法

@end

@interface Person : NSObject {
    NSString *_age;
}


//@property 做用可以生成getter和setter方法 默认生成一个私有的成员变量
@property (nonatomic,copy) NSString *age;//setter和getter方法
/*
 1、不能同时重写setter和getter方法，否则会报错 , 如果想同时让这两个方法共存，需要自己声明实例变量
 2、主要是因为当复写了get和set方法之后@property默认生成的@synthesize就不会起作用了
 3、这也就意味着你的类不会自动生成出来实例变量了，你就必须要自己声明实例变量,如下：
 {
   NSString *_age;
 }
 */

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readwrite) NSDate *date;

@property (nonatomic,weak) id <TopButDelegate> delegate;

+(void)shareInstance;

//strong weak 赋值给weak变量后这块内存会马上被释放。而分配给strong变量的会等到这个变量的生命周期结束后，这块内存才被释放
@property (nonatomic,copy) NSString *nameStr;

/*
 类的私有方法，这个方法是在category类别中实现的
 */
-(void)shareName;

@end
