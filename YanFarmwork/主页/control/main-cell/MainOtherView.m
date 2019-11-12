//
//  MainOtherView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MainOtherView.h"

#import "ResultQueryViewController.h"
#import "BannerCollectionViewCell.h"

#import "YLDragZoomCycleView.h"

@interface MainOtherView ()< UICollectionViewDelegate, UICollectionViewDataSource, YLDroagViewDelegate>

@property (retain, nonatomic) UICollectionViewFlowLayout *titleFlowLayout;
@property (retain, nonatomic) UICollectionView *titleCollectionView;

@property(nonatomic, strong) YLDragZoomCycleView *dragView;
@property (retain, nonatomic) NSMutableArray *bannerImageArray;


@end

@implementation MainOtherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self createCollectionView];
        [self createBannerView];
    });
    
}

- (void)createBannerView {
    
//    NSMutableArray *imageMutableArray = [NSMutableArray array];
//    for (int i = 0; i < _bannerImageArray.count; i++) {
//        [imageMutableArray addObject:[[_bannerImageArray objectAtIndex:i] objectForKey:@"ImageUrl"]];
//    }
    
    _bannerImageArray = [@[
                           @"http://e.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg",
                           @"http://b.hiphotos.baidu.com/image/h%3D300/sign=ad628627aacc7cd9e52d32d909032104/32fa828ba61ea8d3fcd2e9ce9e0a304e241f5803.jpg",
                           @"http://f.hiphotos.baidu.com/image/pic/item/b151f8198618367aa7f3cc7424738bd4b31ce525.jpg"] mutableCopy];
    
        //创建轮播图
        self.dragView = [[YLDragZoomCycleView alloc] initWithFrame:_collectionView.bounds andAutoScroll:YES scrollInterval:3];
        [self.dragView setBackgroundColor:[UIColor lightGrayColor]];
        self.dragView.kPageControH = 45;
        self.dragView.delegate = self;
        self.dragView.dataSource = _bannerImageArray;
        [_collectionView addSubview:self.dragView];

}
#pragma mark - YLDragZoomCycleViewDelegate
- (void)didSelectedItem:(NSInteger)item {
    NSLog(@"选择了第%ld张图片",item+1);
//    if ([[[_bannerImageArray objectAtIndex:item] objectForKey:@"Url"] length] == 0) {
//        return;
//    }
//    AdWebViewController *adVC = [[AdWebViewController alloc] initWithNibName:@"AdWebViewController" bundle:nil];
//    adVC.AdDict = [_bannerImageArray objectAtIndex:item];
//    adVC.urlStr = [[_bannerImageArray objectAtIndex:item] objectForKey:@"Url"];
//    adVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:adVC animated:YES];
    
}


#pragma mark CollectionView ---------------------------------
- (void)createCollectionView{
    
    float width = (_collectionView.frame.size.width)/4*3;
    
    _titleFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_titleFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    _titleFlowLayout.minimumLineSpacing = 0.0f;
//    _titleFlowLayout.minimumInteritemSpacing = 0.0f;
    _titleFlowLayout.itemSize = CGSizeMake(width, _collectionView.frame.size.height);
    
    [_titleCollectionView removeFromSuperview];
    _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _collectionView.frame.size.width, _collectionView.frame.size.height) collectionViewLayout:_titleFlowLayout];
    _titleCollectionView.delegate = self;
    _titleCollectionView.dataSource = self;
    _titleCollectionView.allowsMultipleSelection = NO;
    [_titleCollectionView setBackgroundColor:[UIColor clearColor]];
    _titleCollectionView.showsHorizontalScrollIndicator = NO;
    _titleCollectionView.showsVerticalScrollIndicator = NO;
    _titleCollectionView.pagingEnabled = NO;
    
    static NSString *cityHistoryCell = @"BannerCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"BannerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell];
    
    [_collectionView addSubview:_titleCollectionView];
}
#pragma mark - UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = [ToolsObject getText:[_dataArr objectAtIndex:indexPath.row] withTextSize:CGSizeMake(self.frame.size.width, _myHeight) withTextFont:16];
//
//    return CGSizeMake(size.width+10, _myHeight);
//}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        static NSString *collectionID = @"BannerCollectionViewCell";
        
        BannerCollectionViewCell *cell = (BannerCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
        
        
        cell.layer.cornerRadius = 3.0f;
        cell.layer.masksToBounds = YES;
        
        
        return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}




@end
