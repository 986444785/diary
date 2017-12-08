//
//  ZYZoneHeader.m
//  Diary
//
//  Created by 配得好 on 2017/12/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//
 
#import "ZYZoneHeader.h"

@interface ZYZoneHeader ()

@property(nonatomic) UIImageView * bgImageView;
@property(nonatomic) UIImageView * headerImageView;
@property(nonatomic) CGFloat   selfHeight;
@property(nonatomic) UILabel * nick_lanle;


@end

@implementation ZYZoneHeader

 
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
 
-(void)configUI{
    
    //设置autoresizesSubviews让子类自动布局
//    self.autoresizesSubviews = YES;
    //自动布局，自适应顶部
//    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    
    self.backgroundColor = [UIColor greenColor];
    _selfHeight = self.frame.size.height;
    _bgImageView = [UIImageView new];
    _bgImageView.image = [UIImage imageNamed:@"feiyu.jpg"];
    [self addSubview:_bgImageView];
  
    _bgImageView.backgroundColor = [UIColor orangeColor];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
   
    
    /*  添加子视图   */
    
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.image = [UIImage imageNamed:@"hdsn.jpg"];
    [self addSubview:_headerImageView];
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(44 + XSIZE(20));
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.equalTo(@(XSIZE(80)));
    }];
    if (@available(iOS 11.0, *)) {
        _headerImageView.layer.maskedCorners = YES;
    } else {
        // Fallback on earlier versions
    }
    _headerImageView.contentMode  = UIViewContentModeScaleAspectFit;
    
     
    //昵称
    _nick_lanle = [UILabel new];
    _nick_lanle.textColor = [UIColor whiteColor];
    _nick_lanle.text  =@"血蹄~凯恩~金";
    [self addSubview:_nick_lanle];
    [_nick_lanle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerImageView.mas_bottom).offset(XSIZE(10));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    


}

-(void)setBgImage:(NSString *)bgImage{
    
    
}

@end
