//
//  ToolCategory.h
//  EZStore
//
//  Created by PRO on 17/3/13.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolCategory : NSObject

+ (BOOL)dx_isNullOrNilWithObject:(id)object;
   
//计算文字长度 
+(CGFloat)getStringLegthText:(NSString *)text fontSize:(NSInteger)fontSize;
 
  
//给UILabel设置行间距和字间距
//+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font;
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font lineSpace:(NSInteger)lineSpace;
//文字高度
+(CGFloat)getStringHeight:(NSString *)text labelWidth:(NSInteger)lableWidth fontSize:(NSInteger)fontSize;

//返回天数时间 day
+(NSArray *)getDayWithCount:(NSInteger)dayCount;

//===根据开始的时间戳和结束的时间戳  返回相应的时间   第一个数组是时间戳 第二个数组是用来显示的

+(NSArray *)getTimeWithBeginTimeSp:(NSInteger )beginTimeSP endTimeSp:(NSInteger )endTimeSP days:(NSInteger)days timeSpace:(NSInteger)timeSpace timeprepare:(NSInteger)timeprepare;


+(NSString *)imageUrlMatching:(NSString *)url;

 
//日期转成时间戳
+(NSInteger)timeSpWithTimeString:(NSString *)timeStr;

 
//获取当前时间戳
+(NSInteger)nowTimeSP;

//获取当前日期
+(NSString *)nowDay;

//传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSString *)dateString;
  
 
+(void)priceLableType:(UILabel *)label fontSize:(NSInteger)fontSize;

+(void)label:(UILabel *)lab Color:(UIColor *)color beginLength:(NSInteger)beginLength endlength:(NSInteger)endlength   str:(NSString *)strs;
+(void)label:(UILabel *)label fontSize:(NSInteger)fontSize beginLength:(NSInteger)beginLength endlength:(NSInteger)endlength  str:(NSString *)strs;

+(void)label:(UILabel *)label str:(NSString *)strs fontSizeBegin:(NSInteger)fontSizeBegin fontSizeEnd:(NSInteger)fontSizeEnd fontSize:(NSInteger)fontSize colorBegin:(NSInteger)colorBegin colorEnd:(NSInteger)colorEnd color:(UIColor*)color;



+(UIViewController *)getCurrentVC;

   


@end

