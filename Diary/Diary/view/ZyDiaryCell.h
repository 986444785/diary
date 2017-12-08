//
//  ZyDiaryCell.h
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dModel.h"
@interface ZyDiaryCell : UITableViewCell

@property(nonatomic,copy) void((^collectButton)(NSString *collect));

-(void)updateCellModel:(dModel*)model;


@end
 
 
