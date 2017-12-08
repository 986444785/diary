//
//  ToolCategory.m
//  EZStore
//
//  Created by PRO on 17/3/13.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import "ToolCategory.h"

@implementation ToolCategory

#pragma mark 判断是不是空
+ (BOOL)dx_isNullOrNilWithObject:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    } else if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:@""]) {
            return YES;
        } else {
            return NO;
        }
    } else if ([object isKindOfClass:[NSNumber class]]) {
        if ([object isEqualToNumber:@0]) {
            return YES;
        } else {
            return NO;
        } 
    }
    
    return NO;
}

#pragma mark ---- 计算文字长度
+(CGFloat)getStringLegthText:(NSString *)text fontSize:(NSInteger)fontSize{
    
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    
    return size.width ;
}

+(CGFloat)getStringHeight:(NSString *)text labelWidth:(NSInteger)lableWidth fontSize:(NSInteger)fontSize{
    
    float height = [text boundingRectWithSize:CGSizeMake(lableWidth, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size.height;
    
    return (height + 10);
}

  
//给UILabel设置行间距和字间距 
+(void)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(UIFont*)font lineSpace:(NSInteger)lineSpace{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    label.attributedText = attributeStr;
}



#pragma mark  === 返回天数时间 day
+(NSArray *)getDayWithCount:(NSInteger)dayCount{
    
    NSDate * date = [NSDate date];
    
    NSDateFormatter * moreFormatter = [[NSDateFormatter alloc]init];
    
    [moreFormatter setDateFormat:@"MM-dd"];
    
    //时间转化时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    
    NSMutableArray * baseDays = [NSMutableArray array];
    
    NSArray * week = @[@" 周 日",@" 周 一 ",@" 周 二 ",@" 周 三 ",@" 周 四 ",@" 周 五 ",@" 周 六 " ];
   
    NSInteger todayIndex  =  [self currentWeekday]  ;

    for (int i = 0; i<dayCount; i++) {
        
        NSInteger weekindex = todayIndex + i;
        
        if (weekindex>=7) {

            weekindex = weekindex - 7 ;
        }
        
        if (i==0) {
            [baseDays addObject:[NSString stringWithFormat:@"今天 (%@)",week[weekindex]]];
        }else if (i==1){
    
            [baseDays addObject:[NSString stringWithFormat:@"明天 (%@)",week[weekindex]]];
            
        }else if (i==2){
            
            [baseDays addObject:[NSString stringWithFormat:@"后天 (%@)",week[weekindex]]];
            
        }else{
            
            NSInteger  baseTimeSp = i*60*60*24 + [timeSp integerValue];
            NSDate* date2 = [NSDate dateWithTimeIntervalSince1970:baseTimeSp];
            NSString* dateString = [moreFormatter stringFromDate:date2];
            [baseDays addObject:dateString];
        }
        
    }
    
    return baseDays;
    
}


//获取当前是星期几
+(NSInteger )currentWeekday{
    
    [NSTimeZone systemTimeZone];

    NSDate *date = [NSDate date];

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];

    [dateformatter setDateFormat:@"EEEE"];
    
    NSString *weekString = [dateformatter stringFromDate:date];

    NSDictionary * weekDic = @{@"星期一":@"1",@"星期二":@"2",@"星期三":@"3",@"星期四":@"4",@"星期五":@"5",@"星期六":@"6",@"星期天":@"7"};
    
    //获取语言，设置segment
    if ([[self getPreferredLanguage] isEqualToString:@"zh-TW"] ||
        [[self getPreferredLanguage] isEqualToString:@"zh-HK"] ||
        [[self getPreferredLanguage] isEqualToString:@"zh-Hant"] ||
        [[self getPreferredLanguage] isEqualToString:@"zh-Hant-CN"]) {
        //繁体中文
    }else if ([[self getPreferredLanguage] isEqualToString:@"zh-Hans-CN"]) {
        //简体中文
    }else {
        //其他语言，使用英文 
        
        weekDic = @{@"Monday":@"1",@"Tuesday":@"2",@"Wednesday":@"3",@"Thursday":@"4",@"Friday":@"5",@"Saturday":@"6",@"Sunday":@"7"};
    }
    
//    NSLog(@"今天星期 ---- %@",weekString);

    
    NSString * week = weekDic[weekString];
    
    return [week intValue];
}


 
+ (NSString*)getPreferredLanguage {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
    NSString * preferredLang = [allLanguages objectAtIndex:0];
//    NSLog(@"当前语言:%@", preferredLang);
    return preferredLang;
}
  

#pragma mark ===根据开始的时间戳和结束的时间戳  返回相应的时间   第一个数组是时间戳 第二个数组是用来显示的
+(NSArray *)getTimeWithBeginTimeSp:(NSInteger )beginTimeSP endTimeSp:(NSInteger )endTimeSP days:(NSInteger)days timeSpace:(NSInteger)timeSpace timeprepare:(NSInteger)timeprepare{
    

    NSMutableArray * allTimes = [NSMutableArray array];
    
    //获取当前时间戳
    NSDate * date = [NSDate date];
    //时间转化时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    NSInteger  nowTimeSp = [timeSp doubleValue];
    
    NSInteger tempTimeSp  =  nowTimeSp + timeprepare;
    
    beginTimeSP = beginTimeSP + timeprepare;
    
    for (int i=0; i<days; i++) {
        
        NSMutableArray * baseArray = [NSMutableArray array];
        
        //判断是不是当天的
        if (i == 0) {
            
            if (tempTimeSp<beginTimeSP) {
                
                tempTimeSp = beginTimeSP;
                //  全部
            }else if (beginTimeSP<endTimeSP){
                
                //部分
            }else{
                
                  tempTimeSp =  endTimeSP;
                //结束
            }
            
        }else{
            
            tempTimeSp = beginTimeSP;
        }
        
        
        NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"HH:mm"];
        
        
        NSMutableArray * baseTime = [NSMutableArray array];
  
        
        
        if (i==0 && tempTimeSp != endTimeSP) {
            //时间戳数组先添加个当前时间+时间间隔
            
            NSDate* date33 = [NSDate dateWithTimeIntervalSince1970:tempTimeSp];
            NSString* dateString33 = [formatter stringFromDate:date33];
            
            //显示的时间先加个当前时间
            [baseTime addObject:[NSString stringWithFormat:@"预计%@送达",dateString33]];
        }
        
        
        
        while (tempTimeSp <= endTimeSP) {
            
            
            NSInteger yushu2 = tempTimeSp % timeSpace;
            
            if (yushu2 != 0) {
                
                tempTimeSp = tempTimeSp - yushu2 + timeSpace;
            }
             
             
            NSDate* date3 = [NSDate dateWithTimeIntervalSince1970:tempTimeSp];
            NSString* dateString3 = [formatter stringFromDate:date3];
            
//            NSLog(@" 想要的 时间戳转化 时间   %@",dateString3);
            
            [baseTime addObject:dateString3];
            
            tempTimeSp = tempTimeSp+timeSpace;
        }
         
        
        NSMutableArray * lastTime = [NSMutableArray array];
        
        for (int i = 0 ; i< baseTime.count - 1; i++) {
            
            [lastTime addObject:baseTime[i]];
        }
        
        
        [baseArray addObject:lastTime];
        
        [allTimes addObject:baseArray];
    }
    
    return allTimes;
    
} 
  
