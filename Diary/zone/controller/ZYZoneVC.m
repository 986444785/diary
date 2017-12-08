//
//  ZYZoneVC.m
//  Diary
//
//  Created by 配得好 on 2017/12/4.
//  Copyright © 2017年 chenweibin. All rights reserved.
//
 
#import "ZYZoneVC.h"
#import "WRNavigationBar.h"
#import "JCCollectionViewWaterfallLayout.h"
#import "sampleCell.h"
#import "describeCell.h"
//#import "ZYZoneHeader.h"
#import "PersonalVC.h"
#import "ZYCustNavView.h"
#import "ZYZoneHeader.h"
#import "ZYTitleHeaderView.h"

@interface ZYZoneVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat NavViewHeight;
}
@property(nonatomic) ZYCustNavView * navbgImgView;

@property(nonatomic) UICollectionView * collectionview;
@property(nonatomic)  ZYZoneHeader *headerView;
 
@end

@implementation ZYZoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    [self buildTableview];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
  

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)buildTableview{
 
    JCCollectionViewWaterfallLayout * flowLayout = [[JCCollectionViewWaterfallLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.headerReferenceSize = CGSizeMake(0, 44);
 
    
    _collectionview = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionview.delegate = self;
    _collectionview.dataSource = self;
    _collectionview.showsVerticalScrollIndicator = NO;
    _collectionview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionview];
    
    [_collectionview registerClass:[sampleCell class] forCellWithReuseIdentifier:@"sampleCell"];
    [_collectionview registerClass:[describeCell class] forCellWithReuseIdentifier:@"describeCell"];
    //组头
    [_collectionview registerClass:[ZYTitleHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ZYTitleHeaderView"];


    // 最重要的一句代码!!!
    _collectionview.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    _collectionview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    

    // 注意这里设置headerView的头视图的y坐标一定是从"负值"开始,因为headerView是添加在collectionView上的.
    _headerView = [[ZYZoneHeader alloc]initWithFrame:CGRectMake(0, -XSIZE(200), self.view.frame.size.width, XSIZE(200))];
    [_collectionview addSubview:_headerView];
    
    
    [self createNavbgImgView];
}

#pragma mark  ---自定义导航栏
-(void)createNavbgImgView{
    NavViewHeight  = 64;
    _navbgImgView = [[ZYCustNavView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, NavViewHeight)];
    [self.view addSubview:_navbgImgView];
    //添加一个名字
//    _navbgImgView.titleLabel.text = @"血蹄~凯恩~金";
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
     
    if (y < -200) {
        //--------------------------修改后--------------------------------
        /** 让其XYWH都‘拉伸’ */
        /** Ky --> 正值的下拉多少距离的值，Kx--> 根据Ky成比例的让x变 */
        CGFloat Ky = -scrollView.contentOffset.y-200;
        CGFloat Kx = (Ky/200)*KSCREEN_WIDTH/2;
        
        _headerView.frame = CGRectMake(0-Kx, 0-Ky-200,
                                           KSCREEN_WIDTH+2*Kx, 200+Ky);
    } 
    //设置导航栏渐变
    CGFloat alphaOffset = (100+y) / (NavViewHeight) ;
    
    self.navbgImgView.alpha = alphaOffset;
}

 
#pragma mark ---组头部
// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(KSCREEN_WIDTH, 44);
    }
    else {
        return CGSizeMake(0, 0);
    }
}
 
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
    ZYTitleHeaderView *header=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ZYTitleHeaderView" forIndexPath:indexPath];
    return header;
}



#pragma mark  UICollectionViewDatasource
#pragma mark  --- //多少个区

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return self.baseData.count;
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if(section == 0){
        return 1;
    }
    return 20;
}


 
#pragma mark 自定义layout方法  每行的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout columnCountForSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }
    return 2;
}

#pragma mark  --- 每个cell 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {

        return CGSizeMake(KSCREEN_WIDTH, 100);
    }

    return CGSizeMake(KSCREEN_WIDTH / 2 -18, KSCREEN_WIDTH / 2 -18);;
}
 

#pragma mark 设置单元格间的横向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 3.0;
}
#pragma mark cell与四周的距离
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(3, 3, 1, 3);
}
#pragma mark 设置单元格间的纵向间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3.0;
}

/*
 - (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout heightForFooterInSection:(NSInteger)section{
 
 if ((self.baseData.count-1) == section) {
 return 0;
 }
 return  10;
 }
 */


#pragma mark  --- cell设置
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        describeCell * descell = [collectionView dequeueReusableCellWithReuseIdentifier:@"describeCell" forIndexPath:indexPath];
        return descell;
    }
    
    sampleCell * samplecell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"sampleCell" forIndexPath:indexPath];
    return samplecell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选中:%ld",(long)indexPath.row);
    
    PersonalVC * vc = [[PersonalVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
