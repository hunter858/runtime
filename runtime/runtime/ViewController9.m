


#import "ViewController9.h"
#import "UIImageView+extension.h"

@implementation ViewController9

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.URLkey = @"我是一个假的URL";
    NSLog(@" %@",imageview.URLkey);
    
    /* IMP 和SEL 的区别*/
    [self test_IMP_SEL];
}


-(void)test_IMP_SEL{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    SEL sel0 = @selector(method1:);
    [self performSelector:sel0 withObject:@"我是一个字符串"];
    
    
    
    
    
    SEL sel1 = @selector(voidMethod);
    SEL sel2 = @selector(method2:);
    SEL sel3 = @selector(method3:value2:);
    
    IMP imp1 = [self methodForSelector:sel1];
    IMP imp2 = [self methodForSelector:sel2];
    IMP imp3 = [self methodForSelector:sel3];
    
    
    /* 或者这种情况*/
    void (*func)(id, SEL, id) = (void *)imp2;
    func(self, sel2,@"2");


    /* 1.无参情况*/

    void (*func1)(id,SEL ) = (void *)imp1;
    func1(self, sel1);

    /* 2.一个参数的情况*/
    void (*func2)(id, SEL,id) = (void *)imp2;
    func2(self, sel2,@"2");


    /* 3.两个参数的情况*/
    void (*func3)(id, SEL,id,id) = (void *)imp3;
    func3(self, sel3 , @"33",@"44");
    
}


-(void)method1:(NSString *)value{
    NSLog(@"method1: %@",value);
}

-(void)voidMethod{
    NSLog(@"void method1");
}

-(void)method2:(NSNumber *)value{
     NSLog(@"method2: %@",value);
}

-(void)method3:(NSNumber *)value1 value2:(NSNumber *)value2{
     NSLog(@"method3: %@ -- %@",value1,value2);
}
@end
