//
//  MyVC.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "MyVC.h"
#import "MyCell.h"

@interface MyVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView * tableview;
@property(nonatomic,strong) NSArray * lists;

@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    _lists = @[@"设置",@"IP",@"其他"];
    
    [self buildTableview];
     
}

-(void)buildTableview{
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    //高度自适应
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
@end
