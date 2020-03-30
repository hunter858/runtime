#### 1.通过runtime 获取成员变量列表、属性列表、方法列表～等

举例说明，我们定义一个`Person`类，`在一个ViewController` 调用，获取该类的成员变量，属性列表，方法列表


定义`Person类`如下
```
#import <Foundation/Foundation.h>

@interface Person : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *sex;
-(NSString *)sayName;
-(NSString *)saySex;
-(void)updatePrivateName:(NSString *)name;
@end

//--------------------------------------

#import "Person.h"

/* Person.m 的实现
这里我对Person 进行了Class Extension
为了说明，属性和成员变量是两种不同的东西 */
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

/* 调用扩展属性必须的 -> 函数*/
-(void)updatePrivateName:(NSString *)name{
    self ->privateName = name;
    NSLog(@"NSLog privateName Value is %@",self->privateName);
}

/* 私有方法*/
-(void)private_func{
    NSLog(@"privte function");
}

@end
```

然后在`ViewController` 引入`Person`，并创建一个对象，展示代码如下，应该都能看得懂；
上面`Person` 的定义还能延伸一下 `Category`  和`Extension`的区别， 以及`@Property` 自动帮我们实现了`Set 、Get` 方法;

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.person = [Person new];
    _person.name = @"big pengpeng";
    self.person.sex = @"man";
    /* 调用方法*/
    [self getPropertyList];
    [self getMethodList];
    [self getIvarList];
    /* 延伸，扩展属性的调用*/
    [self.person updatePrivateName:@"pengpeng"];
}
```




#### 1.1 获取属性列表
```
/* 获取属性列表*/
-(void)getPropertyList{
    
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &count);
    for (unsigned int i=0; i<count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
}
   
/* 运行结果*/   
runtime[41582:1275679] property---->name
runtime[41582:1275679] property---->sex
   
```

#### 1.2 获取方法列表
```
/* */
-(void)getMethodList{
    unsigned int count;
    Method *methodList = class_copyMethodList([Person class], &count);
    for (unsigned int i; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
}

/* 运行结果*/  
runtime[41582:1275679] method---->sayName
runtime[41582:1275679] method---->saySex
runtime[41582:1275679] method---->updatePrivateName:
runtime[41582:1275679] method---->private_func
runtime[41582:1275679] method---->.cxx_destruct
runtime[41582:1275679] method---->name
runtime[41582:1275679] method---->setName:
runtime[41582:1275679] method---->setSex:
runtime[41582:1275679] method---->sex
```

出现这个结果应该也没有什么问题；`sayName`、`saySex`、`updatePrivateName`都是对象方法,`private_func`是私有方法；
属性`name、sex `因为是`Property`声明的默认实现了`set `和`get`方法；
`.cxx_destruct` 是ARC下将所有的成员变量变成nil的方法（系统加的）

#### 1.3 获取成员变量列表

```
/*  获取成员变量列表*/
-(void)getIvarList{
    unsigned int count;
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (unsigned int i; i<count; i++) {
        Ivar myIvar = ivarList[i];
        const char *ivarName = ivar_getName(myIvar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarName]);
    }
}

/* 运行结果*/  
runtime[45997:1632709] Ivar---->privateName
runtime[45997:1632709] Ivar---->_name
runtime[45997:1632709] Ivar---->_sex
```


#### 1.4 获取协议列表
```
/* 在该ViewController 实现一个AlertView 的代理方法*/
-(void)createAlertView{
  
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"comfirm", nil];
    [alertView show];
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
/*运行结果*/
runtime[17235:552811] protocol---->UIAlertViewDelegate
```

#### 1.5 动态给类添加方法

进入`runtime` 的头文件，可以看到`runtime` 提供了很多API 给我们使用，其中就有可以动态的给一个Class添加方法;
这里同样给`Person `类，添加一个`-(void)syGoodBye{} `方法

其实还有关于动态添加方法的另一种形势，链接如下 [链接]()

```
/* 定义一个方法*/
- (void)sayFrom
{
    
    class_addMethod([self.person class], @selector(guess), (IMP)guessAnswer, "v@:");
    if ([self.person respondsToSelector:@selector(guess)]) {
        
        [self.person performSelector:@selector(guess)];
        
    } else{
        NSLog(@"Sorry,I don't know");
    }
    self.textview.text = @"beijing";
}

