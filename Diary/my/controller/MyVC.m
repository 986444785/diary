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
@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) NSArray * lists;

@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = SUBJECT_BGCOLOR;
    _lists = @[@"设置",@"IP",@"其他"];
    
    [self buildTableview];
      
}

-(void)buildTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    //高度自适应
    _tableview.backgroundColor = SUBJECT_BGCOLOR;
    _tableview.tableFooterView = [[UIView alloc]init];
    _tableview.estimatedRowHeight = 140;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    [_tableview registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _lists.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    [cell updateCellStr:_lists[indexPath.row]];
    
    return cell;
}
  
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        IPViewController * ipvc = [[IPViewController alloc]init];
        ipvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:ipvc animated:YES];
        
    }else if (indexPath.row == 0){
        
        //写日记
        WriteVC * writevc = [[WriteVC alloc]init];
        writevc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:writevc animated:YES];
        
    } 
}




@end
