//
//  EZSortMenuView.h
//  EZStore
//
//  Created by PRO on 17/3/10.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZSortMenuView : UIView

@property(nonatomic,copy) void(^SortMenuSelect)(NSInteger index);


-(instancetype)initWithFrame:(CGRect)frame data:(NSArray*)data;

@end
 
   
 
  
  
