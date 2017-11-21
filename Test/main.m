//
//  main.m
//  Test
//
//  Created by 王纪涛 on 2017/10/25.
//  Copyright © 2017年 王纪涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Person.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSLog(@"22222222");
        
        
        __weak Person *p1 = [[Person alloc] init];
        p1.nameStr = @"zhangsan";
        
        Person *p2 = [[Person alloc] init];
        p2.nameStr = @"lisi";
        
        NSLog(@"%p-------%p",p1,p2);
        NSLog(@"%p=======%p",p1.nameStr,p2.nameStr);
        NSLog(@"%@=======%@",p1.nameStr,p2.nameStr);
        
        /*
        0x0-------0x600000036540
        0x0=======0x109ed6
        (null)=======lisi
         */
        
        __weak Person *p3 = p2;
        
        NSLog(@"%p++++++++%p",p2,p3);
        NSLog(@"%@********%@",p2.nameStr,p3.nameStr);
        
        /*
         0x604000223a80++++++++0x604000223a80
         lisi********lisi
         */
        
        __weak Person *p4;
        {//strong 类型只在{}中有效
            Person *p5 = [[Person alloc] init];
            p5.nameStr = @"wangwu";
            p4 = p5;
            NSLog(@"%p++++++++%p",p4,p5);
            NSLog(@"%@********%@",p4.nameStr,p5.nameStr);
        }
        NSLog(@"%p=========%@",p4,p4.nameStr);
        
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
