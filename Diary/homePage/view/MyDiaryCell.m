//
//  MyDiaryCell.m
//  Diary
//
//  Created by 配得好 on 2017/11/25.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "MyDiaryCell.h"

@interface MyDiaryCell()

@property(nonatomic) UIView * rightContentView;
@property(nonatomic) UILabel * contentLabel;
@property(nonatomic) UILabel * timeAddressLabel;

@property(nonatomic) UILabel * dayLabel;
@property(nonatomic) UILabel * weekLabel;
@property(nonatomic) UILabel * yearMonthLabel;

@property(nonatomic) UIView * typeView;
@end

@implementation MyDiaryCell

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
        self.contentView.backgroundColor = SUBJECT_BGCOLOR;
        [self configCell];
    }
    return self;
}
 

-(void)configCell{
    
    
    //内容
    _rightContentView =[UIView new];
    [self.contentView addSubview:_rightContentView];
    [_rightContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(XSIZE(-15));
        make.top.equalTo(self.contentView.mas_top).offset(XSIZE(10));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(XSIZE(-10));
        make.height.equalTo(@(XSIZE(50)));
        make.left.equalTo(self.contentView.mas_left).offset(XSIZE(100));
    }];
    _rightContentView.backgroundColor = [UIColor whiteColor];

    
    //文字
    _contentLabel =[UILabel new];
    [_rightContentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_rightContentView.mas_right).offset(XSIZE(-5));
        make.top.equalTo(_rightContentView.mas_top).offset(XSIZE(5));
        make.left.equalTo(_rightContentView.mas_left).offset(XSIZE(7));
    }];
    _contentLabel.numberOfLines = 3;
    _contentLabel.text = @"三年之前和三年之后的你 \n这是第二行\n你这是第三行\n这是第四行";
    //时间和地点
    
    _timeAddressLabel = [UILabel new];
    [_rightContentView addSubview:_timeAddressLabel];
    [_timeAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentLabel.mas_left);
        make.bottom.equalTo(_rightContentView.mas_bottom).offset(XSIZE(-4));
    }];
    _timeAddressLabel.text = @"20:03    广东省深圳市南山区";
    _timeAddressLabel.textColor = [UIColor grayColor];
    _timeAddressLabel.font = [UIFont systemFontOfSize:12];
    
    UILabel * lineLabel = [UILabel new];
    [self.contentView addSubview:lineLabel];
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(XSIZE(80));
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.width.equalTo(@1);
    }];
    lineLabel.backgroundColor = [UIColor lightGrayColor];
    
    
    
    _dayLabel = [UILabel new];
    [self.contentView addSubview:_dayLabel];
    [_dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(XSIZE(10));
        make.top.equalTo(_rightContentView.mas_top);
    }];
    _dayLabel.text = @"20";

    
    _weekLabel= [UILabel new];
    [self.contentView addSubview:_weekLabel];
    [_weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dayLabel.mas_right).offset(XSIZE(2));
        make.bottom.equalTo(_dayLabel.mas_bottom);
    }];
    _weekLabel.text  = @"星期一";
    _weekLabel.font = [UIFont systemFontOfSize:XSIZE(12)];
    
    _yearMonthLabel = [UILabel new];
    [self.contentView addSubview:_yearMonthLabel];
    [_yearMonthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_dayLabel.mas_left);
        make.top.equalTo(_dayLabel.mas_bottom);
    }];
    _yearMonthLabel.text  = @"2017.10";
    _yearMonthLabel.font = [UIFont systemFontOfSize:XSIZE(13)];
    
    
    _typeView = [UIView new];
    [self.contentView addSubview:_typeView];
    [_typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(XSIZE(6)));
        make.centerX.equalTo(lineLabel.mas_centerX);
        make.top.equalTo(_rightContentView.mas_top).offset(XSIZE(20));
    }];
    _typeView.layer.cornerRadius = 3;
    _typeView.layer.masksToBounds = YES;
    _typeView.backgroundColor = [UIColor redColor];


} 
 
-(void)updateCellModel:(MeDiaryModel *)model{

    _contentLabel.text = model.diary;

}


@end
