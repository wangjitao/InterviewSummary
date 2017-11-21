//
//  Person+Category.m
//  Test
//
//  Created by 王纪涛 on 2017/11/3.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

#import "Person+Category.h"

@implementation Person (Category)

+(void)load {
    NSLog(@"333333");
}

+ (void)shareName {
    NSLog(@"类方法");
}

- (void)shareName {
    NSLog(@"对象方法");
}

@end
