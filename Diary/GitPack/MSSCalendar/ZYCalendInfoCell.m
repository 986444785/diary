//
//  ZYCalendInfoCell.m
//  Diary
//
//  Created by 配得好 on 2017/11/14.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYCalendInfoCell.h"

@implementation ZYCalendInfoCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self ZYCalendInfoCellConfig];
    }
    return self;
}
 

-(void)ZYCalendInfoCellConfig{
    
     
     
    UILabel * titleLabel  =[UILabel new];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(20);
        
        make.right.equalTo(self.contentView.mas_right).offset(-20);
    }];
//    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"签到规则说明";
    
    NSArray * infos = @[@"我本将心向明月,奈何明月照沟渠.",@"壬戌之秋，七月既望，苏子与客泛舟游于赤壁之下。清风徐来，水波不兴。举酒属客，诵明月之诗，歌窈窕之章。少焉，月出于东山之上，徘徊于斗牛之间。",@"人间四月芳菲尽,山寺桃花始盛开.",@"去年今日此门中，人面桃花相映红。人面不知何处去，桃花依旧笑春风。"];

    UILabel * lab0  =nil;
    for(int i = 0 ; i< infos.count ; i++){

        UILabel * lab = [UILabel new];
        [self.contentView addSubview:lab];

        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
           
            if (lab0) {
                make.top.equalTo(lab0.mas_bottom).offset(20);
            }else{
                 make.top.equalTo(titleLabel.mas_bottom).offset(20);
            }
            
            make.left.equalTo(self.contentView.mas_left).offset(40);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
         
        lab.numberOfLines = 0;
        lab.text = infos[i];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor grayColor];
        lab0  =lab;

    }
    
//    UILabel * lab = [UILabel new];
//    [self.contentView addSubview:lab];
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLabel.mas_bottom).offset(25);
//        make.left.equalTo()
//    }];
//
    
}

@end
 

