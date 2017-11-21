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

@interface Person : NSObject

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readwrite) NSDate *date;

@property (nonatomic,weak) id <TopButDelegate> delegate;

+(void)shareInstance;

//strong weak 赋值给weak变量后这块内存会马上被释放。而分配给strong变量的会等到这个变量的生命周期结束后，这块内存才被释放
@property (nonatomic,copy) NSString *nameStr;

@end
