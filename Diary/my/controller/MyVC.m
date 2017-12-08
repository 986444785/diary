//
//  MyVC.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "MyVC.h"
#import "MyCell.h"
#import "IPViewController.h"
#import "WriteVC.h"
#import "otherVC.h"
#import "PersonalVC.h"

//#import "WRCustomNavigationBar.h"
#import "WRNavigationBar.h"
#import "MyViewModel.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64

@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) NSArray * lists;

@property(nonatomic) MyViewModel * myviewmodel;
@property(nonatomic) ZYTabHeaderView * headerView;

@end
 
@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = SUBJECT_BGCOLOR;
    
    _lists =@[@[@{@"title":@"个人资料",@"icon":@"my_data"}],@[@{@"title":@"IP",@"icon":@"my_ip"},@{@"title":@"设置",@"icon":@"my_set"},@{@"title":@"其他",@"icon":@"my_set"}]];

    [self buildTableview];  
    
    // 设置导航栏颜色
    [self wr_setNavBarBarTintColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];

    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];

    // 设置导航栏按钮和标题颜色 
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
    //获取详情
    [self.myviewmodel requestUserInfoWithHeaderView:_headerView];
}

-(MyViewModel *)myviewmodel{
    if (_myviewmodel == nil) {
        _myviewmodel = [[MyViewModel alloc]init];
        
    }
    return _myviewmodel;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"wangrui460";
    }
    else
    {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
    }
}




-(void)buildTableview{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, KSCREEN_WIDTH, self.view.frame.size.height+64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    //高度自适应
    _tableview.backgroundColor = SUBJECT_BGCOLOR;
    _tableview.tableFooterView = [[UIView alloc]init];
    _tableview.estimatedRowHeight = 140;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    [_tableview registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
    
    
    __weak typeof(self) vc = self;
    //添加头部 
     _headerView = [[ZYTabHeaderView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 200)];
    _tableview.tableHeaderView = _headerView;
  
    _headerView.headerActor = ^(NSString *str) {
//          NSLog(@"头像点击了");
        
        [vc.myviewmodel my_actionDelegate:vc];
    };

} 
  
#pragma mark --更新头像UI
-(void)updateMyHeaderImageView:(UIImage *)image{
    [_headerView updateHeaderImageView:image];
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 15)];
    return view;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _lists.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSArray * arrays = _lists[section];
    return arrays.count;
}
 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    NSArray * arrays = _lists[indexPath.section];
    
    [cell configDictionary:arrays[indexPath.row]];
    
    return cell;
}
  
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        //写日记
        WriteVC * writevc = [[WriteVC alloc]init];
        writevc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:writevc animated:YES];
    }else if (indexPath.section == 1){
       
        if (indexPath.row == 0) {
            IPViewController * ipvc = [[IPViewController alloc]init];
            ipvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ipvc animated:YES];
             
            
        }else if (indexPath.row == 1){
            otherVC * vc = [[otherVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
            
        } else if (indexPath.row == 2){
            
            PersonalVC * vc = [[PersonalVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];

         
        }else if (indexPath.row == 2){
            
        
            
        }
    }
}






@end
