//
//  CJNavigationController.m
//  CJNavigationController
//
//  Created by Jay_pc on 15/10/27.
//  Copyright © 2015年 CrazyCJay. All rights reserved.
//
 
#import "CJNavigationController.h"


#define CJScreenHeight [UIScreen mainScreen].bounds.size.height
#define CJScreenWidth [UIScreen mainScreen].bounds.size.width

#define CJOffsetFloat  0.65// 拉伸参数
#define CJOffetDistance 150// 最小回弹距离

@interface CJNavigationController ()<UIGestureRecognizerDelegate>

@property(nonatomic,assign) CGPoint mStartPoint;

@property(nonatomic,strong) UIImageView *mLastScreenShotView;

@property (nonatomic, strong) UIView *mBgView;

@property (nonatomic, strong) NSMutableArray *mScreenShots;

@property (nonatomic, assign) BOOL mIsMoving;


@end 

@implementation CJNavigationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cj_canDragBack = YES;
    }
    return self;
} 

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.layer.shadowOffset = CGSizeMake(0, 10);
    self.view.layer.shadowOpacity = 0.8;
    self.view.layer.shadowRadius = 10;
 
      
    /*
        UIScreenEdgePanGestureRecognizer *leftGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                                                                   initWithTarget:self
                                                                    action:@selector(didHandlePanGesture:)];
        leftGestureRecognizer.edges = UIRectEdgeLeft;
        [self.view addGestureRecognizer:leftGestureRecognizer];

     */
    
    
//    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didHandlePanGesture:)];
//    
//    [self.view addGestureRecognizer:pan];
//
//    NSLog(@"viewtag  这是不要滑动手势的界面 %d",self.view.tag);
    
 

} 


-(NSMutableArray *)mScreenShots{
    if (!_mScreenShots) {
        _mScreenShots = [NSMutableArray new];
    }
    return _mScreenShots;
}
//初始化截屏的view
-(void)initViews{
    if (!self.mBgView) {
        self.mBgView = [[UIView alloc]initWithFrame:self.view.bounds];
        self.mBgView.backgroundColor = [UIColor whiteColor];
    }
    BOOL flag = false;
    for (UIView *view in self.view.superview.subviews) {
        if (view == self.mBgView) {
            flag = true;
        }
    }
    if (!flag) {
        
        [self.view.superview insertSubview:self.mBgView belowSubview:self.view];
    }
    self.mBgView.hidden = NO;
    if (self.mLastScreenShotView) [self.mLastScreenShotView removeFromSuperview];
    UIImage *lastScreenShot = [self.mScreenShots lastObject];
    self.mLastScreenShotView = [[UIImageView alloc] initWithImage:lastScreenShot];
    self.mLastScreenShotView.frame = (CGRect){-(CJScreenWidth*CJOffsetFloat),0,CJScreenWidth,CJScreenHeight};
    [self.mBgView addSubview:self.mLastScreenShotView];
}
//改变状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController* topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        [self.mScreenShots addObject:[self capture]];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}
-(void)pushAnimation:(UIViewController *)viewController{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.2];
    [animation setType: kCATransitionMoveIn];
    [animation setSubtype: kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [super pushViewController:viewController animated:NO];
    [self.view.layer addAnimation:animation forKey:nil];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (animated) {
        [self popAnimation];
        return nil;
    } else {
        return [super popViewControllerAnimated:animated];
    }
}
- (void) popAnimation {
    if (self.viewControllers.count == 1) {
        return;
    }
    [self initViews];
    [UIView animateWithDuration:0.4 animations:^{
        [self doMoveViewWithX:CJScreenWidth];
    } completion:^(BOOL finished) {
        [self completionPanBackAnimation];
    }];
}


- (UIImage *)capture
{
    if (self.view.superview.superview.superview) {
        UIGraphicsBeginImageContextWithOptions(self.view.superview.superview.superview.bounds.size, self.view.superview.superview.superview.opaque, 0.0);
        [self.view.superview.superview.superview.layer renderInContext:UIGraphicsGetCurrentContext()];
    }else{
        UIGraphicsBeginImageContextWithOptions(self.view.superview.bounds.size, self.view.superview.opaque, 0.0);
        [self.view.superview.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


/**
 *   判断手势方向
 *
 *  @param translation translation description
 */
- (NSString *)commitTranslation:(CGPoint)translation
{
    
    CGFloat absX = fabs(translation.x);
    CGFloat absY = fabs(translation.y);
    
    // 设置滑动有效距离
    if (MAX(absX, absY) < 10)
        return nil;
    
    
    if (absX > absY ) {
        
        if (translation.x<0) {
            
            //向左滑动
             return @"向左滑动";
        }else{
           
            //向右滑动
             return @"向右滑动";
        }
        
    } else if (absY > absX) {
        if (translation.y<0) {
            
            //向上滑动
              return @"向上滑动";
        }else{
            
            //向下滑动
             return @"向下滑动";
        }
    }
    
    return nil;
    
}

#pragma mark ------------  UIPanGestureRecognizer -------

-(void)didHandlePanGesture:(UIPanGestureRecognizer *)recoginzer{
    
    
    if (recoginzer.state == UIGestureRecognizerStateChanged) {
  
        NSString * transPointStr =  [self commitTranslation:[recoginzer translationInView:self.view]];
   
        NSLog(@"滑动的方向 %@",transPointStr);
        if ([transPointStr isEqualToString:@"向左滑动"]) {
            
            return;
        }
    }
    
    
    
    
    
    
//    NSLog(@"navigation pan");
    if (self.viewControllers.count <= 1 && !self.cj_canDragBack) return;
    CGPoint touchPoint = [recoginzer locationInView:[[UIApplication sharedApplication]keyWindow]];
    
    CGFloat offsetX = touchPoint.x - self.mStartPoint.x;
    if(recoginzer.state == UIGestureRecognizerStateBegan)
    {
        [self initViews];
        _mIsMoving = YES;
        _mStartPoint = touchPoint;
        offsetX = 0;
    }
    
    if(recoginzer.state == UIGestureRecognizerStateEnded)
    {
        
        
        if (offsetX > CJOffetDistance)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self doMoveViewWithX:CJScreenWidth];
            } completion:^(BOOL finished) {
                [self completionPanBackAnimation];
                
                self.mIsMoving = NO;
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                [self doMoveViewWithX:0];
            } completion:^(BOOL finished) {
                self.mIsMoving = NO;
                self.mBgView.hidden = YES;
            }];
        }
        self.mIsMoving = NO;
    }
    if(recoginzer.state == UIGestureRecognizerStateCancelled)
    {
        [UIView animateWithDuration:0.3 animations:^{
            [self doMoveViewWithX:0];
        } completion:^(BOOL finished) {
            self.mIsMoving = NO;
            self.mBgView.hidden = YES;
        }];
        self.mIsMoving = NO;
    }
    if (self.mIsMoving) {
        [self doMoveViewWithX:offsetX];
    }
}
-(void)doMoveViewWithX:(CGFloat)x{
    x = x>CJScreenWidth?CJScreenWidth:x;
    x = x<0?0:x;
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    self.mLastScreenShotView.frame = (CGRect){-(CJScreenWidth*CJOffsetFloat)+x*CJOffsetFloat,0,CJScreenWidth,CJScreenHeight};
}
-(void)completionPanBackAnimation{
    [self.mScreenShots removeLastObject];
    [super popViewControllerAnimated:NO];
    CGRect frame = self.view.frame;
    frame.origin.x = 0;
    self.view.frame = frame;
    self.mBgView.hidden = YES;
}


@end
