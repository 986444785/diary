//
//  ZYTabHeaderView.m
//  Diary
//
//  Created by 配得好 on 2017/11/20.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYTabHeaderView.h"

@interface  ZYTabHeaderView ()

@property(nonatomic) UIImageView * headerImageView;
@property(nonatomic) UILabel * titleLabel;
@property(nonatomic) UILabel * signatureLabel;
@end

@implementation ZYTabHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    [self configUI];
    return self;
}
 

-(void)configUI{
    
    //背景图
    UIImageView * imageView =[UIImageView new];
    [self addSubview:imageView];
    imageView.frame = self.frame;
    
    imageView.image = [UIImage imageNamed:@"wbBG"];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    
    //中间的图片
    UIImageView * moneyImageview = [UIImageView new];
    [self addSubview:moneyImageview];
    
    [moneyImageview mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerY.equalTo(self.mas_centerY).offset(-10);
//        make.bottom.equalTo(self.mas_bottom).offset(-(25));
        make.centerX.equalTo(self);
        make.width.height.equalTo(@(80));
    }];
    moneyImageview.image = [UIImage imageNamed:@"my_header"];
    moneyImageview.userInteractionEnabled = YES;
    moneyImageview.layer.masksToBounds = YES;
    moneyImageview.contentMode =  UIViewContentModeScaleAspectFill;
    //添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(avtorClick:)];
    [moneyImageview addGestureRecognizer:tap];
    _headerImageView = moneyImageview;
      
    // 总累计
    UILabel * titleLabel_one = [UILabel new];
    [moneyImageview addSubview:titleLabel_one];
    [titleLabel_one mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyImageview.mas_bottom).offset(15);
        make.centerX.equalTo(self.mas_centerX);
    }];
    titleLabel_one.text = @"王大锤";
    titleLabel_one.textColor = [UIColor blackColor];
    titleLabel_one.font = [UIFont systemFontOfSize:16];
    _titleLabel=titleLabel_one;
    
    UILabel * titleLabel_two = [UILabel new];
    [moneyImageview addSubview:titleLabel_two];
    [titleLabel_two mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel_one.mas_bottom).offset(5);
        make.centerX.equalTo(self.mas_centerX);
    }];
    titleLabel_two.text = @"个性签名........";
    titleLabel_two.textColor = [UIColor whiteColor];
//    [titleLabel_two setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
    _signatureLabel = titleLabel_two;
    
} 

-(void)avtorClick:(UITapGestureRecognizer *)tap{

    if (_headerActor) {
        _headerActor(@"");
    }
}


-(void)updateWithStr:(NSString *)str{
    _signatureLabel.text = [NSString stringWithFormat:@"%@个",str];
}

// 
-(void)configHeaderViewModel:(UserModel *)model{
    _signatureLabel.text = model.signature;
    _titleLabel.text = model.name;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"my_header"]];
} 
  
-(void)updateHeaderImageView:(UIImage *)image{
    _headerImageView.image = image;
}






@end
