//
//  Student+AvoidCrash.m
//  runtime
//
//  Created by 王玉峥 on 2020/3/6.
//  Copyright © 2020 SF. All rights reserved.
//

#import "Student+AvoidCrash.h"
#import <objc/runtime.h>
#import "StudentTool.h"

@implementation Student (AvoidCrash)

/* 第一步*/
///*解救程序崩溃的第一个方法*/
+(BOOL)resolveInstanceMethod:(SEL)sel{

    if (sel == @selector(instance_doSomething1)) {
        class_addMethod(self, sel, (IMP)customerInstancePlayMusic, "v@:");
        return YES;
    }
    return  [super resolveInstanceMethod:sel];
}

/*  我这里起个新名字，实现了Student 对象崩溃的 instancePlayMusic 方法 */
void customerInstancePlayMusic(id self,SEL _cmd){
    NSLog(@"Instance implementation instance_doSomething1");
}



+(BOOL)resolveClassMethod:(SEL)sel{
    if (sel == @selector(class_doSomething1)) {
        NSString *className = NSStringFromClass([self class]);
        Class metaClass = objc_getMetaClass("Student");
        class_addMethod(metaClass, sel, (IMP)customerClassPlayMusic, "v@:");
        return YES;
    }
    return  [super resolveClassMethod:sel];
}

void customerClassPlayMusic(id self,SEL _cmd){
    NSLog(@"Class implementation class_doSomething1");
}



/* 第一步没有实现，实现第二步解救程序崩溃*/
/* 实例方法的消息转发*/
-(id)forwardingTargetForSelector:(SEL)aSelector
{
    return [StudentTool new];
}


/* 类方法的消息转发*/
+ (id)forwardingTargetForSelector:(SEL)aSelector
{
    return [StudentTool class];
}



/* 第一、二步没有实现，通过第三步来解决程序异常崩溃*/
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if (aSelector == @selector(instance_doSomething3)) {
        NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
        if (!methodSignature) {
            /* 如果 StudentTool 这个类能相映这个 崩溃方法，就交给 StudentTool 来响应*/
            if ([StudentTool instancesRespondToSelector:aSelector]) {
                methodSignature = [StudentTool instanceMethodSignatureForSelector:aSelector];
            }
        }
        return methodSignature;
    }
    return nil;
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector == @selector(doSomething3:)) {
        StudentTool *instance = [StudentTool new];
        if ([instance respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:instance];
        }
    }
}





@end
