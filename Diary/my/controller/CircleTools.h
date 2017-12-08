//
//  CircleTools.h
//  YUNSJ
//
//  Created by 配得好家居 on 2017/6/22.
//  Copyright © 2017年 Cloud. All rights reserved.
//
//
//
//
//
/* ////////////////////////     绘制空心圆 双层     //////////////////////// */
//
 
#import <UIKit/UIKit.h>

@interface CircleTools : UIView

//半径 
@property (nonatomic, assign) CGFloat radius;

//描边宽度
@property (nonatomic, assign) CGFloat lineWidth;

//第二个圆的结束位置 
@property (nonatomic, assign) CGFloat endAngle;

//底部圆颜色
@property (nonatomic, strong) UIColor* beginColor;

//上面圆的颜色
@property (nonatomic, strong) UIColor* endColor;


@property(nonatomic) BOOL needRound;
  
 
@end 
 
