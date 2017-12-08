//
//  ZYCacheManager.h
//  EZStore
//
//  Created by PRO on 17/7/6.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HOMEPAGE_CACHE   @"homepage_cache"
#define HOMEPAGEBANNER_CACHE   @"homepagebanner_cache"

 
@interface ZYCacheManager : NSObject

 
//本地缓存
+(void)saveCacheWithDatas:(NSArray *)datas FileName:(NSString *)fileName;
//+(void)locationDataSaveData:(NSArray *)datas fileName:(NSString *)fileName;


//读取存储
+(void)getLocationDataFileName:(NSString *)fileName complate:(void(^)(NSArray * dataArray))complate;


+(void)clearCatch;
   
  
 
/**
 *  每次都进行 本地缓存
 */
+(void)locationDataSaveData:(NSArray *)datas fileName:(NSString *)fileName;
@end
