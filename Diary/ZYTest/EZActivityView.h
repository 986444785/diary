//
//  EZActivityView.h
//  EZStore
//
//  Created by PRO on 17/5/28.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZActivityView : UIView

-(id)initWithUrl:(NSString *)url;

-(void)show;


@property (nonatomic, copy) dispatch_block_t detailBlock;

   
 
@end
 
 
 
