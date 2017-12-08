//
//  WriteVC.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "WriteVC.h"
#import "TextViewTools.h"

@interface WriteVC ()<UITextViewDelegate>

@property(nonatomic,strong)TextViewTools * textView;

@end

@implementation WriteVC

- (void)viewDidLoad { 
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = SUBJECT_BGCOLOR;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"发布" WithTitleColor:[UIColor redColor] withFont:15 target:self action:@selector(upLoad)];

    
     _textView = [[TextViewTools alloc] init];
    [_textView setFont:[UIFont systemFontOfSize:14]];
    [_textView setTextColor:[UIColor blackColor]];
//    [topView addSubview:text];
    [self.view addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(64+5);
        make.right.equalTo(self.view).offset(-8);
        make.height.mas_offset(182);
    }];
    _textView.placeHolderText = @"写下这一刻的感受~";
    
   
}

-(void)upLoad{ 
    
    NSLog(@"内容  :%@",_textView.text);
    
    NSString * url  = @"//My2017/ZYMySqlite/api.php?method=writeDiary";
    
    NSDictionary * params = @{@"userid":@"2",@"text":_textView.text};
   
    [[NetworkTool sharedTool] zyRequestWithURL:url method:@"POST" parameters:params success:^(id response) {
        NSLog(@"respnose:%@",response);
        
        NSLog(@"数据 :%@",response[@"msg"]);
      
        if ([response[@"code"] integerValue] == 200) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    
    } failure:^(NSString *errorStr) {
        NSLog(@"errorStr:%@",errorStr);
    }];
    
    
    
}





-(void)textViewDidChange:(UITextView *)textView{
    

    
}


//-(UITextView *)textView{
//    if (!_textView) {
//
//        _textView = [UITextView new];
//        [self.view addSubview:_textView];
//        _textView.frame = self.view.bounds;
//        _textView.delegate = self;
//    }
//    return _textView;
//}

@end
