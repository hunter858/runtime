//
//  AnimalClass.m
//  runtime
//
//  Created by 王玉峥 on 2020/3/25.
//  Copyright © 2020 SF. All rights reserved.
//

#import "KVOObject.h"

@implementation KVOObject

/* 重写被观察者属性的 name 属性*/
-(void)setName:(NSString *)name{
    NSLog(@"setName:");
    [self willChangeValueForKey:@"name"];
    [self didChangeValueForKey:@"name"];
}

- (void)setAddress:(NSString *)address{
    NSLog(@"setAddress:");
    _address = address;
}

-(void)KVOtrigger{
    NSLog(@"KVOtrigger");
    [self willChangeValueForKey:@"name"];
    [self didChangeValueForKey:@"nama"];
}
@end
