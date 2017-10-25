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
@interface DiaryVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) NSArray * lists;

@end

@implementation DiaryVC
 



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.view.backgroundColor = [UIColor grayColor];
    
    [self buildTableview];
    
    [self requestData];
}

-(void)requestData{
    
    // http://192.168.10.120//My2017/ZYMySqlite/api.php?method=requestDiaryList
    
    NSString * mainUrl  = @"//My2017/ZYMySqlite/api.php?method=requestDiaryList";
    
    __weak typeof(self) vc = self;
    [[NetworkTool sharedTool] zyRequestWithURL:mainUrl method:@"GET" parameters:nil success:^(id response) {
        
        NSLog(@"respnose:%@",response);
        
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
    //高度自适应
    _tableview.estimatedRowHeight = 140;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    [_tableview registerClass:[ZyDiaryCell class] forCellReuseIdentifier:@"ZyDiaryCell"];
    //添加刷新
//    __weak
    _tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
   
        [self requestData];
    }];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  _lists.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ZyDiaryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ZyDiaryCell"];
    
    [cell updateCellModel:_lists[indexPath.section]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}



@end
