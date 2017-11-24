//
//  Person+Category.h
//  Test
//
//  Created by 王纪涛 on 2017/11/3.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

//类扩展可以声明私有方法

//扩展 Category和Extension的区别 http://www.cocoachina.com/ios/20170502/19163.html

#import "Person.h"

@interface Person (Category)
/*
 可以添加属性，只不过@property只会生成setter和getter的声明，不会生成setter和getter的实现以及成员变量。
 
 注意：类别不能扩充成员变量 原因
 Objective-C类是由Class类型来表示的，它实际上是一个指向objc_class结构体的指针。它的定义如下：

 typedef struct objc_class *Class;
 objc_class结构体的定义如下：
 
 struct objc_class {
 Class isa  OBJC_ISA_AVAILABILITY;
 #if !__OBJC2__
 Class super_class                       OBJC2_UNAVAILABLE;  // 父类
 const char *name                        OBJC2_UNAVAILABLE;  // 类名
 long version                            OBJC2_UNAVAILABLE;  // 类的版本信息，默认为0
 long info                               OBJC2_UNAVAILABLE;  // 类信息，供运行期使用的一些位标识
 long instance_size                      OBJC2_UNAVAILABLE;  // 该类的实例变量大小
 struct objc_ivar_list *ivars            OBJC2_UNAVAILABLE;  // 该类的成员变量链表
 struct objc_method_list **methodLists   OBJC2_UNAVAILABLE;  // 方法定义的链表
 struct objc_cache *cache                OBJC2_UNAVAILABLE;  // 方法缓存
 struct objc_protocol_list *protocols    OBJC2_UNAVAILABLE;  // 协议链表
 #endif
 } OBJC2_UNAVAILABLE;
 在上面的objc_class结构体中，ivars是objc_ivar_list（成员变量列表）指针；methodLists是指向objc_method_list指针的指针。在Runtime中，objc_class结构体大小是固定的，不可能往这个结构体中添加数据，只能修改。所以ivars指向的是一个固定区域，只能修改成员变量值，不能增加成员变量个数。methodList是一个二维数组，所以可以修改*methodLists的值来增加成员方法，虽没办法扩展methodLists指向的内存区域，却可以改变这个内存区域的值（存储的是指针）。因此，可以动态添加方法，不能添加成员变量。
 */
@property (nonatomic,copy) NSString *newProperty;

+(void)shareName;

@end
