//
//  DiaryVC.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
// 
 
#import "DiaryVC.h"
#import "dModel.h"
@interface DiaryVC ()
@property(nonatomic,strong) NSArray * lists;
@end

@implementation DiaryVC
 



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor grayColor];
}

-(void)requestData{
    
    NSString * mainUrl  = @"http://192.168.100.42//My2017/ZYMySqlite/api.php?method=requestDiaryList";
    
    __weak typeof(self) vc = self;
    [[NetworkTool sharedTool] zyRequestWithURL:mainUrl method:@"GET" parameters:nil success:^(id response) {
        
        NSLog(@"respnose:%@",response);
        
        NSLog(@"数据 :%@",response[@"msg"]);
         
        //        vc.lists = response[@"lists"];
        
        vc.lists  =[NSArray yy_modelArrayWithClass:[dModel class] json:response[@"lists"]];
        
        
    } failure:^(NSString *errorStr) {
        NSLog(@"%@",errorStr);
    }];
}


@end
