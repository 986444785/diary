//
//  DiaryDetailVC.m
//  Diary
//
//  Created by 配得好 on 2017/10/26.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "DiaryDetailVC.h"
//#import "UserModel.h"
#import "DContentCell.h"
#import "GSKSpotyLikeHeaderView.h"
#import "MoreVC.h"  

@interface DiaryDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic) UITableView * tableview;
@property(nonatomic)  GSKSpotyLikeHeaderView * headerView;
@end

@implementation DiaryDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    // Do any additional setup after loading the view.
    [self buildTableview];
    
    [self requestData];
}

//http://192.168.1.136/My2017/ZYMySqlite/api.php?method=userInfo&u_id=4

-(void)requestData{
    
    __weak typeof(self) vc = self;
    //获取个人信息
    [[NetworkTool sharedTool] zyRequestWithURL:@"/My2017/ZYMySqlite/api.php?method=userInfo" method:@"GET" parameters:@{@"u_id":self.model.userid} success:^(id response) {
        NSLog(@"response:%@",response);
        
        [vc.headerView updateHeadviewWithmodel:[UserModel yy_modelWithDictionary:response[@"user"]]];
        
    } failure:^(NSString *errorStr) {
        
    }];
    
} 


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self gsk_setNavigationBarTransparent:YES animated:NO];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}
 
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self gsk_setNavigationBarTransparent:NO animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)gsk_setNavigationBarTransparent:(BOOL)transparent
                               animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.33 : 0 animations:^{
        if (transparent) {
            [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                          forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [UIImage new];
            self.navigationController.navigationBar.translucent = YES;
            self.navigationController.view.backgroundColor = [UIColor clearColor];
            self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
        } else {
            [self.navigationController.navigationBar setBackgroundImage:nil
                                                          forBarMetrics:UIBarMetricsDefault];
        } 
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
    _tableview.backgroundColor = SUBJECT_BGCOLOR;
    _tableview.tableFooterView = [[UIView alloc]init];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableview registerClass:[DContentCell class] forCellReuseIdentifier:@"DContentCell"];
    
      
    //头部的view 
    _headerView = [[GSKSpotyLikeHeaderView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 240)];
//    [headerView updateHeadviewWithmodel:self.model];
    [_tableview addSubview:_headerView];
    //    headerView.contentShrinks  =  true ;
    //    headerView.contentExpands  =  false ; //如果要在标题视图下方显示refreshControl，则很有用
}
 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
} 

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DContentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DContentCell"];
    
    [cell updateCell:_model.diary];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MoreVC * vc = [[MoreVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
 
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
