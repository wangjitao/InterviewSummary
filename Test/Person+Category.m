//
//  Person+Category.m
//  Test
//
//  Created by 王纪涛 on 2017/11/3.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

#import "Person+Category.h"
#import <objc/message.h>

@interface Person ()

@end

@implementation Person (Category)

#warning why dynamic?
@dynamic newProperty;
//static NSString *newProperty; //扩展属性时也可以使用静态变量

/*
 这个方法只要是 文件被夹到工程中就会被调用，即使头文件没有引用到类中；
 只要是当前文件 被添加到工程中就会调用，在Build Phases --> Compile Sources 就会调用+(void)load
 why?
 */
#warning why?
+ (void)load {
    NSLog(@"最先调用的方法");
}

/*
 在类别中动态添加属性 当然也可以使用运行时向类中添加方法
 objc_setAssociatedObject来把一个对象与另外一个对象进行关联。该函数需要四个参数：源对象，关键字，关联的对象和一个关联策略（这个关联策略根据属性声明是的类型来定）
 关键字：是一个void类型的指针。每一个关联的关键字必须是唯一的。通常都是会采用静态变量来作为关键字。
 关联策略：表明了相关的对象是通过赋值，保留引用还是复制的方式进行关联的；还有这种关联是原子的还是非原子的。这里的关联策略和声明属性时的很类似。这种关联策略是通过使用预先定义好的常量来表示的。
 */
- (void)setNewProperty:(NSString *)newProperty {
    [self willChangeValueForKey:@"newProperty"];
    objc_setAssociatedObject(self, @selector(newProperty), newProperty, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"newProperty"];
}

- (NSString *)newProperty {
    NSString *object = objc_getAssociatedObject(self,@selector(newProperty));
    return object;
}

/*
 实现类中扩展的方法
 */
+ (void)shareName {
    NSLog(@"类方法");
}

/*
 重写了原类的方法 而苹果的官方文档中明确表示 不应该在category中复写原类的方法，如果要重写 请使用继承
 解决这个警告的方法
 1、插入这段代码
 #pragma clang diagnostic push
 #pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
  方法
 #pragma clang diagnostic pop
 
 why?
 
 2、在target的Build Settings下搜索other warning flags，然后给其添加 -Wno-objc-protocol-method-implementation
 这个方法对很多批量的警告很有用，而后面相关字段-Wno-objc-protocol-method-implementation，其实这个放法是在xcode中选择想屏蔽的警告，右键选择reveal in log就可以在警告详情中发现-Wobjc-protocol-method-implementation这么一个格式的字段 在-W后添加一个no-然后在用2中的方法添加到other warning flags中就可以处理大部分的警告了
 */
- (void)shareName {
    NSLog(@"对象方法");
}


@end
