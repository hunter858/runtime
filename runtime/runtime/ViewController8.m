

#import "ViewController8.h"
#import "Student.h"
#import "Student+AvoidCrash.h"


@interface ViewController8 ()

@end

@implementation ViewController8

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    Student *studentOBJ = [Student new];
    /* 分别调用实例方法和类方法使程序崩溃*/
    /* 在第一步解救程序*/
    [studentOBJ instance_doSomething1];
    [Student class_doSomething1];

    /* 在第二步解救程序*/
    [studentOBJ instance_doSomething2];
    [Student class_doSomething2];

    /* 在第三步解救程序*/
    [studentOBJ instance_doSomething3];
    [Student class_doSomething3];
}



@end
