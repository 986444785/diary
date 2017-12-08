//
//  describeCell.m
//  Diary
//
//  Created by 配得好 on 2017/12/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//
 
#import "describeCell.h"
@interface describeCell ()

@property(nonatomic) UILabel * titleLab;
@property(nonatomic) UILabel * contentLab;
 

@end
@implementation describeCell

 

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor orangeColor];
        [self configUI];
    }
    return self;
} 

-(void)configUI{
    
    _titleLab = [UILabel new];
    [self.contentView addSubview:_titleLab];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@15);
        make.top.equalTo(self.contentView.mas_top).offset(5);
    }];
    _titleLab.font = [UIFont systemFontOfSize:17];
    [_titleLab adjustsFontSizeToFitWidth];
    _titleLab.text = @"鲜港记甜品";
    
    
    _contentLab = [UILabel new];
    [self.contentView addSubview:_contentLab];
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLab.mas_left);
        make.right.equalTo(_titleLab.mas_right);
        make.top.equalTo(_titleLab.mas_bottom).offset(10);
    }];
    _contentLab.font = [UIFont systemFontOfSize:12];
    [_contentLab adjustsFontSizeToFitWidth];
    _contentLab.textColor = [UIColor grayColor];
    _contentLab.numberOfLines = 2;
    _contentLab.text = @"这是源于明朝时期,民间特制配方清热解毒,";
    
    
}




@end
 
