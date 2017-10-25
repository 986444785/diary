//
//  WriteVC.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "WriteVC.h"
#import "UIBarButtonItem+CH.h"
@interface WriteVC ()<UITextViewDelegate>

@property(nonatomic,strong)UITextView * textView;

@end

@implementation WriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.textView.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发布" WithTitleColor:[UIColor redColor] withFont:15 target:self action:@selector(upLoad)];
    
}

-(void)upLoad{
    
    NSLog(@"内容  :%@",_textView.text);
    
    
    NSString * url  = @"//My2017/ZYMySqlite/api.php?method=writeDiary";
    
    
    NSDictionary * params = @{@"userid":@"2",@"text":@"这是从app端插入的一条数据"};
   
    [[NetworkTool sharedTool] zyRequestWithURL:url method:@"GET" parameters:params success:^(id response) {
        
        NSLog(@"respnose:%@",response);
        
        NSLog(@"数据 :%@",response[@"msg"]);
    
    } failure:^(NSString *errorStr) {
        NSLog(@"errorStr:%@",errorStr);
    }];
    
    
    
}





-(void)textViewDidChange:(UITextView *)textView{
    

    
}


-(UITextView *)textView{
    if (!_textView) {
        
        _textView = [UITextView new];
        [self.view addSubview:_textView];
        _textView.frame = self.view.bounds;
        _textView.delegate = self;
    }
    return _textView;
}

@end
