//
//  sampleCell.m
//  Diary
//
//  Created by 配得好 on 2017/12/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "sampleCell.h"

@interface sampleCell ()

@property(nonatomic) UIImageView * logoImageView;

@end

@implementation sampleCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self configUI];
    }
    return self;
}
 
-(void)configUI{
    
    self.contentView.backgroundColor = [UIColor redColor];
    
    _logoImageView = [UIImageView new];
    [self.contentView addSubview:_logoImageView];
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.equalTo(_logoImageView.mas_height);
    }];

    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.image = [UIImage imageNamed:@"WechatIMG18.jpeg"];
}



@end
 
