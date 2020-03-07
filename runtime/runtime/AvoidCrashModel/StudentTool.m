//
//  StudentTool.m
//  runtime
//
//  Created by 王玉峥 on 2020/3/6.
//  Copyright © 2020 SF. All rights reserved.
//

#import "StudentTool.h"

@implementation StudentTool

/* 实现了Student 的实例2 ，和类方法2 */
-(void)instance_doSomething2{
    NSLog(@" StudentTool 实现了实例 方法 instance_doSomething2");
}

+(void)class_doSomething2{
    NSLog(@" StudentTool 实现了类 方法 class_doSomething2");
}


/* 实现了Student 的实例3方法 ，和类方法3 */
-(void)instance_doSomething3{
    NSLog(@" StudentTool 实现了实例 方法 instance_doSomething3 xxxx");
}

+(void)class_doSomething3{
    NSLog(@" StudentTool 实现了类 方法 class_doSomething3 xxxx");
}

@end
