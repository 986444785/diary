//
//  ZYInfoView.m
//  Diary
//
//  Created by 配得好 on 2017/11/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYInfoView.h"

@interface ZYInfoView ()

@property(nonatomic) UIImageView * imageView;
@property(nonatomic) UIButton     * titleBtn;
@property(nonatomic) UIButton    * deleteBtn;


@end

@implementation ZYInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/ 

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self configUI];
    return self;
}

-(void)configUI{
    
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.mas_left).offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@20);
    }];
    
    
    _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_titleBtn setImage:[UIImage imageNamed:@"exclamation_red"] forState:UIControlStateNormal];
    [_titleBtn setTitle:@"个人" forState:UIControlStateNormal];
    [_titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self addSubview:_titleBtn];
    [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_imageView.mas_left);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
   
    
    
    
    
    
}

-(void)titleBtnClick:(UIButton *)sender{
    
    NSLog(@"点击了");
    
}


-(void)updateTitle:(NSString *)title imageStr:(NSString *)imageStr bgColor:(UIColor *)bgColor{
    
    
    if (bgColor) {
        self.backgroundColor = bgColor;
    }

    [_titleBtn setTitle:title forState:UIControlStateNormal];
    
    _imageView.image = [UIImage imageNamed:imageStr];
    
    
    
}


@end
