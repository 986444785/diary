//
//  ZYUserManager.h
//  Diary
//
//  Created by 配得好 on 2017/10/24.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYUserManager : NSObject

/**
 *  创建单例
 */
+(ZYUserManager *)shareManager;
 
/**
 *  IP
 */
@property(nonatomic,copy) NSString * ip;

/** 
 *  用户id
 */
@property(nonatomic,copy) NSString * userID;

/**
 * 保存新的ip
 */
-(void)saveIP:(NSString *)IP;





@end
