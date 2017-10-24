//
//  NetworkTool.m
//  06AFN封装网络中间层
//
//  Created by HM09 on 17/3/15.
//  Copyright © 2017年 itheima. All rights reserved.
//

#import "NetworkTool.h"

@implementation NetworkTool


/**
 创建网络请求工具的单例
 */
+ (instancetype) sharedTool {
    static NetworkTool *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[NetworkTool alloc] initWithBaseURL:nil];
        //设置客户端可以接收的数据类型
        tool.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
        
    }); 
    
    return tool;
}

  
-(void)zyRequestWithURL:(NSString *)urlStr   method: (NSString *)method  parameters:(id)parameters  success:(void (^)(id response))success failure:(void(^)(NSString *errorStr))failure{
    
       if([method isEqualToString:@"GET"]) {
           [self GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               //将AFN获取的数据, 原封不动地返回给controller
               success(responseObject);
               
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               
               
               if (error) { 
                   
                   if (error.code == 3840) {
                       
                       NSLog(@"3840错误"); 
                       
                       return ;
//                       str = @"3840";
                   }
                   NSString * str = @"连接服务器失败!";
                   
                   if (error.code == -1009) {
                       
                       str = @"似乎没有网络!";
                       
                   }else if (error.code == -1001){
                       
                       str = @"连接服务器失败!";
                   }
                   
                   failure(str);
                   
               
                   
               } 
           }];
            
       }else{
           //调用AFN发起POST请求
           
           NSLog(@"url %@  字典  %@",urlStr,parameters);
           
           [self POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               //将AFN获取的数据, 原封不动地返回给controller
               success(responseObject);
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               
               
               if (error) {
                   
                   if (error.code == 3840) {
                       NSLog(@"3840错误");
                       return ;
                   }
                   NSString * str = @"连接服务器失败!";
                   
                   if (error.code == -1009) {
                       
                       str = @"似乎没有网络!";
                       
                   }else if (error.code == -1001){
                       
                       str = @"连接服务器失败!";
                   }
                   
                   
                   failure(str);
           
                   
               }
           }];
       }

} 


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    NSLog(@"dic  %@",dic);
    return dic;
}







- (void) requestWithURL: (NSString *)urlStr
                 method: (NSString *)method
             parameters: (id) parameters
               callBack:(void(^)(id)) callBack {
    if([method isEqualToString:@"GET"]) {
        //调用AFN发起GET请求
        [self GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //将AFN获取的数据, 原封不动地返回给controller
            callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //如果请求失败, 也需要执行callBack, 告诉调用者请求失败了,不然调用者会一直等待
            
            if (error) { 
                
                if (error.code == 3840) {
                    return ;
                }
                NSString * str = @"连接服务器失败!";
                
                if (error.code == -1009) {
                    
                    str = @"似乎没有网络!";
                    
                }else if (error.code == -1001){
                    
                    str = @"连接服务器失败!";
                }
                
                
       
                
            }
 
             
            
            callBack(nil);
        }];
    }
     
    //调用AFN发起post请求
    if([method isEqualToString:@"POST"]) {
        //调用AFN发起POST请求
        [self POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //将AFN获取的数据, 原封不动地返回给controller
                callBack(responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            
            if (error) {
                
                
                NSString * str = @"连接服务器失败!";
                if (error.code == 3840) {
                    str = @"3840";
//                    return ;
                }
    
                
                if (error.code == -1009) {
                    
                    str = @"似乎没有网络!";
                    
                }else if (error.code == -1001){
                    
                    str = @"连接服务器失败!";
                }
                
                
        
                
            }
            
            callBack(nil);
        }];
    }
}





@end
