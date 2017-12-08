//
//  MyViewModel.h
//  Diary
//
//  Created by 配得好 on 2017/11/21.
//  Copyright © 2017年 chenweibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYTabHeaderView.h"
@interface MyViewModel : NSObject

@property(nonatomic,assign) id delegatevc;


//-(void)requestUserInfo;

-(void)my_actionDelegate:(id)delegate;

/**
 *  请求个人资料
 *  headerView
 **/
-(void)requestUserInfoWithHeaderView:(ZYTabHeaderView*)headerView;
@end
   
 
