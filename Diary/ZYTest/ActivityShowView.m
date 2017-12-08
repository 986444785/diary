//
//  ActivityShowView.m
//  EZStore
//
//  Created by PRO on 17/6/28.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import "ActivityShowView.h"
#define kActionSheetColor            [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f]

@interface ActivityShowView ()

@property (nonatomic, weak) UIView *cover;
@property (nonatomic, weak) UIView *actionSheet;
@property (nonatomic, assign) CGFloat actionSheetHeight;
@property (nonatomic) NSDictionary * dictionary;

@property(nonatomic) NSString * textStr;

@end 

@implementation ActivityShowView

-(instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super initWithFrame: [UIScreen mainScreen].bounds];
    if (self) { 

        _dictionary = dictionary;
        
        _actionSheetHeight = 300;
        
        [self setupCover];
        
        [self configUI];
        
    }
    return self;
} 
    



- (void)setupCover {
    
    [self addSubview:({
        UIView *cover = [[UIView alloc] init];
        cover.frame = self.bounds;
        cover.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.33];
        cover.alpha = 0;
//        [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        _cover = cover;
    })];
}

#pragma mark - Setup UI 
-(void)configUI{
    
//    CGFloat imageWidth = 0.8*KSCREEN_WIDTH;
     
    UIImageView * showimageview = [UIImageView new];
    showimageview.backgroundColor = [UIColor whiteColor];
    [_cover addSubview:showimageview];
    
    showimageview.userInteractionEnabled = YES;
//    [showimageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick)]];
    
    [showimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_cover.mas_centerX);
        make.centerY.equalTo(_cover.mas_centerY);
//        make.width.equalTo(@(imageWidth));
        make.width.equalTo(@240);
        make.height.equalTo(@280);
    }];
    showimageview.layer.masksToBounds =  YES;
    showimageview.layer.cornerRadius = 8;
    

    
    
    
    /*
    _textStr =  [NSString stringWithFormat:@"%@",_dictionary[@"at_id"]];
    
    NSString * imgurl =  [ToolCategory imageUrlMatching:_dictionary[@"at_selfLink"]];
    
    imgurl = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1510654398&di=c61227bb9af6a501776a1ec921a40ace&src=http://p4.music.126.net/67ZIADz18ZfapZDmFRJP-Q==/7715273092856110.jpg";
    
    [showimageview sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:nil];
    
    [showimageview sd_setImageWithURL:[NSURL URLWithString:imgurl]  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        CGFloat  height  = image.size.height* imageWidth/   (image.size.width+1)   ;
        [showimageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(height));
        }];
    }];
    showimageview.contentMode = UIViewContentModeScaleAspectFit;
    */

    
    
    
    //取消按钮
    UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cover addSubview:cancleButton];
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(showimageview.mas_right).offset(-5);
        make.top.equalTo(showimageview.mas_top).offset(2);
        make.width.equalTo(@44);
        make.height.equalTo(@44);
    }];
//    cancleButton.backgroundColor = [UIColor redColor];
    [cancleButton setImage:[UIImage imageNamed:@"delete_02"] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];

    
    
    //
    UIImageView * topImageview = [UIImageView new];
    [showimageview addSubview:topImageview];
    [topImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(showimageview.mas_left);
        make.top.equalTo(showimageview.mas_top);
        make.width.equalTo(showimageview.mas_width);
        make.height.equalTo(showimageview.mas_width).multipliedBy(0.42);
    }];

    topImageview.backgroundColor = [UIColor greenColor];
    topImageview.image = [UIImage imageNamed:@"sign_panel_bg"];
    
    
    
    
    
    //标题
    UILabel * titleLabel = [UILabel new];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showimageview.mas_centerX);
        make.top.equalTo(topImageview.mas_bottom).offset(20);
    }];
    titleLabel.text = @"签到成功";
//        [_centerLabel setFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:24]];
    
    
    //中间部分
    UILabel * moneyLabel = [UILabel new];
    [self addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(showimageview.mas_centerX);
        make.top.equalTo(titleLabel.mas_bottom).offset(20);
        
    }];
    moneyLabel.text = @"10.0";
    [moneyLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];

    
    UIImageView * leftImageview = [UIImageView new];
    [self addSubview:leftImageview];
    [leftImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyLabel.mas_left).offset(-3);
        make.centerY.equalTo(moneyLabel.mas_centerY);
    }];
    leftImageview.image = [UIImage imageNamed:@"add_orange"];
    
  
    
    
    UIImageView * rightImageview = [UIImageView new];
    [self addSubview:rightImageview];
    [rightImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLabel.mas_right).offset(3);
        make.centerY.equalTo(moneyLabel.mas_centerY);
    }];
    rightImageview.image = [UIImage imageNamed:@"money_orange"];
    
    
    
    //跳转按钮
    UIButton * moneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cover addSubview:moneyButton];
    [moneyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.mas_centerX);
        make.width.equalTo(@137);
        make.height.equalTo(@47);
        make.bottom.equalTo(showimageview.mas_bottom).offset(-20);
    }];
    //    moneyButton.backgroundColor = [UIColor redColor];
    [moneyButton setTitle:@"我的得好币" forState:UIControlStateNormal];
    [moneyButton setBackgroundImage:[UIImage imageNamed:@"btn_orange"] forState:UIControlStateNormal];
    [moneyButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)imageViewClick{
     
    if (_activityButton) {
        _activityButton(_textStr);
    }
    [self dismiss];
    
}

- (void)show {
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    
    self.cover.alpha = 1.0;
    
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//         usingSpringWithDamping:0.9
//          initialSpringVelocity:0.7
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//                         self.cover.alpha = 1.0;
//                         self.actionSheet.transform = CGAffineTransformMakeTranslation(0, -self.actionSheetHeight);
//                     }
//                     completion:nil];
}

   
- (void)dismiss {
    
  
    /*
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.9
          initialSpringVelocity:0.7
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.cover.alpha = 0.0;
                         self.actionSheet.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
     */
             [self removeFromSuperview];
}


@end
