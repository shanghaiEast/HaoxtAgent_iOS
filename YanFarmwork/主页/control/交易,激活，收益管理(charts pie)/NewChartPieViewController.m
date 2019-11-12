//
//  NewChartPieViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/11/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "NewChartPieViewController.h"

#import "NewChartPieTableViewCell.h"
#import "NewChartListViewController.h"
#import "NewChartListSYViewController.h"
#import "TrendChartLineViewController.h"

#import <JXCategoryTitleView.h>

@interface NewChartPieViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (retain, nonatomic) UIView *titleView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签


@property (retain, nonatomic) NSString *detailTitleStr;

@property (nonatomic) int pageSize;
@property (retain, nonatomic) NSMutableArray *resultArray;

@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation NewChartPieViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    NSString *titleStr;
    if (_chartsType == CHANRTS_JIHUO) {
        titleStr = @"激活管理";
    }
    if (_chartsType == CHANRTS_SHOUYI) {
        titleStr = @"收益管理";
    }
    if (_chartsType == CHANRTS_JIAOYI) {
        titleStr = @"交易管理";
    }
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:titleStr itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self screenView];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)popViewClick{
   
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_rightBtn removeFromSuperview];
}

- (void)screenView{
    
    [_rightBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(ScreenWidth-50-15, 13, 53, 28)];
    [_rightBtn setTitle:@"明细" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}

- (void)screenClicked {
    NSLog(@"明细");
    
   
    if (_chartsType == CHANRTS_JIHUO) {
        NewChartListViewController *VC = [[NewChartListViewController alloc] initWithNibName:@"NewChartListViewController" bundle:nil];
        VC.listType = NewChart_LIST_JIHUO;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (_chartsType == CHANRTS_SHOUYI) {
        NewChartListSYViewController *VC = [[NewChartListSYViewController alloc] initWithNibName:@"NewChartListSYViewController" bundle:nil];
        VC.listSYType = CHANRTS_SHOUYI;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (_chartsType == CHANRTS_JIAOYI) {
        NewChartListViewController *VC = [[NewChartListViewController alloc] initWithNibName:@"NewChartListViewController" bundle:nil];
        VC.listType = CHANRTS_JIAOYI;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTableView];
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight-kBottomSafeHeight) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self.view addSubview:_myTableView];
    
    if (@available(iOS 11.0, *)) {
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //    _myTableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
    
    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
    
    [self refreshTableView];
}
#pragma mark  -----  Refresh
-(void)refreshTableView
{
    [self refreshHeader];
}
- (void)refreshHeader
{
    _pageSize = 1;
    
    [self mjRefreshStopWhenTen];
}
- (void)upDown
{
    _pageSize ++;
    
    [self mjRefreshStopWhenTen];
}
- (void)tableEndRefresh
{
    [_myTableView.mj_header endRefreshing];
    [_myTableView.mj_footer endRefreshing];
}
- (void)mjRefreshStopWhenTen
{
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf.myTableView.mj_header endRefreshing];
        [wSelf.myTableView.mj_footer endRefreshing];
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
         return 150;
    }
    
    return 468;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = LINECOLOR;

    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        static NSString *nibString = @"NewChartPieTableViewCell";;
        NewChartPieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self jxTitleView];
        });
        
        if (_chartsType == CHANRTS_JIHUO) {
            cell.titleLabel.text = @"激活统计";
        }
        if (_chartsType == CHANRTS_JIAOYI) {
             cell.titleLabel.text = @"交易统计";
        }
        if (_chartsType == CHANRTS_SHOUYI) {
             cell.titleLabel.text = @"收益统计";
        }
        
        [cell.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
        
    }else{
        static NSString *nibString = @"NewChartPieTwoTableViewCell";;
        NewChartPieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (void)rightBtnClicked:(UIButton *)button {
    TrendChartLineViewController *VC = [[TrendChartLineViewController alloc] initWithNibName:@"TrendChartLineViewController" bundle:nil];
    if (_chartsType == CHANRTS_LINE_JIHUO) {
        VC.chartsLineType = CHANRTS_LINE_JIHUO;
    }
    if (_chartsType == CHANRTS_LINE_SHOUYI) {
        VC.chartsLineType = CHANRTS_LINE_SHOUYI;
    }
    if (_chartsType == CHANRTS_LINE_JIAOYI) {
        VC.chartsLineType = CHANRTS_LINE_JIAOYI;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
    
}


- (void)jxTitleView {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NewChartPieTableViewCell *cell =(NewChartPieTableViewCell *)[self.myTableView cellForRowAtIndexPath:indexPath];
    
    
    _titleView = [[UIView alloc] initWithFrame:cell.selectView.bounds];
    [cell.selectView addSubview:_titleView];
    
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height-10, ScreenWidth, 10)];
    //    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    //    [_searchView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:_titleView.bounds];
    slideView.backgroundColor = [UIColor purpleColor];
    [_titleView addSubview:slideView];
    
    if (_chartsType == CHANRTS_JIHUO) {
         _titles = @[@"昨日", @"本月",@"上月",@"累计"];
    }
    if (_chartsType == CHANRTS_JIAOYI) {
         _titles = @[@"昨日", @"本月",@"上月",@"累计"];
    }
    if (_chartsType == CHANRTS_SHOUYI) {
         _titles = @[@"今日", @"本月",@"累计"];
    }
     _detailTitleStr = [NSString stringWithFormat:@"共计%@收益:",[_titles objectAtIndex:_moduleIndex]];
   
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = IMPORTANT_BACKGROUND;
    self.categoryView.titleColor = NORMAL_TEXT_LEVEL_2;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.categoryView.titleFont = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    [slideView addSubview:self.categoryView];
    
}

#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"JXCategoryViewDelegate === %ld",index); self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    if (_moduleIndex == index) {
        return;
    }
    _moduleIndex = index;
    
    _detailTitleStr = [NSString stringWithFormat:@"共计%@收益:",[_titles objectAtIndex:_moduleIndex]];
    
//    [_myTableView reloadData];
//    //一个section刷新
//    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//    [tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    //一个cell刷新
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    [_myTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:0 inSection:0];
    NewChartPieTableViewCell *cell =(NewChartPieTableViewCell *)[self.myTableView cellForRowAtIndexPath:indexPath1];
    cell.detailLabel.text = _detailTitleStr;

}



@end
