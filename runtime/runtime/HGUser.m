

#import "HGUser.h"

@implementation HGUser

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@--%@--%@--", _name, _age, _sex];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.uid = value;
    }
}
@end
