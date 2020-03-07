

#import "ViewController3.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController3 ()

@property (nonatomic, strong) Person *person;
@property (weak, nonatomic) IBOutlet UITextField *textview;

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    
    NSLog(@"%@",_person.sayName);
    
    NSLog(@"%@",_person.saySex);
    
    Method m1 = class_getInstanceMethod([self.person class], @selector(sayName));
    Method m2 = class_getInstanceMethod([self.person class], @selector(saySex));
    
    method_exchangeImplementations(m1, m2);
}

- (IBAction)sayName:(id)sender {
    
    NSLog(@"方法交换后 sayName : %@",[_person sayName]);
//    self.textview.text = [_person sayName];
    
}
- (IBAction)saySex:(id)sender {
    NSLog(@"方法交换后 saySex : %@",[_person saySex]);
    self.textview.text = [_person saySex];;
}

@end
