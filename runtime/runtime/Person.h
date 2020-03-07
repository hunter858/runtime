

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *sex;
-(NSString *)sayName;
-(NSString *)saySex;
-(void)updatePrivateName:(NSString *)name;
+(void)PersonSayHello;

@end
