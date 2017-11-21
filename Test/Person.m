//
//  Person.m
//  Test
//
//  Created by 王纪涛 on 2017/11/3.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

#import "Person.h"

@implementation Person

+(void)shareInstance {
    static Person *person = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        person = [[self alloc] init];
    });
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self name];
        [self setDate:[NSDate date]];
    }
    return self;
}

- (NSString *)name {
    return @"wang";
}

- (void)setDate:(NSDate *)date {
    _date = date;
}

@end
