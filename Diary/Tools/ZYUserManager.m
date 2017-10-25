//
//  ZYUserManager.m
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "ZYUserManager.h"

static ZYUserManager * __userManager;

@implementation ZYUserManager

+(ZYUserManager *)shareManager{
      //为了防止多个线程同时判断单例是否存在，从而导致同时创建单例。判断的时候必须加线程同步。
    @synchronized (self) {
        if (!__userManager) {
            __userManager = [[ZYUserManager alloc]init];
            [__userManager getIP];
        }
    }  
    return __userManager;
}

 //为了防止人为创建单例类，重写alloc方法
+(id)alloc{
    //dispatch_once 的block中的代码当程序运行后只会被执行一次。
    //单例类的创建最好用dispatch_once。
    //使用dispatch_once就不需要再进行判断，也不需要关心线程同步。

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __userManager = [super alloc];
    });
    return __userManager;
}


-(void)getIP{
    
  _ip =  [[NSUserDefaults standardUserDefaults] objectForKey:@"IP"];
    
}
 

-(void)saveIP:(NSString *)IP{

    _ip = IP;
    
    [[NSUserDefaults standardUserDefaults] setObject:IP forKey:@"IP"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
}





@end
