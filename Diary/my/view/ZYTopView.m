//
//  ZYTopView.m
//  Diary
//
//  Created by 配得好 on 2017/11/2.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYTopView.h"

@interface ZYTopView ()

@property(nonatomic) UIImageView * imageView;
@property(nonatomic) UILabel * orderLabel;
@property(nonatomic) UIImageView * qianyueImageView;
@property(nonatomic) UIImageView * tichengImageView;
@property(nonatomic) UILabel * qianyueLabel;
@property(nonatomic) UILabel * tichengLabel;

@property(nonatomic) UILabel * tichengPrice;

//没有信息的情况
@property(nonatomic) UIImageView * noInfoImageView;
@property(nonatomic) UILabel * noInfoLabel;


@end

@implementation ZYTopView

-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
     
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self configUI];
    
    return self;
}
//    315     155
//    375     200

 
//有信息  
-(void)hadInfoQianyuePrice:(NSString *)qianyuePrice  tichengPrice:(NSString *)tichengPrice orderNumber:(NSString *)orderNumber{
    
    _orderLabel.text = [NSString stringWithFormat:@"订单 %@",orderNumber];
    _imageView.image = [UIImage imageNamed:@"baise_beijing"];
    
    //图片 1
    _qianyueImageView = [UIImageView new];
    [_imageView addSubview:_qianyueImageView];
    [_qianyueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_left).offset(30);
        make.width.height.equalTo(@25);
        make.top.equalTo(_orderLabel.mas_bottom).offset(20);
    }];
//    _qianyueImageView.backgroundColor = [UIColor orangeColor];
    
    _qianyueImageView.image = [UIImage imageNamed:@"ticheng_shouru"];

    
    _qianyueLabel  = [UILabel new];
    [_imageView addSubview:_qianyueLabel];
    [_qianyueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_qianyueImageView.mas_centerY);
        make.left.equalTo(_qianyueImageView.mas_right).offset(5);
    }];
    _qianyueLabel.text = @"签约价格";
    
    
    //图片 2
    _tichengImageView = [UIImageView new];
    [_imageView addSubview:_tichengImageView];
    [_tichengImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imageView.mas_centerX).offset(30);
        make.width.height.equalTo(@25);
        make.centerY.equalTo(_qianyueImageView);
    }];
//    _tichengImageView.backgroundColor = [UIColor orangeColor];
    _tichengImageView.image = [UIImage imageNamed:@"qianyue_jiage"];
    
    
    _tichengLabel  = [UILabel new];
    [_imageView addSubview:_tichengLabel];
    [_tichengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_tichengImageView);
        make.left.equalTo(_tichengImageView.mas_right).offset(5);
    }];
    _tichengLabel.text = @"提成收入";
    
     
    
    
    UILabel * priceLabel  = [UILabel new];
    [_imageView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_qianyueImageView.mas_bottom).offset(15);
        make.left.equalTo(_qianyueImageView.mas_left).offset(10);
        
    }];
    priceLabel.text = qianyuePrice;
    
    
    UILabel * tichnegLabel  = [UILabel new];
    [_imageView addSubview:tichnegLabel];
    [tichnegLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_top);
        make.left.equalTo(_tichengImageView.mas_left).offset(10);
    }];
    tichnegLabel.text = tichengPrice;
    
}
 
//没有信息
-(void)noInfoOrderNumber:(NSString *)orderNumber{
    
    _orderLabel.text = [NSString stringWithFormat:@"订单 %@",orderNumber];
    _imageView.image = [UIImage imageNamed:@"huise_beijing"];
    
    _noInfoImageView = [UIImageView new];
    [_imageView addSubview:_noInfoImageView];
    [_noInfoImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.width.equalTo(@111);
                make.height.equalTo(@68);
        make.centerX.equalTo(_imageView.mas_centerX);
        make.centerY.equalTo(_imageView.mas_centerY);
    }];
//    _noInfoImageView.backgroundColor = [UIColor orangeColor];
    _noInfoImageView.image = [UIImage imageNamed:@"meishuju"];
    _noInfoImageView.layer.masksToBounds = YES;
    _noInfoImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _noInfoLabel  = [UILabel new];
    [_imageView addSubview:_noInfoLabel];
    [_noInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageView.mas_centerX);
        make.top.equalTo(_noInfoImageView.mas_bottom).offset(10);
    }];
    
    _noInfoLabel.text = @"无签约信息";
    
}




-(void)configUI{

    UIView * colorView = [UIView new];
    [self addSubview:colorView];
    [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(self.mas_height).multipliedBy(0.7);
    }];
    colorView.backgroundColor = [UIColor blueColor];
    
    //底部图片
    _imageView  = [UIImageView new];
    [self addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.equalTo(@(KSCREEN_WIDTH * (315.00)/375));
        make.height.equalTo(@(KSCREEN_WIDTH * (155.00)/375));
        
    }];
//    _imageView.backgroundColor = [UIColor yellowColor];
    
    
    //订单号
    _orderLabel  = [UILabel new];
    [_imageView addSubview:_orderLabel];
    [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imageView);
        make.top.equalTo(@15);
        
    }];
    _orderLabel.textColor = [UIColor grayColor];
    _orderLabel.text = @"订单 20171102";
    _orderLabel.font = [UIFont systemFontOfSize:14];
    

    
    
    
}




@end
