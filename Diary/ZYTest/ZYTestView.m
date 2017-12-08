//
//  ZYTestView.m
//  Diary
//
//  Created by 配得好 on 2017/11/13.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYTestView.h"
#import "CircleTools.h"
#import "MSSCalendarViewController.h"
#import "EZActivityView.h"
#import "ActivityShowView.h"
#import "EZSortMenuView.h"
@interface ZYTestView ()

@end

@implementation ZYTestView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setUI];
}

//九宫格 

- (IBAction)showMenus:(id)sender {
    
    NSArray * arrys  = @[@{@"title":@"微信朋友圈",@"icon":@"1"},@{@"title":@"微信好友",@"icon":@"1"},@{@"title":@"QQ空间",@"icon":@"1"},@{@"title":@"QQ好友",@"icon":@"1"},@{@"title":@"新浪微博",@"icon":@"1"},@{@"title":@"面对面扫码",@"icon":@"1"},@{@"title":@"手机短信",@"icon":@"1"}];
     
   EZSortMenuView * menuView = [[EZSortMenuView alloc]initWithFrame:CGRectMake(10, 80, KSCREEN_WIDTH-10*2, 240) data:arrys];
    [self.view addSubview:menuView];
    
}  



//活动
- (IBAction)activity:(id)sender {

//    NSString * imageUrl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1510654398&di=c61227bb9af6a501776a1ec921a40ace&src=http://p4.music.126.net/67ZIADz18ZfapZDmFRJP-Q==/7715273092856110.jpg";
//    EZActivityView * activityView = [[EZActivityView alloc]initWithUrl:imageUrl];
//
//    [activityView show];
//
//    activityView.detailBlock = ^(){
//
////        NSString * url =  [NSString stringWithFormat:@"%@%@",BASE_URL,activityDic[@"at_jumpLink"]];
////
////        complate(url);
//
//        NSLog(@"点击星期");
//
//    }; 
  
    
    NSDictionary * dic = @{@"at_id":@"1",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1510654398&di=c61227bb9af6a501776a1ec921a40ace&src=http://p4.music.126.net/67ZIADz18ZfapZDmFRJP-Q==/7715273092856110.jpg":@"at_selfLink"};
    ActivityShowView * showView =  [[ActivityShowView alloc]initWithDictionary:dic];
    
    showView.activityButton = ^(NSString * textStr){
        
//        [HPViewModel jumpPagetextStr:textStr];
    };
    [showView show];
    
    
    
}

//创建日历
- (IBAction)beginAcction:(id)sender {
   
    // 304
    
    MSSCalendarViewController *cvc = [[MSSCalendarViewController alloc]init];
    
    
     
    cvc.limitMonth = 1;// 显示几个月的日历
    /*
     MSSCalendarViewControllerLastType 只显示当前月之前
     MSSCalendarViewControllerMiddleType 前后各显示一半
     MSSCalendarViewControllerNextType 只显示当前月之后
     */
    cvc.type = MSSCalendarViewControllerMiddleType;
    cvc.beforeTodayCanTouch = YES;// 今天之后的日期是否可以点击
    cvc.afterTodayCanTouch = NO;// 今天之前的日期是否可以点击
//    cvc.startDate = _startDate;// 选中开始时间
//    cvc.endDate = _endDate;// 选中结束时间
    /*以下两个属性设为YES,计算中国农历非常耗性能（在5s加载15年以内的数据没有影响）*/
    cvc.showChineseHoliday = NO;// 是否展示农历节日
    cvc.showChineseCalendar = NO;// 是否展示农历
    cvc.showHolidayDifferentColor = YES;// 节假日是否显示不同的颜色
    cvc.showAlertView = YES;// 是否显示提示弹窗
//    cvc.delegate = self;
    [self presentViewController:cvc animated:YES completion:nil];
      
}





-(void)setUI{
    
    //创建底层的view
    UIView * backGroundView = [UIView new];
    [self.view addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    
    
    // 创建一个空view 代表上一个view
    __block UIButton *lastView = nil;
    // 间距为10
    int intes = 0;
    // 每行3个
    int num =  2;
    
    NSArray * imgs = @[@"money_blue",@"gift_blue"];
    NSArray * titles = @[@"我的得好币",@"邀请奖励"];
    for (int i=0; i< titles.count; i++) {
        UIButton * bgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backGroundView addSubview:bgBtn];
        
        // 添加约束
        [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            // 给个高度约束
            make.height.equalTo(backGroundView.mas_height);
            
            // 1. 判断是否存在上一个view
            if (lastView) {
                // 存在的话宽度与上一个宽度相同
                make.width.equalTo(lastView);
            } else {
                // 否则计算宽度  ！！！此处的判断条件是为了避免 最后一列约束冲突
                /**
                 *  这里可能大家会问 为什么上面我说最后一列会有冲突？
                 *  如果不添加判断的话会造成：
                 *  1添加了宽度约束 2所有列加了左侧约束 第3步给 最后一列添加了右侧约束
                 *  这里最后一列既有左侧约束又有右侧约束还有宽度约束 会造成约束冲突
                 *  所以这里添加宽度时将最后一列剔除
                 */
                if (i % num != 0) {
                    make.width.mas_equalTo((bgBtn.superview.frame.size.width - (num + 1)* intes)/4);
                }
            }
            // 2. 判断是否是第一列
            if (i % num == 0) {
                // 一：是第一列时 添加左侧与父视图左侧约束
                make.left.mas_equalTo(bgBtn.superview).offset(intes);
            } else {
                // 二： 不是第一列时 添加左侧与上个view左侧约束
                make.left.mas_equalTo(lastView.mas_right).offset(intes);
            }
            // 3. 判断是否是最后一列 给最后一列添加与父视图右边约束
            if (i % num == (num - 1)) {
                make.right.mas_equalTo(bgBtn.superview).offset(-intes);
            }
            // 4. 判断是否为第一列
            //            if (i / num == 0) {
            //                // 第一列添加顶部约束
            //                make.top.mas_equalTo(bgBtn.superview).offset(intes*10);
            //            } else {
            //                // 其余添加顶部约束 intes*10 是我留出的距顶部高度
            //                make.top.mas_equalTo(intes * 10 + ( i / num )* (80 + intes));
            //            }
            
            make.top.equalTo(backGroundView);
            
        }];
        // 每次循环结束 此次的View为下次约束的基准
        lastView = bgBtn;
        
        [bgBtn addTarget:self action:@selector(mMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        
        bgBtn.tag = i+1;
        
        
        //titleLab
        UILabel * nameLab = [UILabel new];
        [bgBtn addSubview:nameLab];
        [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.left.equalTo(bgBtn.mas_left);
            make.right.equalTo(bgBtn.mas_right);
            make.bottom.equalTo(bgBtn.mas_bottom).offset(-14);
        }];
        nameLab.textAlignment = NSTextAlignmentCenter;
        nameLab.text = titles[i];
        nameLab.font = [UIFont systemFontOfSize:16];
        
        
        //IMageView
        UIImageView * imgView = [UIImageView new];
        [bgBtn addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(bgBtn.mas_centerX);
            make.top.equalTo(bgBtn.mas_top).offset(15);
            make.bottom.equalTo(nameLab.mas_top).offset(-15);
            make.width.equalTo(imgView.mas_height);
        }];
        
        imgView.image = [UIImage imageNamed:imgs[i]];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.layer.masksToBounds = YES; 
        imgView.backgroundColor = [UIColor redColor];
        
        
        UILabel * bubbleLabel = [UILabel new];
        [bgBtn addSubview:bubbleLabel];
        [bubbleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.top.equalTo(imgView.mas_top).offset(-6);
            make.right.equalTo(imgView.mas_right).offset(6);
        }];
        
        bubbleLabel.backgroundColor = [UIColor whiteColor];
        bubbleLabel.tag = i+7000;
        bubbleLabel.textAlignment = NSTextAlignmentCenter;
        bubbleLabel.font = [UIFont systemFontOfSize:11];
        bubbleLabel.textColor = [UIColor redColor];
        bubbleLabel.layer.masksToBounds = YES;
        bubbleLabel.layer.cornerRadius  = 10;
        bubbleLabel.layer.borderColor = [UIColor redColor].CGColor;
        bubbleLabel.layer.borderWidth = 1.0;
        //        bubbleLabel.text = [NSString stringWithFormat:@"%d",i+1];
        bubbleLabel.alpha = 0.0;
        
        
        
    }
    
}


-(void)mMenuButton:(id)sender{
    NSLog(@"mMenuButton 点击了");
}





@end
