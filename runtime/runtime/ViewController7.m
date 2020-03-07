

#import "ViewController7.h"
#import "Movie.h"


@implementation ViewController7

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    Movie *m = [Movie new];
    m.movieName = @"aaaaaaaa";
    m.movieId = @"1222331";
    m.pic_url = @"llllllllll";
    
    NSString *document  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filePath = [document stringByAppendingString:@"/123.txt"];
    
    //模型写入文件
    [NSKeyedArchiver archiveRootObject:m toFile:filePath];
    
    
   //读取
    Movie *movie =  [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    NSLog(@"----%@",movie);
    
   
}



@end
