//
//  TextViewTools.h
//  YUNSJ
//
//  Created by 配得好家居 on 2017/6/28.
//  Copyright © 2017年 Cloud. All rights reserved.
//
//
//
//
//
/* ////////////////////////     自动换行textview     //////////////////////// */
//

#import <UIKit/UIKit.h>

@interface TextViewTools : UITextView

@property(nonatomic,copy) void ((^textViewChangeStr)(NSString * textStr));

   
/** 
 占位文字lable
 */
@property(nonatomic , copy) NSString* placeHolderText;

/**
 占位文字的lable
 */
@property(nonatomic , strong) UILabel * placeHolderLable;

/** 
 最大文字输入量
 */
@property(nonatomic , assign) NSInteger  maxTextCount;


/**
 是否显示文字统计
 */
@property(nonatomic , assign) BOOL  showTextCount;

@property (nonatomic, strong)NSString *texts;





@end
