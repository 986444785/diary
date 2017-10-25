//
//  ZYMainVC.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYMainVC.h"
#import "AppDelegate.h"
#import "LLTabBar.h"
#import "CJNavigationController.h"
#import "DiaryVC.h"
#import "MyVC.h"
@interface ZYMainVC ()

@end

@implementation ZYMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

+(void)MainViewControllerWithDelegate:(id)delegate{
    
    DiaryVC * diaryvc = [[DiaryVC alloc]init];
    
    MyVC * myvc = [[MyVC alloc]init];
    
        MyVC * myvc3 = [[MyVC alloc]init];
    
     CJNavigationController * nav1 = [[CJNavigationController alloc]initWithRootViewController:diaryvc];
     CJNavigationController * nav2 = [[CJNavigationController alloc]initWithRootViewController:myvc];
       CJNavigationController * nav3 = [[CJNavigationController alloc]initWithRootViewController:myvc3];
    
    UITabBarController * tabBarController = [[UITabBarController alloc]init];
    tabBarController.viewControllers = @[nav1,nav2,nav3];

    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"日记", kLLTabBarItemAttributeNormalImageName : @"bar_home", kLLTabBarItemAttributeSelectedImageName : @"bar_home_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"分类", kLLTabBarItemAttributeNormalImageName : @"bar_type", kLLTabBarItemAttributeSelectedImageName : @"bar_type_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"我的", kLLTabBarItemAttributeNormalImageName : @"bar_myself", kLLTabBarItemAttributeSelectedImageName : @"bar_myself_select", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    
       [tabBarController.tabBar addSubview:tabBar];
    
    AppDelegate * app = delegate;
    app.window.rootViewController = tabBarController;
}

+(void)initialize
{
    
    [[UINavigationBar appearance]setTintColor:[UIColor grayColor]];
    //设置整体导航栏颜色
    //        [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //设置导航颜色
    [[UINavigationBar appearance]setBarTintColor:[UIColor whiteColor]];
    
    //返回按钮
    UIImage * backButtonImage2 = [[UIImage imageNamed:@""] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 30, 0, 0)];
    
    [[UIBarButtonItem appearance]setBackgroundImage:backButtonImage2 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    //将返回按钮的文字position设置不在屏幕上显示
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(NSIntegerMin, NSIntegerMin) forBarMetrics:UIBarMetricsDefault];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
