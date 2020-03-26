

#import "TableViewController.h"
#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"
#import "ViewController5.h"
#import "ViewController6.h"
#import "ViewController7.h"
#import "ViewController8.h"
#import "ViewController9.h"
#import "ViewController10.h"
#import "ViewController11.h"
#import "ViewController12.h"
@interface TableViewController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime";
    //1. 动态变量控制
    //2.动态添加方法
    //3：动态交换两个方法的实现
    //4.拦截并替换方法
    //5：在方法上增加额外功能
    //6.实现字典转模型的自动转换
    //7.实现NSCoding的自动归档和解档
    //8.解救程序崩溃的三步
    //9.给分类添加一个属性
    _dataSource = @[@"动态变量控制",
                    @"动态添加方法",
                    @"动态交换两个方法的实现",
                    @"拦截并替换方法",
                    @"在方法上增加额外功能",
                    @"实现字典转模型的自动转换",
                    @"实现NSCoding的自动归档和解档",
                    @"解救程序崩溃的第一步",
                    @"给分类添加一个属性",
                    @"NSURLSession",
                    @"KVC & KVO",
                    @"xxxx"
                    ];

    self.tableView.tableFooterView = [UIView new];
    [self.tableView indexPathsForVisibleRows];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取storyBoard（Main固定，是sb的名字）
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
    
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:{
            
             //2.从storyBoard中获取控制器
            ViewController1 *oneVC = (ViewController1 *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"onevciden"];
            //3.推出
            [self.navigationController pushViewController:oneVC animated:YES];
            break;
        }
        case 1:{

            ViewController2 *twoVC = (ViewController2 *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"twovciden"];
            [self.navigationController pushViewController:twoVC animated:YES];
            
            break;
        }
        case 2:{
            
            ViewController3 *threeVC = (ViewController3 *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"threevciden"];
            [self.navigationController pushViewController:threeVC animated:YES];
            
            break;
        }
        case 3:{
            
            ViewController4 *viewController = (ViewController4 *)[mainStoryBoard instantiateViewControllerWithIdentifier:@"fourvciden"];
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
        case 4:{
            
            ViewController5 *viewController = [ViewController5 new];
            [self.navigationController pushViewController:viewController animated:YES];
            
            break;
        }
        case 5:{
            
            ViewController6 *viewController = [ViewController6 new];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 6:{
            
            
            ViewController7 *viewController = [ViewController7 new];
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case 7:{
            
            ViewController8 *fiveVC = [ViewController8 new];
            [self.navigationController pushViewController:fiveVC animated:YES];
            break;
        }
        case 8:{
            
            ViewController9 *fiveVC = [ViewController9 new];
            [self.navigationController pushViewController:fiveVC animated:YES];
            break;
        }
        case 9:{
           
           ViewController10 *fiveVC = [ViewController10 new];
           [self.navigationController pushViewController:fiveVC animated:YES];
           break;
       }
        case 10:{
                      
          ViewController11 *fiveVC = [ViewController11 new];
          [self.navigationController pushViewController:fiveVC animated:YES];
          break;
      }
        case 11:{
                  
          ViewController12 *fiveVC = [ViewController12 new];
          [self.navigationController pushViewController:fiveVC animated:YES];
          break;
      }

            
        default:
            break;
    }
}

@end
