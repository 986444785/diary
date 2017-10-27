//
//  AppDelegate.m
//  Diary
//
//  Created by chenweibin on 2017/10/22.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "AppDelegate.h"
#import "ZYMainVC.h"
#import "IQKeyboardManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    /*
     //git使用
     首先选择上传的地方，比如码云，码市，github
     1.在github创建一个远程仓库
     2.创建一个本地仓库，git init   ， git status查看状态   ， git add .   把文件添加到工作区域，    git commit -m'测试' 将代码提交到本地仓库的master区域
     3.git remote add origin 地址  ，添加远程关联
     4.git push origin master 提交到远程仓库
     */
    
     
    /*
     git下载自己项目到本地
     假如外出工作，需要在另一台电脑上面pull自己的某个git远程项目到本地
     http://www.cnblogs.com/TTyb/p/6037548.html
     */
    
    // 解决弹起键盘遮盖输入框的问题
    [IQKeyboardManager sharedManager].enable = YES;
    
    [ZYMainVC MainViewControllerWithDelegate:self];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
