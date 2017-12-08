//
//  ZyDiaryCell.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZyDiaryCell.h"

@interface ZyDiaryCell ()

@property(nonatomic) UIImageView * avatorIamgeView;
@property(nonatomic) UILabel * nameLabel;
@property(nonatomic) UILabel * diaryLabel;
@property(nonatomic) UILabel * timeLabel;
@property(nonatomic) UILabel * likesLabel;
@property(nonatomic) UIButton * likeButton;
@property(nonatomic) UIView * backGroundView;
@end  

@implementation ZyDiaryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
    }
    return self;
}
-(void)configUI{
    
      
    _backGroundView = [UIView new];
    [self.contentView addSubview:_backGroundView];
    [_backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    _backGroundView.backgroundColor = [UIColor grayColor];
    
    _backGroundView.layer.masksToBounds = YES;
    _backGroundView.layer.cornerRadius = 5;
    
      
    
    _avatorIamgeView = [UIImageView new];
    [_backGroundView addSubview:_avatorIamgeView];
    [_avatorIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backGroundView.mas_left).offset(15);
        make.top.equalTo(_backGroundView.mas_top).offset(15);
        make.width.height.equalTo(@25);
    }];
//    _avatorIamgeView.backgroundColor = [UIColor redColor];
    

    _nameLabel  =[UILabel new];
    [_backGroundView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatorIamgeView.mas_right).offset(8);
        make.right.equalTo(_backGroundView.mas_right).offset(-15);
        make.centerY.equalTo(_avatorIamgeView.mas_centerY);
    }];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"昵称";
    
    
    
    UILabel * lineLabel  =[UILabel new];
    [_backGroundView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backGroundView.mas_left).offset(15);
        make.right.equalTo(_backGroundView.mas_right).offset(-15);
        make.height.equalTo(@0.5);
        make.top.equalTo(_avatorIamgeView.mas_bottom).offset(15);
    }];
    lineLabel.backgroundColor = [UIColor whiteColor];

    _diaryLabel  =[UILabel new];
    [_backGroundView addSubview:_diaryLabel];
    [_diaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backGroundView.mas_left).offset(15);
        make.right.equalTo(_backGroundView.mas_right).offset(-15);
    
        make.top.equalTo(lineLabel.mas_bottom).offset(15);
    }];
    _diaryLabel.textColor = [UIColor whiteColor];
    _diaryLabel.numberOfLines = 4;
    _diaryLabel.text = @"内容...";
    
    
    
    _timeLabel  =[UILabel new];
    [_backGroundView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backGroundView.mas_left).offset(15);
//        make.right.equalTo(backGroundView.mas_right).offset(-15);
        make.top.equalTo(_diaryLabel.mas_bottom).offset(15);
        make.bottom.equalTo(_backGroundView.mas_bottom).offset(-15);
    }];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.text = @"2017-10-25";

    _likeButton  =[UIButton buttonWithType:UIButtonTypeCustom];
    [_backGroundView addSubview:_likeButton];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(backGroundView.mas_left).offset(15);
        make.right.equalTo(_backGroundView.mas_right).offset(-15);
        
//        make.top.equalTo(_diaryLabel.mas_bottom).offset(15);
        make.bottom.equalTo(_backGroundView.mas_bottom).offset(-15);
    }];
    [_likeButton setTitle:@"  0" forState:UIControlStateNormal];
    [_likeButton setImage:[UIImage imageNamed:@"no_like"] forState:UIControlStateNormal];
    [_likeButton addTarget:self action:@selector(collectionClick) forControlEvents:UIControlEventTouchUpInside];
    
    
     
    
} 

-(void)collectionClick{
    
    if (_collectButton) {
        _collectButton(@"click");
    }
}
 
 


-(void)updateCellModel:(dModel*)model{
    
    [_avatorIamgeView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:nil];
    
    NSArray * colors = @[[UIColor colorWithRed:164/255.0 green:154/255.0 blue:217/255.0 alpha:1],[UIColor colorWithRed:212/255.0 green:35/255.0 blue:122/255.0 alpha:1],
                         [UIColor colorWithRed:50/255.0 green:150/255.0 blue:219/255.0 alpha:1],
                          [UIColor colorWithRed:135/255.0 green:195/255.0 blue:145/255.0 alpha:1]];
    
   NSInteger i =  arc4random()%4;

    _backGroundView.backgroundColor = colors[i];
    
    _nameLabel.text = model.name;
    _diaryLabel.text = model.diary;
    _timeLabel.text = model.time;
    
    NSString * likeImage = model.isLike ? @"is_like" : @"no_like" ;
    [_likeButton setImage:[UIImage imageNamed:likeImage] forState:UIControlStateNormal];
    [_likeButton setTitle:[NSString stringWithFormat:@"  %@",model.likes] forState:UIControlStateNormal];
}



@end
