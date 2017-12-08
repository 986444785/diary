//
//  DiaryVC.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
// 
  
#import "DiaryVC.h"
#import "MJRefresh.h"
#import "ZyDiaryCell.h"
#import "DiaryDetailVC.h"
#import "WriteVC.h"
@interface DiaryVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) NSArray * lists;

@end

@implementation DiaryVC
 



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = SUBJECT_BGCOLOR;
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发布" WithTitleColor:[UIColor redColor] withFont:15 target:self action:@selector(writeDiary)];
    
    [self buildTableview]; 
    
    [self requestData];  
}

-(void)writeDiary{
    
    WriteVC * vc = [[WriteVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


 
-(void)requestData{
    
    // http://192.168.10.120//My2017/ZYMySqlite/api.php?method=requestDiaryList
    
    NSString * mainUrl  = @"//My2017/ZYMySqlite/api.php?method=requestDiaryList";
    
    __weak typeof(self) vc = self; 
    [[NetworkTool sharedTool] zyRequestWithURL:mainUrl method:@"POST" parameters:@{@"u_id":@"2"} success:^(id response) {
        
//        NSLog(@"respnose:%@",response);
        
        NSLog(@"数据 :%@",response[@"msg"]);
        
         
        [_tableview.mj_header endRefreshing];
        vc.lists  =[NSArray yy_modelArrayWithClass:[dModel class] json:response[@"lists"]];
        
        [vc.tableview reloadData];
        
         
    } failure:^(NSString *errorStr) {
        NSLog(@"%@",errorStr);
        
           [_tableview.mj_header endRefreshing];
    }];
} 

 
-(void)buildTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    _tableview.backgroundColor = SUBJECT_BGCOLOR;
    _tableview.tableFooterView = [[UIView alloc]init];
    //高度自适应
    _tableview.estimatedRowHeight = 140;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[ZyDiaryCell class] forCellReuseIdentifier:@"ZyDiaryCell"];
    
  
    //添加刷新
//    __weak
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
   
        [self requestData];
    }];
     

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 1;
    return _lists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZyDiaryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZyDiaryCell"];
    
   __block dModel * model = _lists[indexPath.row];
    [cell updateCellModel:model];
   
    cell.collectButton = ^(NSString *collect) {
        NSLog(@"收藏   %@",collect);
        
        [self collectRequest:model];
    };
    
    return cell;
}

 
-(void)collectRequest:(dModel *)model{
    
    NSString * mainUrl  = @"//My2017/ZYMySqlite/api.php?method=selectLikes";
    NSDictionary * params = @{@"p_id":model.id,@"u_id":model.userid};
    [[NetworkTool sharedTool] zyRequestWithURL:mainUrl method:@"POST" parameters:params success:^(id response) {
        
        NSLog(@"respnose:%@",response);
        
        if ([response[@"success"] integerValue]==1) {  //
            [SVProgressHUD showSuccessWithStatus:response[@"msg"]];
        }else{
            [SVProgressHUD showErrorWithStatus:response[@"msg"]];
        }
        
        //推迟1.5秒后进行
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
      
    } failure:^(NSString *errorStr) {
        NSLog(@"%@",errorStr);
        
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
    DiaryDetailVC * vc  = [[DiaryDetailVC alloc]init];
    vc.hidesBottomBarWhenPushed  = YES;
    vc.model = _lists[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


@end
