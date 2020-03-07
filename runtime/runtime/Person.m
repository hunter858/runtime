

#import "Person.h"
@interface Person ()
{
    NSString *privateName;
}
@end


@implementation Person

- (NSString *)saySex
{
    return @"i am a boy";
}
- (NSString *)sayName
{
    return @"my name is pengpeng";
}

-(void)updatePrivateName:(NSString *)name{
    self ->privateName = name;
    NSLog(@"NSLog privateName Value is %@",self->privateName);
}

/* 私有方法*/
-(void)private_func{
    NSLog(@"privte function");
}

+(void)PersonSayHello{
    NSLog(@"say hello");
}

@end
