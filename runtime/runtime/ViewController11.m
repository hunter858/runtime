//
//  ViewController11.m
//  runtime
//
//  Created by 王玉峥 on 2020/3/25.
//  Copyright © 2020 SF. All rights reserved.
//

#import "ViewController11.h"
#import "KVCObject.h"
#import "KVOObject.h"

@interface ViewController11 ()

@end

@implementation ViewController11

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self aboutKVC];
    [self aboutKVO];
}


/*关于KVC的一些实验*/
-(void)aboutKVC{
    KVCObject *kvcObj = [KVCObject new];

    [kvcObj setValue:@"name1 value is pengpeng" forKey:@"name1"];
    [kvcObj valueForKey:@"name1"];
    
    
    /* nil 值会出现异常(属性为对象属性不会)*/
    [kvcObj setValue:nil forKeyPath:@"name1"];
    
    
    /* nil 值会出现异常(属性为非对象属性会出现)*/
    [kvcObj setValue:nil forKeyPath:@"age"];
    
    
    /*  给不存在的key赋值 （导致崩溃）*/
    [kvcObj setValue:@" value" forKeyPath:@"undefineKey"];
    
    
    /* 验证 成员变量赋值顺序*/
    [kvcObj setValue:@"xxxx" forKey:@"name2"];
    [kvcObj printName2];
    
    
}


/* 关于KVO的一些实验*/
-(void)aboutKVO{
        KVOObject *animal = [KVOObject new];
    
        [animal addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        [animal addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
        [animal addObserver:self forKeyPath:@"address" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            /* 1.掉用age 和setAge 方法效果一样*/
            animal.age = 18;
            [animal setAge:18];
            
            /* 2.属性改变 会触发KVO*/
            animal.name = @"peng";
            
            /* 3.重写了被观察属性的set 方法
             如果没有手动调用
             willChangeValueForKey;
             didChangeValueForKey
             方法，则不会触发KVO*/
            [animal setName:@"peng"];
            
            
            /* 4.没有重写set 方法直接赋值会触发*/
            animal.address = @"shanghai";
           
            /* 5.KVC 的赋值也会触发KVO*/
            [animal setValue:@"KVCValue_shanghai" forKey:@"address"];
            
            /* 6.自定义方法无法触发触发*/
            [animal KVOtrigger];
        });
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    
        NSLog(@"keyPath:%@\n change:%@",keyPath,change);
    
}

@end
