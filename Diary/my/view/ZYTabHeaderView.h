//
//  ZYTabHeaderView.h
//  Diary
//
//  Created by 配得好 on 2017/11/20.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserModel.h"
@interface ZYTabHeaderView : UIView

@property(nonatomic,copy) void ((^headerActor)(NSString *str));
 
-(void)updateHeaderImageView:(UIImage *)image;

-(void)configHeaderViewModel:(UserModel *)model;
 

@end 

  
