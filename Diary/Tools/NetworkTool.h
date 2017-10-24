//
//  NetworkTool.h
//  06AFN封装网络中间层
//
//  Created by HM09 on 17/3/15.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "AFHTTPSessionManager.h"
 
@interface NetworkTool : AFHTTPSessionManager

+ (instancetype) sharedTool; 

/**
 调用AFN发起网络请求, 成功之后回调

 @param urlStr url的字符串
 @param method 请求方式
 @param parameters 请求参数字典
 @param callBack 完成回调block
 */
- (void) requestWithURL: (NSString *)urlStr
                 method: (NSString *)method
             parameters: (id) parameters
               callBack:(void(^)(id)) callBack;


    
-(void)zyRequestWithURL:(NSString *)urlStr   method: (NSString *)method  parameters:(id)parameters success:(void (^)(id response))success failure:(void(^)(NSString *errorStr))failure;





@end
