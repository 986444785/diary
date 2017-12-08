//
//  otherVC.m
//  Diary
//
//  Created by 配得好 on 2017/11/2.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "otherVC.h"
#import "ZYTopView.h"

//#define Xsize(__size) SCREEN_WIDTH * (__size)/375



@interface otherVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;

@end

@implementation otherVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor  =[UIColor whiteColor];
    
    [self buildTableview];

    [self buildTopView];
}
 

-(void)buildTopView{

    
    UILabel * topview = [UILabel new];
    topview.backgroundColor = [UIColor blueColor];
    [self.view addSubview:topview];
 
    topview.frame = CGRectMake(0, 0, KSCREEN_WIDTH, 64);
    topview.text = @"订单详情";
    topview.textColor = [UIColor whiteColor];
    topview.textAlignment = NSTextAlignmentCenter;
    
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
    _tableview.backgroundColor = SUBJECT_BGCOLOR;
    _tableview.tableFooterView = [[UIView alloc]init];
    //高度自适应
    _tableview.estimatedRowHeight = 140;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
 
//    2.03  
    ZYTopView * headView=  [[ZYTopView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREEN_WIDTH * (200.00)/375)];
    [headView hadInfoQianyuePrice:@"888.99" tichengPrice:@"665544" orderNumber:@"2017"];
//    [headView noInfoOrderNumber:@"2017"];

    _tableview.tableHeaderView = headView;
    

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"这是  %ld",indexPath.row];
    return cell;


}





@end
