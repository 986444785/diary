//
//  ZYCalendarTopView.m
//  MSSCalendar
//
//  Created by 配得好 on 2017/11/14.
//  Copyright © 2017年 于威. All rights reserved.
//

#import "ZYCalendarTopView.h"

@implementation ZYCalendarTopView

 
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor greenColor];
    
    [self configUI];
    return self;
}
   
 
-(void)configUI{
    
    //背景图片
    UIImageView * bgImageView = [UIImageView new];
    [self addSubview:bgImageView];
    bgImageView.frame = self.frame;
    bgImageView.image = [UIImage imageNamed:@"cvc_bg_02"];
    
    
    //返回按钮
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:backButton];
   
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(5);
        make.top.equalTo(self.mas_top).offset(24);
        make.height.equalTo(@40);
        make.width.equalTo(@70);
    }];
    [backButton setImage:[UIImage imageNamed:@"nav_back_image"] forState:UIControlStateNormal];
     [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    backButton.tag = 1;

    //底部白条
    UIView * bottomView = [UIView new];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.mas_bottom);
    }];
    bottomView.backgroundColor = [UIColor whiteColor];
    
     
    //签到按钮
    UIButton * siginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:siginButton];
//    [siginButton setTitle:@"签到" forState:UIControlStateNormal];
    [siginButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
//        make.width.height.equalTo(self.mas_width).multipliedBy(0.25);
        make.width.height.equalTo(self.mas_height).multipliedBy(0.75);
    }];
    [siginButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [siginButton setBackgroundColor:[UIColor redColor]];
    [siginButton setImage:[UIImage imageNamed:@"sign_orange"] forState:UIControlStateNormal];
    siginButton.tag = 2;

    
    
    
    
    
    //年月
    UILabel * yearLabel = [UILabel new];
    [self addSubview:yearLabel];
    yearLabel.text = @"2019年8月";
    yearLabel.textColor = [UIColor whiteColor];
    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottomView.mas_top).offset(-15);
        make.left.equalTo(self.mas_left).offset(20);
    }];

    
    
    
}

-(void)buttonClick:(UIButton *)sender{
    
    NSLog(@"点击; buttonClick");
    
    if (_CalendarTopAcction) {
        _CalendarTopAcction(sender.tag);
    }
    
     
    
}





@end
