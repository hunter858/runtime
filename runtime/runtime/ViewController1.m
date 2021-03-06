

#import "ViewController1.h"
#import "Person.h"
#import <objc/runtime.h>

@interface ViewController1 ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (nonatomic, strong) Person *person;
@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [Person new];
    _person.name = @"big pengpeng";
    self.person.sex = @"man";
/* 获取属性列表*/
    [self getPropertyList];
/* 获取方法列表*/
    [self getMethodList];
/* 获取成员变量列表*/
    [self getIvarList];
/* 获取协议列表*/
    [self getProtocolList];
/* 获取类方法*/
    [self getClassMethod];
/* 获取实例方法*/
    [self getInstanceMethod];
//
/* 类扩展属性的调用*/
    [self.person updatePrivateName:@"pengpeng"];


/* 获取协议列表*/
    [self createAlertView];
}



/* 获取属性列表*/
-(void)getPropertyList{
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
}

-(void)getMethodList{
    unsigned int count;
    Method *methodList = class_copyMethodList([Person class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
}


-(void)getIvarList{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
}



-(void)getProtocolList{
    unsigned int count;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}

/* 获取类方法*/
-(void)getClassMethod{
    Class ClassName = object_getClass([Person class]);
    SEL SELMethod = @selector(PersonSayHello);
    Method oriMethod = class_getClassMethod(ClassName, SELMethod);
    //Person 类方法 PersonSayHello
    [Person resolveClassMethod:@selector(SELMethod)];
    
}


/*获取实例方法*/
-(void)getInstanceMethod{
    Class ClassName = object_getClass([Person class]);
    SEL SELMethod = @selector(sayName);
    Method cusMethod = class_getInstanceMethod(ClassName, SELMethod);
//    [Person resolveInstanceMethod:@selector(cusMethod)];
    /*
     该方法获得的Method 只是名称，并不是l实例的 实现方法，贸然m调用会引起崩溃
     例如: 这样会崩溃
     [self.person performSelector:@selector(SELMethod) withObject:nil];
     */
     /*
     class_getMethodImplementation  返回的是IMP 方法
     */
    
//    IMP instanceIMP = class_getMethodImplementation(ClassName,SELMethod);
//    [self.person insta];
//    [self.person performSelector:@selector(instanceIMP) withObject:nil];

    
}

- (void)sayName
{
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self.person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *proname = [NSString stringWithUTF8String:varName];
        
        if ([proname isEqualToString:@"_name"]) {   //这里别忘了给属性加下划线
            object_setIvar(self.person, var, @"daming");
            break;
        }
    }
    NSLog(@"XiaoMing change name  is %@",self.person.name);
    self.textfield.text = self.self.person.name;
}

-(void)createAlertView{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"comfirm", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"select index %ld",buttonIndex);
}

- (IBAction)changename:(id)sender {
    [self sayName];
}

@end
