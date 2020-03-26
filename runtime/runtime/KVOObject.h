//
//  AnimalClass.h
//  runtime
//
//  Created by 王玉峥 on 2020/3/25.
//  Copyright © 2020 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOObject : NSObject

/* 1。 age 不重写set 方法*/
@property (nonatomic,assign)NSInteger age;

/* 2.name 重写set方法 且手动触发*/
@property (nonatomic,copy)NSString *name;

/* 3.address 重写set方法，不手动触发*/
@property (nonatomic,copy)NSString *address;

/* 4.自定义方法调用 willChangeValueForKey didChangeValueForKey 不赋值的情况*/
-(void)KVOtrigger;

@end


