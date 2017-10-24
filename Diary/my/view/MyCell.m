//
//  MyCell.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "MyCell.h"

@interface MyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end


@implementation MyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellDictionary:(NSDictionary *)dictionary{
    
}
 

-(void)updateCellStr:(NSString *)str{
    _titleLabel.text = str;
}

@end
