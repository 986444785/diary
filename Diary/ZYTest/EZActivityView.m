//
//  EZActivityView.m
//  EZStore
//
//  Created by PRO on 17/5/28.
//  Copyright © 2017年 BBC. All rights reserved.
// 

#import "EZActivityView.h"
#import <QuartzCore/QuartzCore.h>


@interface EZActivityView()

@property (nonatomic, strong) UIView *backImageView;


@end


@implementation EZActivityView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(id)initWithUrl:(NSString *)url{
    

    if (self  =[super init]) {
        self.backgroundColor  =[UIColor redColor];
        
        
        UIImageView * imageView = [UIImageView new];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {

            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.mas_height);

        }];
        imageView.backgroundColor  =[UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        
        UIButton * cancleButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [imageView addSubview:cancleButton];
        [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            

            make.top.equalTo(imageView.mas_top).offset(10);
            make.right.equalTo(imageView.mas_right).offset(-10);
            make.width.equalTo(@50);
            make.height.equalTo(@50);
        }];
        
        [cancleButton setImage:[UIImage imageNamed:@"activity_cancle"] forState:UIControlStateNormal];
        [cancleButton addTarget:self action:@selector(cancleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
         
        
        UIButton * detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageView addSubview:detailButton];
        [detailButton mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.width.equalTo(@90);
            make.height.equalTo(@30);
            make.centerX.equalTo(imageView.mas_centerX);
            make.bottom.equalTo(imageView.mas_bottom).offset(-10);
            
        }];
        [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
        detailButton.layer.borderWidth = 1.0;
        detailButton.layer.borderColor = [UIColor whiteColor].CGColor;
        detailButton.titleLabel.font =  [UIFont systemFontOfSize:14];
        [detailButton addTarget:self action:@selector(detailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
 
    }

    return self;
    
} 


-(void)detailButtonClick:(UIButton*)sender{
    
    [self dismissAlert];

    if (self.detailBlock) {
        
        self.detailBlock();
    }
    
}


-(void)cancleButtonClick:(UIButton*)sender{
    
    [self dismissAlert];
    
}

- (void)dismissAlert{
    [self removeFromSuperview];

}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    
    topVC.view.backgroundColor = [UIColor greenColor];
    
    self.frame = CGRectMake( KSCREEN_WIDTH*0.1, -(KSCREEN_HEIGHT-KSCREEN_WIDTH)/2, KSCREEN_WIDTH*0.8, KSCREEN_WIDTH);

    [topVC.view addSubview:self];
}


    


- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (void)removeFromSuperview
{
    [self.backImageView removeFromSuperview];
    self.backImageView = nil;
    

    [super removeFromSuperview];
    
}


- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        self.backImageView.alpha = 0.6f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
//    self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - KSCREEN_WIDTH*0.8) * 0.5, (CGRectGetHeight(topVC.view.bounds) - KSCREEN_WIDTH) * 0.5, KSCREEN_WIDTH*0.8, KSCREEN_WIDTH);
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}


@end
