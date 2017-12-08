//
//  IPViewController.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "IPViewController.h"
#import "UIImage+MultiFormat.h"
//#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageDownloaderOperation.h"

@interface IPViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tx;
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@end
    
@implementation IPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ZYUserManager * manager = [ZYUserManager shareManager];
    _tx.text = manager.ip;
    
    [self circleImageView];
    
    
    
}

 
-(void)circleImageView{

 
}

- (IBAction)save:(id)sender {
    
    
//    NSDate *date = [NSDate date];

    //获取月份
    for (int i=0; i<5; i++) {
        NSString * month=  [self setupRequestMonth:(i)];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
        
        NSString * timeStr = [NSString stringWithFormat:@"%@-1 00-00-00",month];
        
        NSDate *resDate = [formatter dateFromString:timeStr];
        //    NSDate *resDate = [formatter dateFromString:@"2014-10-1 00-00-00"];
        
        NSInteger days =    [self getNumberOfDaysInMonthWithDate:resDate];
        
        
        NSLog(@"%@     天数:%ld",month,(long)days);
    }


    
    //     UIImage *image2 = [UIImage imageNamed:@"my_ip.png"];
    
    //    [self saveImage:image2];
}
- (NSString *)setupRequestMonth:(NSInteger)month
{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    //    [lastMonthComps setYear:1]; // year = 1表示1年后的时间 year = -1为1年前的日期，month day 类推
    [lastMonthComps setMonth:-month];
    NSDate *newdate = [calendar dateByAddingComponents:lastMonthComps toDate:currentDate options:0];
    NSString *dateStr = [formatter stringFromDate:newdate];
    NSLog(@"date str = %@", dateStr);
    return dateStr;
}

- (NSInteger)getNumberOfDaysInMonthWithDate:(NSDate*)CurrentDate
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSGregorianCalendar - ios 8
    //    NSDate * currentDate = [NSDate date];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay  //NSDayCalendarUnit - ios 8
                                   inUnit: NSCalendarUnitMonth //NSMonthCalendarUnit - ios 8
                                  forDate:CurrentDate];
    return range.length;
}





- (IBAction)show:(id)sender {
    
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/pic.png"];
    
    UIImage *getimage2 = [UIImage imageWithContentsOfFile:imagePath];
    
    _image2.image= getimage2;
}

#pragma mark ---- 将图片存储到本地
-(void)saveImage:(UIImage *)image{
    
    //    UIImage *image2 = [UIImage imageNamed:@"1.png"];
    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_document stringByAppendingString:@"/Documents/pic.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
}


//-(UIImage *)showImage


-(void)downLoadImage{
    
    
    NSString * url = @"http://120.24.85.236/application/statics/headimg/m225.jpeg?1510217032";
    
    _image1.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    
    //                                            NSLog(@"麻辣隔壁图片 111111-----  %@",_u_avatar);
    
//        SDWebImageManager * manager = [SDWebImageManager sharedManager] ;
//
//        [manager downloadImageWithURL:[NSURL URLWithString:url] options:0 progress:^(NSInteger   receivedSize, NSInteger expectedSize) {
//            // progression tracking code
//        }  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType,   BOOL finished, NSURL *imageURL) {
//            NSLog(@"---进来了我 222");
//            if (image) {
//                // do something with image
//                NSLog(@"有图片了 111");
////                _u_avatar = image;
//
////                NSLog(@"麻辣隔壁图片 22222-----  %@",_u_avatar);
//            }
//
//
//        }];
//
    
}









- (IBAction)changeIP:(id)sender {
    
    if (_tx.text.length < 5) {
        
        return ;
    }
    
    ZYUserManager * manager = [ZYUserManager shareManager];
    [manager saveIP:_tx.text];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
