//
//  DContentCell.m
//  Diary
//
//  Created by 配得好 on 2017/10/27.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "DContentCell.h"

@interface DContentCell ()

@property(nonatomic) UILabel * contentLabel;

@end


@implementation DContentCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor  = SUBJECT_BGCOLOR;
        [self configUI];
    }
    
    return self;
    
}


-(void)configUI{

    _contentLabel = [UILabel new];
    [self.contentView addSubview:_contentLabel];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(15);
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    _contentLabel.numberOfLines = 0;
    
    
    
}
 


-(void)updateCell:(NSString *)str{
    
    _contentLabel.text = str;
    [ToolCategory setLabelSpace:_contentLabel withValue:_contentLabel.text withFont:[UIFont systemFontOfSize:15] lineSpace:4];
    
}













@end