void guessAnswer(id self,SEL _cmd){
    
    NSLog(@"i am from beijing");
}


/* 调用该方法*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    [self sayFrom];

}

/* 运行结果*/  
runtime[45997:1632709] i am from beijing

```



#### 1.6 方法交换
还是以`Person `对象为例子，正常情况调用Person 对象的`sayName `方法和`saySex` 都没毛病，如果我们在`load`方法或者在`viewDidLoad` 方法中，将两个方法交换，那么就能实现方法交换；

```
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
}

- (IBAction)saySex:(id)sender {
     NSLog(@"方法交换后 saySex : %@",[_person saySex]);
}
/*运行结果*/
runtime[45997:1632709] my name is pengpeng
runtime[45997:1632709] i am a boy

//方法交换后
runtime[46307:1667781] 方法交换后 sayName : i am a boy
runtime[46307:1667781] 方法交换后 saySex : my name is pengpeng

```

#### 1.7 给分类添加属性

举例，这里给`UIImageview `添加一个属性 `URLkey`；
创建一个` UIImageView+Extension 分类`;
代码如下

```
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIImageView (extension)
@property (nonatomic,copy) NSString *URLkey;
@end

//---------------------------
#import "UIImageView+extension.h"

static char * UrlKey = "imageUrlKey";

@implementation UIImageView (extension)

