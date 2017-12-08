//
//  ActivityShowView.h
//  EZStore
//
//  Created by PRO on 17/6/28.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityShowView : UIView
 
 
@property(nonatomic,copy) void(^activityButton)(NSString * text);

-(instancetype)initWithDictionary:(NSDictionary *)dictionary ;


//-(instancetype)initWithJsonDictionary:(NSDictionary *)dictionary ; //json转化的


-(void)show;
@end 

  
 
