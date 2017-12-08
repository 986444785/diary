//
//  ZYTopView.h
//  Diary
//
//  Created by 配得好 on 2017/11/2.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTopView : UIView


//有信息 
-(void)hadInfoQianyuePrice:(NSString *)qianyuePrice tichengPrice:(NSString *)tichengPrice orderNumber:(NSString *)orderNumber;
//没有信息
-(void)noInfoOrderNumber:(NSString *)orderNumber;


  

@end
