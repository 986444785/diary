//
//  ZYTabBarController.m
//  Diary
//
//  Created by 配得好 on 2017/12/5.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYTabBarController.h"

@interface ZYTabBarController ()

@end

@implementation ZYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    if (KIsiPhoneX) { 
         
        CGRect frame = self.tabBar.frame; 
        frame.size.height = 83;
        frame.origin.y = self.view.frame.size.height - frame.size.height;
        self.tabBar.frame = frame;
//        for (UITabBarItem *item in self.tabBar.items) {
//            item.imageInsets = UIEdgeInsetsMake(15,0, -15, 0);
//            [item setTitlePositionAdjustment:UIOffsetMake(0, 32)];
//        }
    }
}

-(BOOL)prefersHomeIndicatorAutoHidden{
    return YES;
}

@end
