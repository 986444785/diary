//
//  EZSortMenuView.m
//  EZStore
//
//  Created by PRO on 17/3/10.
//  Copyright © 2017年 BBC. All rights reserved.
//

#import "EZSortMenuView.h"

@interface EZSortMenuView ()<UIScrollViewDelegate>
{
    UIScrollView * bgScrollview;
    UIPageControl* pagecontrol;
}
@end

@implementation EZSortMenuView

-(instancetype)initWithFrame:(CGRect)frame data:(NSArray*)data{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self buildViewArray:data];
    }
    return self;
} 
 
-(void)buildViewArray:(NSArray *)titles {
    
    NSInteger num = titles.count;
    
    CGFloat menuViewWidth = self.frame.size.width;
    
      
    int totals = 5;
    
    NSInteger pageIndex = (num-1)/(totals*2) + 1;
    
    
    bgScrollview  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, menuViewWidth, self.frame.size.height)];
    bgScrollview.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgScrollview];
    bgScrollview.pagingEnabled = YES;
    
    bgScrollview.contentSize = CGSizeMake(menuViewWidth*pageIndex, bgScrollview.frame.size.height);
    bgScrollview.showsVerticalScrollIndicator = NO;
    bgScrollview.showsHorizontalScrollIndicator = NO;
    bgScrollview.delegate = self;
    
    
  
    if (pageIndex>1) {
        pagecontrol = [[UIPageControl alloc]initWithFrame:CGRectMake((bgScrollview.frame.size.width-60)/2, self.frame.size.height - 30, 60, 30)];
        [self addSubview:pagecontrol];
        pagecontrol.numberOfPages = pageIndex;
        pagecontrol.currentPage = 0;
        pagecontrol.currentPageIndicatorTintColor = [UIColor orangeColor];
        pagecontrol.pageIndicatorTintColor = SUBJECT_BGCOLOR;
        [pagecontrol addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
     
    CGFloat demoW = menuViewWidth/totals;
    CGFloat demoH = menuViewWidth/totals +3;
    CGFloat margin = (menuViewWidth - demoW*totals)/(totals+1);
    
    

    for (int i = 0 ; i < num; i++) {
        
        int row = i % (2*totals) / totals;
        
        int colums = i % totals;
        
        CGFloat width = i/(2*totals) * menuViewWidth;
        
        NSDictionary * dic = titles[i];


        UIButton * menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        menuButton.frame = CGRectMake(width + margin + (margin + demoW)*colums, row*10+15+ margin + (margin + demoH)*row, demoW, demoH);
        menuButton.tag = i;
        [menuButton addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [bgScrollview addSubview:menuButton];
        
//        menuButton.backgroundColor = [UIColor greenColor];
        
        
        UILabel * titleLab = [UILabel new];
        [menuButton addSubview:titleLab];
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(menuButton.mas_left).offset(5);
            make.right.equalTo(menuButton.mas_right).offset(-5);
            make.height.equalTo(@20);
            make.bottom.equalTo(menuButton.mas_bottom).offset(-5);
        }];
        if (KSCREEN_WIDTH>375) {
            titleLab.font = [UIFont systemFontOfSize:12];
        }else{
            titleLab.font = [UIFont systemFontOfSize:10];
        }
        titleLab.textAlignment = NSTextAlignmentCenter;
         
        titleLab.textColor = [UIColor grayColor];

        titleLab.text = dic[@"title"];

//                titleLab.text = @"名字";
        
//        titleLab.backgroundColor = [UIColor greenColor];

        
        UIImageView * logoImageView = [UIImageView new];
        [menuButton addSubview:logoImageView];
        [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(menuButton.mas_top).offset(1);
            make.bottom.equalTo(titleLab.mas_top).offset(-6);
            make.height.equalTo(logoImageView.mas_width);
            make.centerX.equalTo(menuButton.mas_centerX);
        }];
        logoImageView.backgroundColor = [UIColor greenColor];
        /*
        NSString * str = [dic objectForKey:@"ct_picture"];
        
        NSString * lastStr = [str stringByReplacingOccurrencesOfString:@"\\" withString:@"/"];
        NSString * imgUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,lastStr];
        imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"ErZhu/" withString:@""];
        
        [logoImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"news_defualt"]];
    
       */
        
    }
}


-(void)menuButtonAction:(UIButton*)sender{
    
    _SortMenuSelect(sender.tag);
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //更新UIPageControl的当前页
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    [pagecontrol setCurrentPage:offset.x / bounds.size.width];
}


-(void)pageControlClick:(UIPageControl *)pageCtrl{
    CGSize viewSize = bgScrollview.frame.size;
    CGRect rect = CGRectMake(pageCtrl.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    [bgScrollview scrollRectToVisible:rect animated:YES];
}






@end
