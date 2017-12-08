//
//  ZYCustNavView.m
//  Diary
//
//  Created by 配得好 on 2017/12/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//
 
#import "ZYCustNavView.h"

@implementation ZYCustNavView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
  
-(void)configUI{

    self.backgroundColor = [UIColor whiteColor];
    //添加一个名字
    UILabel * titleLabel = [UILabel new];
    titleLabel.text  =@"血蹄~凯恩";
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).offset(10);
    }];
}




@end
