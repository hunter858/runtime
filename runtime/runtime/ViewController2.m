

#import "ViewController2.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController2 ()

@property (nonatomic, strong) Person *person;
@property (weak, nonatomic) IBOutlet UITextField *textview;

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    [self sayFrom];
}

- (void)sayFrom
{
    
    class_addMethod([self.person class], @selector(guess), (IMP)guessAnswer, "v@:");
    if ([self.person respondsToSelector:@selector(guess)]) {
        //Method method = class_getInstanceMethod([self.xiaoMing class], @selector(guess));
        [self.person performSelector:@selector(guess)];
        
    } else{
        NSLog(@"Sorry,I don't know");
    }
    self.textview.text = @"beijing";
}

void guessAnswer(id self,SEL _cmd){
    
    NSLog(@"i am from beijing");
    
}
- (IBAction)answer:(id)sender {
    
    [self sayFrom];
}



@end
