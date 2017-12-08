//
//  HomePageVC.m
//  Diary
//
//  Created by 配得好 on 2017/10/26.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "HomePageVC.h"
#import "HPViewModel.h"
#import "MyDiaryCell.h"
#import "MeDiaryModel.h"


#define SCREEN_W ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height)
@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) HPViewModel * hpViewmodel;
@property(nonatomic) UITableView * tableview;
@property(nonatomic) NSInteger pageIndex;

@property(nonatomic) NSArray * arrays;

@end      

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _hpViewmodel = [[HPViewModel alloc]init];
    
    [self buildTableview];
    
    [self requestListFrfresh:YES];
}
 
-(void)requestListFrfresh:(BOOL)refresh{
    
    NSDictionary * params =  [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"self", @"2",@"u_id",nil]; // @{@"self":@"1",@"u_id":@"2"};
    [[NetworkTool sharedTool] zyRequestWithURL:@"/My2017/ZYMySqlite/api.php?method=requestDiaryList" method:@"POST" parameters:params success:^(id response) {
        
        NSLog(@"结果-----%@",response);
        _arrays = [NSArray yy_modelArrayWithClass:[MeDiaryModel class] json:response[@"lists"]];
//        _arrays = [MeDiaryModel yy_modelWithJSON:response[@"lists"]];
        [_tableview reloadData];
        
    } failure:^(NSString *errorStr) {
        
    }];
    
}


-(void)buildTableview{
    
    _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableview.estimatedRowHeight  = UITableViewAutomaticDimension;
    _tableview.rowHeight = 150;
    [self.view addSubview:_tableview];
    [_tableview registerClass:[MyDiaryCell class] forCellReuseIdentifier:@"MyDiaryCell"];
} 


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrays.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyDiaryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyDiaryCell" forIndexPath:indexPath];
    
    [cell updateCellModel:_arrays[indexPath.row]];
    
    return cell;
}



@end
