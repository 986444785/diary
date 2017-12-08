//
//  UserModel.m
//  Diary
//
//  Created by 配得好 on 2017/10/27.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic{
    
    
    NSString * url  = dic[@"image"];
    
    _image = [NSString stringWithFormat:@"%@%@",[ZYUserManager shareManager].ip,url];
     
    return  YES ;
     
}
 

 

@end
 
