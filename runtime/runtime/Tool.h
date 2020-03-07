
#import <Foundation/Foundation.h>

@interface Tool : NSObject

+ (instancetype)sharedManager;

- (NSString *)changeMethod;
- (void)addCount;
@end
