//
//  LLTabBar.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLTabBar.h"
//#import "ShopCartCountManger.h"
@interface LLTabBar ()

@property (strong, nonatomic) NSMutableArray *tabBarItems;

@end 

@implementation LLTabBar

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self config];
	}
	 
	return self;
}
 
#pragma mark - Private Method
 
- (void)config { 
	self.backgroundColor = [UIColor whiteColor];
	UIImageView *topLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, -1, KSCREEN_WIDTH, 1)];
    topLine.backgroundColor = [UIColor whiteColor];
//    topLine.backgroundColor = SUBJECT_BGCOLOR;
//	topLine.image = [UIImage imageNamed:@"tapbar_top_line"];
	[self addSubview:topLine];
}

- (void)setSelectedIndex:(NSInteger)index {
	for (LLTabBarItem *item in self.tabBarItems) {
		if (item.tag == index) {
			item.selected = YES;
		} else {
			item.selected = NO;
		}
	} 
	
	UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
	UITabBarController *tabBarController = (UITabBarController *)keyWindow.rootViewController;
	if (tabBarController) {
		tabBarController.selectedIndex = index;
	}
}

#pragma mark - Touch Event

- (void)itemSelected:(LLTabBarItem *)sender {
	if (sender.tabBarItemType != LLTabBarItemRise) {
		[self setSelectedIndex:sender.tag];
	} else {
		if (self.delegate) {
			if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedRiseButton)]) {
				[self.delegate tabBarDidSelectedRiseButton];
			}
		}
	}
}  
 
#pragma mark - Setter

- (void)setTabBarItemAttributes:(NSArray<NSDictionary *> *)tabBarItemAttributes {
	_tabBarItemAttributes = tabBarItemAttributes.copy;
    
    NSAssert(_tabBarItemAttributes.count > 2, @"TabBar item count must greet than two.");
    
    CGFloat normalItemWidth = (KSCREEN_WIDTH * 3 / 4) / (_tabBarItemAttributes.count - 1);
    CGFloat tabBarHeight = CGRectGetHeight(self.frame);
    CGFloat publishItemWidth = (KSCREEN_WIDTH / 4);
    
	NSInteger itemTag = 0;
    BOOL passedRiseItem = NO;  
    
    _tabBarItems = [NSMutableArray arrayWithCapacity:_tabBarItemAttributes.count];
    
    NSInteger rct_y  = KIsiPhoneX ? 33 : 0;
    
	for (id item in _tabBarItemAttributes) {
		if ([item isKindOfClass:[NSDictionary class]]) {
            NSDictionary *itemDict = (NSDictionary *)item;
            
            LLTabBarItemType type = [itemDict[kLLTabBarItemAttributeType] integerValue];
            
            CGRect frame = CGRectMake(itemTag * normalItemWidth + (passedRiseItem ? publishItemWidth : 0), -rct_y, type == LLTabBarItemRise ? publishItemWidth : normalItemWidth, tabBarHeight);
            
            LLTabBarItem *tabBarItem = [self tabBarItemWithFrame:frame
                                                         title:itemDict[kLLTabBarItemAttributeTitle]
                                               normalImageName:itemDict[kLLTabBarItemAttributeNormalImageName]
                                             selectedImageName:itemDict[kLLTabBarItemAttributeSelectedImageName] tabBarItemType:type];
			if (itemTag == 0) {
				tabBarItem.selected = YES;
			}
            
			[tabBarItem addTarget:self action:@selector(itemSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            if (tabBarItem.tabBarItemType != LLTabBarItemRise) {
                tabBarItem.tag = itemTag;
                itemTag++;
            } else {
                passedRiseItem = YES;
            }
            
            [_tabBarItems addObject:tabBarItem];
			[self addSubview:tabBarItem];
		}
	}
} 
 
- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
//    [item setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [item setTitleColor:[UIColor colorWithRed:212/255.0 green:35/255.0 blue:122/255.0 alpha:1] forState:UIControlStateSelected];
    item.tabBarItemType = tabBarItemType;
    
    
    //添加消息的气泡   mark 2017-03-14
        if ([title isEqualToString:@"购物车"]) {
            UILabel * bubbleLab = [UILabel new];
            [item addSubview:bubbleLab];
            [bubbleLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(item.mas_centerX).offset(3);
                make.bottom.equalTo(item.mas_centerY).offset(-3);
                make.height.equalTo(@16);
                make.width.greaterThanOrEqualTo(@16);
//                make.width.lessThanOrEqualTo(@16);
            }];
     
            bubbleLab.layer.masksToBounds = YES;
            bubbleLab.layer.cornerRadius = 8;
            bubbleLab.backgroundColor = [UIColor redColor];
            bubbleLab.textAlignment = NSTextAlignmentCenter;
    
//            bubbleLab.text = @"  99+";
    
            bubbleLab.alpha = 0.0;
            bubbleLab.tag = 8080;
            bubbleLab.textColor = [UIColor whiteColor];
            bubbleLab.font = [UIFont systemFontOfSize:12];
    
   
            
        }

    return item;
}
















@end
