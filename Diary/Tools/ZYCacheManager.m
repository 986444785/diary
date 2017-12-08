//
//  ZYCacheManager.m
//  EZStore
//
//  Created by PRO on 17/7/6.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import "ZYCacheManager.h"
#import "ToolCategory.h"

@implementation ZYCacheManager

#pragma mark --------------本地--------------


//清除缓存
+(void)clearCatch{
    
    NSString * path = [self getSavePathFileName:HOMEPAGE_CACHE];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL res=[fileManager removeItemAtPath:path error:nil];
    
    if (res) {
        
        NSLog(@"文件删除成功");
        
    }else{
        
        NSLog(@"文件删除失败");
    }
    
    NSLog(@"文件是否存在: %@",[fileManager isExecutableFileAtPath:path]?@"YES":@"NO");

}


+(void)saveCacheWithDatas:(NSArray *)datas FileName:(NSString *)fileName{
    
    //判断一下，一天只缓存一次
    NSString * locationDay = [[NSUserDefaults standardUserDefaults] objectForKey:fileName];
    NSString * currentDay = [ToolCategory nowDay];
    if ([locationDay isEqualToString:currentDay]) {
        
        
    }else{
    
//        NSLog(@"进行缓存   %@",fileName);
        
        [[NSUserDefaults standardUserDefaults] setObject:currentDay forKey:fileName];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self locationDataSaveData:datas fileName:fileName];
        
    }
    
}
 
 
 
//本地缓存
+(void)locationDataSaveData:(NSArray *)datas fileName:(NSString *)fileName{
    
    NSString * path = [self getSavePathFileName:fileName];
    
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:datas];
    [data writeToFile:path atomically:YES];
} 
    
//读取存储
+(void)getLocationDataFileName:(NSString *)fileName complate:(void(^)(NSArray * dataArray))complate {
    
    NSString * path =  [self getSavePathFileName:fileName];
    
    NSFileManager * filemanager = [NSFileManager defaultManager];
    BOOL isExit = [filemanager fileExistsAtPath:path];
    if (isExit) { 
        NSData * data = [NSData dataWithContentsOfFile:path];
        NSArray * arrays = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
            NSLog(@" 恭喜 🎉 获取缓存  成功!!!");
        complate(arrays);
         
    }else{
        NSLog(@"获取缓存  失败了");
    }
}

//存储路径
+(NSString *)getSavePathFileName:(NSString *)fileName{
    
    NSString * path = NSHomeDirectory();
    
    NSString * file = [NSString stringWithFormat:@"/Documents/%@.plist",fileName];
    
    NSString * filePath = [path stringByAppendingString:file];
    
    return filePath;
    
}








@end
