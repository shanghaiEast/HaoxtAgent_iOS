//
//  MainTopView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MainTopView.h"

#import "PartnersViewController.h"
#import "TradingViewController.h"
#import "SettlementManagerViewController.h"
#import "TerminalMainViewController.h"
#import "MachinesProcurementViewController.h"
#import "WithdrawalViewController.h"
#import "MerchantServicesViewController.h"
#import "NewChartPieViewController.h"
#import "TeamManagementViewController.h"
#import "MainTopViewCollectionViewCell.h"



@interface MainTopView ()< UICollectionViewDelegate, UICollectionViewDataSource>


@property (retain, nonatomic) UICollectionViewFlowLayout *titleFlowLayout;
@property (retain, nonatomic) UICollectionView *titleCollectionView;

@property (retain, nonatomic) NSArray *titleArray;

@end



@implementation MainTopView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark CollectionView ---------------------------------
- (void)createCollectionView{
    
    _titleArray = @[@"邀请好友",@"商城",@"库存管理",@"商户服务",@"收益管理",@"交易管理",@"团队管理",@"秒结管理"];
    
    float width = (_centerView.frame.size.width-30)/4;
    
    _titleFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_titleFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //    _titleFlowLayout.minimumLineSpacing = 0.0f;
    //    _titleFlowLayout.minimumInteritemSpacing = 0.0f;
    _titleFlowLayout.itemSize = CGSizeMake(width, width);
    
    [_titleCollectionView removeFromSuperview];
    _titleCollectionView = [[UICollectionView alloc] initWithFrame:_centerView.bounds collectionViewLayout:_titleFlowLayout];
    _titleCollectionView.delegate = self;
    _titleCollectionView.dataSource = self;
    _titleCollectionView.allowsMultipleSelection = NO;
    [_titleCollectionView setBackgroundColor:[UIColor clearColor]];
    _titleCollectionView.showsHorizontalScrollIndicator = NO;
    _titleCollectionView.showsVerticalScrollIndicator = NO;
    _titleCollectionView.pagingEnabled = NO;
    
    static NSString *cityHistoryCell = @"MainTopViewCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"MainTopViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell];
    
    [_centerView addSubview:_titleCollectionView];
}
#pragma mark - UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _titleArray.count;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = [ToolsObject getText:[_dataArr objectAtIndex:indexPath.row] withTextSize:CGSizeMake(self.frame.size.width, _myHeight) withTextFont:16];
//
//    return CGSizeMake(size.width+10, _myHeight);
//}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 10, 0);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionID = @"MainTopViewCollectionViewCell";
    
    MainTopViewCollectionViewCell *cell = (MainTopViewCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    
    
    cell.titleNameLabel.text = [_titleArray objectAtIndex:indexPath.row];
    
    cell.logoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[_titleArray objectAtIndex:indexPath.row]]];
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    MainTopViewCollectionViewCell *cell =(MainTopViewCollectionViewCell *)[_titleCollectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",cell.titleNameLabel.text);
  
    [self buttonClicd:cell.titleNameLabel.text];
}


- (void)createView {
    
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [self createCollectionView];
    });
    
    
}

- (void)buttonClicd:(NSString *)string{
    NSLog(@"buttonClicd:%@",string);
    
    if ([string isEqualToString:@"秒结管理"]) {
        SettlementManagerViewController *partnersVC = [[SettlementManagerViewController alloc] initWithNibName:@"SettlementManagerViewController" bundle:nil];
        partnersVC.jumpType = AGENT;
        partnersVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:partnersVC animated:YES];
    }
    
    if ([string isEqualToString:@"商户服务"]) {
        MerchantServicesViewController *terminalVC = [[MerchantServicesViewController alloc] initWithNibName:@"MerchantServicesViewController" bundle:nil];
        terminalVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:terminalVC animated:YES];
    }
    
    if ([string isEqualToString:@"库存管理"]) {
        TerminalMainViewController *terminalVC = [[TerminalMainViewController alloc] initWithNibName:@"TerminalMainViewController" bundle:nil];
        terminalVC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:terminalVC animated:YES];
    }
    
    //@"收益管理",@"交易管理",@"团队管理"
    if ([string isEqualToString:@"收益管理"]) {
        NewChartPieViewController *VC = [[NewChartPieViewController alloc] initWithNibName:@"NewChartPieViewController" bundle:nil];
        VC.chartsType = CHANRTS_SHOUYI;
        VC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:VC animated:YES];
    }
    
    if ([string isEqualToString:@"交易管理"]) {
        NewChartPieViewController *VC = [[NewChartPieViewController alloc] initWithNibName:@"NewChartPieViewController" bundle:nil];
        VC.chartsType = CHANRTS_JIAOYI;
        VC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:VC animated:YES];
    }
    
    if ([string isEqualToString:@"激活管理"]) {
        NewChartPieViewController *VC = [[NewChartPieViewController alloc] initWithNibName:@"NewChartPieViewController" bundle:nil];
        VC.chartsType = CHANRTS_JIHUO;
        VC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:VC animated:YES];
    }
    if ([string isEqualToString:@"团队管理"]) {
        TeamManagementViewController *VC = [[TeamManagementViewController alloc] initWithNibName:@"TeamManagementViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:VC animated:YES];
    }

}


- (IBAction)tiXianBtnClicked:(id)sender {
    
    WithdrawalViewController *VC = [[WithdrawalViewController alloc] initWithNibName:@"WithdrawalViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [_rootVC.navigationController pushViewController:VC animated:YES];
    
}

@end
