//
//  dModel.m
//  Diary
//
//  Created by 配得好 on 2017/10/20.
//  Copyright © 2017年 配得好. All rights reserved.
//

#import "dModel.h"

@implementation dModel


 
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
   
    
    NSString * url = dic[@"imageUrl"];
    
    _imageUrl = [NSString stringWithFormat:@"%@%@",[ZYUserManager shareManager].ip,url];
    
   return  YES ;
}

@end
