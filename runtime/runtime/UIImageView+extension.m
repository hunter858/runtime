

#import "UIImageView+extension.h"

static char * UrlKey = "imageUrlKey";

@implementation UIImageView (extension)

-(NSString *)URLkey{
    return  objc_getAssociatedObject(self, UrlKey);
}
-(void)setURLkey:(NSString *)URLkey{
    objc_setAssociatedObject(self, UrlKey, URLkey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



@end
