//
//  KVCObject.h
//  runtime
//
//  Created by 王玉峥 on 2020/3/25.
//  Copyright © 2020 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"


@interface KVCObject : NSObject
/* property 声明name*/
@property (nonatomic,copy)NSString *name1;

/* property 非对象类型*/
@property (nonatomic,assign)NSInteger age;


@property (nonatomic,strong)Person *teacher;

/* name2 没有暴露出来，提供一个打印name2 的方法*/
-(void)printName2;
@end