-(NSString *)URLkey{
    return  objc_getAssociatedObject(self, UrlKey);
}
-(void)setURLkey:(NSString *)URLkey{
    objc_setAssociatedObject(self, UrlKey, URLkey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

/* 运行 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageview = [[UIImageView alloc]init];
    imageview.URLkey = @"我是一个假的URL";
    NSLog(@" %@",imageview.URLkey);
}

/*运行结果*/
runtime[49010:1741011]  我是一个假的URL
```

#### 1.8 字典转模型
利用`runtime`完成字典转模型的功能，其实就是给 `NSObject` 扩展一个字典转模型的方法，因为所有的类都是`NSObject`的子类，获取字典内部`ivar`成员变量，字典通过成员变量对应的`Key`取出`Value `,然后把`value `赋值给模型相映的属性； 

如果属性是另一个`自定义Class`，则再次递归直到解析完毕；

如果属性是一个数组，则便利数组的每个对象循环解析处理成模型数组 赋值给相映的属性值；

```
// 字典转模型
+ (instancetype)objectWithDict:(NSDictionary *)dict
{
    // 创建对应模型对象
    id objc = [[self alloc] init];
    
    
    unsigned int count = 0;
    
    // 1.获取成员属性数组
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    // 2.遍历所有的成员属性名,一个一个去字典中取出对应的value给模型属性赋值
    for (int i = 0; i < count; i++) {
        
        // 2.1 获取成员属性
        Ivar ivar = ivarList[i];
        
        // 2.2 获取成员属性名 C -> OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 2.3 _成员属性名 => 字典key
        NSString *key = [ivarName substringFromIndex:1];
        
        // 2.4 去字典中取出对应value给模型属性赋值
        id value = dict[key];
        
        
        // 获取成员属性类型
        NSString *ivarType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        // 二级转换,字典中还有字典,也需要把对应字典转换成模型
        //
        // 判断下value,是不是字典
        if ([value isKindOfClass:[NSDictionary class]] && ![ivarType containsString:@"NS"]) { //  是字典对象,并且属性名对应类型是自定义类型
            // user User
            
            // 处理类型字符串 @\"User\" -> User
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            ivarType = [ivarType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            // 自定义对象,并且值是字典
            // value:user字典 -> User模型
            // 获取模型(user)类对象
            Class modalClass = NSClassFromString(ivarType);
            
            // 字典转模型
            if (modalClass) {
                // 字典转模型 user
                value = [modalClass objectWithDict:value];
            }
        }
        
        // 三级转换：NSArray中也是字典，把数组中的字典转换成模型.
        // 判断值是否是数组
        if ([value isKindOfClass:[NSArray class]]) {
            // 判断对应类有没有实现字典数组转模型数组的协议
            if ([self respondsToSelector:@selector(arrayContainModelClass)]) {
                
                // 转换成id类型，就能调用任何对象的方法
                id idSelf = self;
                
                // 获取数组中字典对应的模型
                NSString *type =  [idSelf arrayContainModelClass][key];
                
                // 生成模型
                Class classModel = NSClassFromString(type);
                NSMutableArray *arrM = [NSMutableArray array];
                // 遍历字典数组，生成模型数组
                for (NSDictionary *dict in value) {
                    // 字典转模型
                    id model =  [classModel objectWithDict:dict];
                    [arrM addObject:model];
                }
                
                // 把模型数组赋值给value
                value = arrM;
                
            }
        }
        
        // 2.5 KVC字典转模型
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    
    // 返回对象
    return objc;
    
}

```

#### 1.9 模型归档
我们直到 要实现自定义对象，归档和解档的功能，只需给类，实现 协议即可，但是每次都要给归档的对象写这些协议的实现，是不是有点费劲，那么今天我们来看一下runtime如何实现自动归档解档；

首先没有对比就没有伤害，我们来看之前是怎么实现归档解档的

```
/* 手动实现-没什么好说的是吧*/

@interface Movie : NSObject<NSCoding>
@property (nonatomic, copy) NSString *movieId;
@property (nonatomic, copy) NSString *movieName;
@property (nonatomic, copy) NSString *pic_url;
@end
//-----------

@implementation Movie

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.movieId forKey:@"movieId"];
    [encoder encodeObject:self.movieName forKey:@"movieName"];
    [encoder encodeObject:self.pic_url forKey:@"pic_url"];
}

- (id)initWithCoder:(NSCoder *)decoder
{ 
self.movieId = [aDecoder decodeObjectForKey:@"movieId"];
self.movieName = [aDecoder decodeObjectForKey:@"movieName"];
self.pic_url = [aDecoder decodeObjectForKey:@"pic_url"];
}

```

利用`Runtime `实现实现`Movie`对象的 自动归档和解档；

`demo` 中该实现方法写在`Moive`的 .m 文件中，实际项目中，给需要归档和解档的对象定义一个基类`BaseArchiveModel`实现该Runtime的 `- (void)encodeWithCoder:(NSCoder *)encoder`和`- (id)initWithCoder:(NSCoder *)decoder`方法自动归档接档，项目中需要归档解档的类只需继承该`BaseArchiveModel`就可以了； 
 
 ```
@implementation Movie

- (void)encodeWithCoder:(NSCoder *)encoder

{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Movie class], &count);
    
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [encoder encodeObject:value forKey:key];
    }
    free(ivars);
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Movie class], &count);
        for (int i = 0; i<count; i++) {
            Ivar ivar = ivars[i];
            const char *name = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [decoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
            
        }
        free(ivars);
    }
    return self;
}


 
 ```




项目链接 [https://github.com/hunter858/runtime](https://github.com/hunter858/runtime) 




### 2.runtime 在第三方库中的应用


#### 2.1 MJExtension 
[https://github.com/CoderMJLee/MJExtension](https://github.com/CoderMJLee/MJExtension)

[https://github.com/ibireme/YYModel](https://github.com/ibireme/YYModel)

#### 2.2 SDWebImage
[https://github.com/SDWebImage/SDWebImage](https://github.com/SDWebImage/SDWebImage)

#### AvoidCrash

[https://github.com/chenfanfang/AvoidCrash](https://github.com/chenfanfang/AvoidCrash)

未完待续，整理中...

