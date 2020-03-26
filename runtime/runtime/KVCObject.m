//
//  KVCObject.m
//  runtime
//
//  Created by 王玉峥 on 2020/3/25.
//  Copyright © 2020 SF. All rights reserved.
//

#import "KVCObject.h"

@interface KVCObject ()
/* 成员变量 name2*/
{
    /*验证赋值顺序*/
    NSString *_name2;
    NSString *_isName2;
    NSString *name2;
    NSString *isName2;
    
    
    /* */
    NSString *_name6;
    NSString *_isName6;
    NSString *name6;
    NSString *isName6;
}
@end

@implementation KVCObject

-(void)setNilValueForKey:(NSString *)key{
    NSLog(@"开发者通过KVC对【 %@ 】成员变量设置了 nil",key);
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
      NSLog(@"开发者【 %@ 】未定义、且调用了KVC",key);
}

-(void)printName2{
    
    NSLog(@"_name2 :%@ ",self->_name2);
    NSLog(@"_isName2 :%@ ",self->_isName2);
    NSLog(@"name2 :%@ ",self->name2);
    NSLog(@"isName2 :%@ ",self->isName2);
}


//+(BOOL)accessInstanceVariablesDirectly
//- (id)valueForUndefinedKey:(NSString *)key
@end