//图片Ulr的匹配
+(NSString *)imageUrlMatching:(NSString *)url{
    
    NSString * matcUrl = @"";
    /*
    if (![url isEqual:[NSNull null]]) {
       
        NSString * imgUrl = [url stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        
        imgUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,imgUrl];
    
        matcUrl =  [imgUrl stringByReplacingOccurrencesOfString:@"ErZhu/" withString:@""];
        
    }
    */
    return matcUrl;
}


 
/*
 当前时间转化时间戳
 NSDate * senddate=[NSDate date];
 NSString *  nowString=[dateformatter stringFromDate:senddate];
 */
#pragma mark 日期转成时间戳
+(NSInteger)timeSpWithTimeString:(NSString *)timeStr{    // timeStr = @"2017-04-14 09:53:03";
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSDate * location = [dateformatter dateFromString:timeStr];
    //转成时间戳
    
    return [location timeIntervalSince1970];
}


//获取当前时间戳
+(NSInteger)nowTimeSP{
    
    NSDate * senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSString *  nowString=[dateformatter stringFromDate:senddate];
    
    NSDate * location = [dateformatter dateFromString:nowString];
    
    return [location timeIntervalSince1970];
}
 

//获取今天时间
+(NSString *)nowDay{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *DateTime = [formatter stringFromDate:date];
     
    return DateTime;
    
}
 

//传入今天的时间，返回明天的时间
+ (NSString *)GetTomorrowDay:(NSString *)dateString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *aDate= [dateFormatter dateFromString:dateString];
    
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}


   
+(void)priceLableType:(UILabel *)label fontSize:(NSInteger)fontSize{
    
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    
//    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(1,3)]; //设置字体颜色
     
    NSInteger endLength = label.text.length - 1;
     
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:fontSize] range:NSMakeRange(1, endLength)]; //设置字体字号和字体类别
    
     label.attributedText = str;
}

   
//设置颜色的 1
+(void)label:(UILabel *)lab Color:(UIColor *)color beginLength:(NSInteger)beginLength endlength:(NSInteger)endlength   str:(NSString *)strs{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strs];

    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(beginLength,endlength)]; //设置字体颜色

    lab.attributedText = str;
    
}
 

 
//设置字体大小 2
+(void)label:(UILabel *)label fontSize:(NSInteger)fontSize beginLength:(NSInteger)beginLength endlength:(NSInteger)endlength str:(NSString *)strs{

    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strs];
    
    //    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(1,3)]; //设置字体颜色
    
//    NSInteger endLength = strs.length - 4;
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:fontSize] range:NSMakeRange(beginLength, endlength)]; //设置字体字号和字体类别
    
    label.attributedText = str;
}
 

//设置字体大小字体颜色  1+2
+(void)label:(UILabel *)label str:(NSString *)strs fontSizeBegin:(NSInteger)fontSizeBegin fontSizeEnd:(NSInteger)fontSizeEnd fontSize:(NSInteger)fontSize colorBegin:(NSInteger)colorBegin colorEnd:(NSInteger)colorEnd color:(UIColor*)color{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:strs];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0,4)]; //设置字体颜色
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:11] range:NSMakeRange(4, 1)]; //设置字体字号和字体类别
    
    label.attributedText = str;
}

  
 

+(UIViewController *)getCurrentVC{

    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //    如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
        //        <span style="font-family: Arial, Helvetica, sans-serif;">//  这方法下面有详解    </span>
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //        UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    
    return result;
}






@end
