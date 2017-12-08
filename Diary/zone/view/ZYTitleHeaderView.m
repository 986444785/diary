//
//  ZYTitleHeaderView.m
//  Diary
//
//  Created by 配得好 on 2017/12/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYTitleHeaderView.h"
@interface ZYTitleHeaderView ()

@property(nonatomic) UILabel * titleLab;
@property(nonatomic) UILabel * contentLab;


@end
@implementation ZYTitleHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
} 
 
  
-(void)configUI{
    
    _titleLab = [UILabel new];
    [self addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
//        make.right.equalTo(self.mas_right).offset(-10);
//        make.height.equalTo(@15);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    _titleLab.font = [UIFont systemFontOfSize:17];
    [_titleLab adjustsFontSizeToFitWidth];
    _titleLab.text = @"旱地神牛  + 力量  ";
    
    
    
}


@end
