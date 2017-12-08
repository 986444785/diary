//
//  ZYMainVC.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYMainVC.h"
#import "AppDelegate.h"
#import "CJNavigationController.h"
#import "LLTabBar.h"
#import "HomePageVC.h"
#import "DiaryVC.h"
#import "MyVC.h"
#import "ZYTestView.h"
#import "ZYZoneVC.h"
#import "publicVC.h"
#import "ZYTabBarController.h"

@interface ZYMainVC () 

@end
 
@implementation ZYMainVC 

- (void)viewDidLoad { 
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

+(void)MainViewControllerWithDelegate:(id)delegate{
    
    ZYZoneVC   * homevc     = [[ZYZoneVC alloc]init];
    DiaryVC    * diaryvc    = [[DiaryVC alloc]init];
    publicVC   * myvc3      = [[publicVC alloc]init];
    MyVC       * myvc       = [[MyVC alloc]init];
    ZYTestView * testvc     = [[ZYTestView alloc]init];
     
    CJNavigationController * nav0 = [[CJNavigationController alloc]initWithRootViewController:homevc];
    CJNavigationController * nav1 = [[CJNavigationController alloc]initWithRootViewController:diaryvc];
    CJNavigationController * nav2 = [[CJNavigationController alloc]initWithRootViewController:myvc3];
    CJNavigationController * nav3 = [[CJNavigationController alloc]initWithRootViewController:myvc];
    CJNavigationController * nav4 = [[CJNavigationController alloc]initWithRootViewController:testvc];
    
    ZYTabBarController * tabBarController = [[ZYTabBarController alloc]init];
    tabBarController.viewControllers = @[nav0,nav1,nav2,nav3,nav4];
       
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    CGRect rect  = tabBarController.tabBar.bounds;
    
    if (KIsiPhoneX) {
        rect.size.height = 83;
    }
    
    NSLog(@"rect  %f",rect.size.height);
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:rect];
//    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
//    tabBar.backgroundColor = [UIColor greenColor];
    
//    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
 
    
    
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"bar_home", kLLTabBarItemAttributeSelectedImageName : @"bar_home_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},@{kLLTabBarItemAttributeTitle : @"日记", kLLTabBarItemAttributeNormalImageName : @"bar_diary", kLLTabBarItemAttributeSelectedImageName : @"bar_diary_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
        @{kLLTabBarItemAttributeTitle : @"分类", kLLTabBarItemAttributeNormalImageName : @"bar_found", kLLTabBarItemAttributeSelectedImageName : @"bar_found_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
        @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"bar_my_select", kLLTabBarItemAttributeSelectedImageName : @"bar_my", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},@{kLLTabBarItemAttributeTitle : @"首页", kLLTabBarItemAttributeNormalImageName : @"bar_home", kLLTabBarItemAttributeSelectedImageName : @"bar_home_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
     
    [tabBarController.tabBar addSubview:tabBar];
     
    AppDelegate * app = delegate;
    app.window.rootViewController = tabBarController;
}  


+(void)initialize
{
    /*
    [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    //设置整体导航栏颜色
    //        [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //设置导航颜色
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
 
    //返回按钮
    UIImage * backButtonImage2 = [[UIImage imageNamed:@""] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 0, 0)];
    
    [[UIBarButtonItem appearance]setBackgroundImage:backButtonImage2 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    */
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
