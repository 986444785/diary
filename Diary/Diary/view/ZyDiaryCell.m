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
        self.contentView.backgroundColor = [UIColor purpleColor];
        [self configUI];
    }
    return self;
}
-(void)configUI{
    
    _avatorIamgeView = [UIImageView new];
    [self.contentView addSubview:_avatorIamgeView];
    [_avatorIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.width.height.equalTo(@25);
    }];
    _avatorIamgeView.backgroundColor = [UIColor redColor];
    

    _nameLabel  =[UILabel new];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avatorIamgeView.mas_right).offset(8);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(_avatorIamgeView.mas_centerY);
    }];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.text = @"昵称";
    
    
    
    UILabel * lineLabel  =[UILabel new];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.equalTo(@1);
        make.top.equalTo(_avatorIamgeView.mas_bottom).offset(15);
    }];
    lineLabel.backgroundColor = [UIColor whiteColor];

    _diaryLabel  =[UILabel new];
    [self.contentView addSubview:_diaryLabel];
    [_diaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    
        make.top.equalTo(lineLabel.mas_bottom).offset(15);
    }];
    _diaryLabel.textColor = [UIColor whiteColor];
    _diaryLabel.numberOfLines = 0;
    _diaryLabel.text = @"内容...";
    
     
    
    _timeLabel  =[UILabel new];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        
        make.top.equalTo(_diaryLabel.mas_bottom).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.text = @"2017-10-25";

     
}

-(void)updateCellModel:(dModel*)model{
    
    _nameLabel.text = model.name;
    _diaryLabel.text = model.diary;
    _timeLabel.text = model.time;
}



@end
