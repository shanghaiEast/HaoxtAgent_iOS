//
//  NewChartListSYViewController.m
//  YanFarmwork
//
//  Created by 国时 on 2019/4/12.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "NewChartListSYViewController.h"

#import "TradingTableViewCell.h"
#import "NewChartListSYTableViewCell.h"

#import "TradDetailTableViewController.h"
#import "NewChartListScreenViewController.h"

#import "FilterView.h"
#import "TimeView.h"

#import <JXCategoryTitleView.h>

@interface NewChartListSYViewController () <UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (retain, nonatomic) UIView *titleView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签


@property (nonatomic) int page;
@property (retain, nonatomic) UIButton *leftBtn;


@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation NewChartListSYViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    NSString *titleStr = @"收益明细";
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:titleStr itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    
    [self screenView];
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [_rightBtn removeFromSuperview];
}
- (void)screenView{
    
    [_rightBtn removeFromSuperview];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setFrame:CGRectMake(ScreenWidth-50-15, 13, 53, 28)];
    [_rightBtn setTitle:@"筛选" forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn setTitleColor:IMPORTANT_TEXT forState:UIControlStateNormal];
    _rightBtn.tag = 1;
    [_rightBtn addTarget:self action:@selector(screenClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_rightBtn];
}
- (void)screenClicked {
    NSLog(@"筛选");
    
    NewChartListScreenViewController *VC = [[NewChartListScreenViewController alloc] initWithNibName:@"NewChartListScreenViewController" bundle:nil];
    VC.screenType = NewChart_LIST_SY_SHOUYI;
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createJXView];
    [self createTableView];
    
    
}

- (void)createJXView {
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(15, 0, 150, 45)];
    [self.view addSubview:_titleView];
    
    //    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height-10, ScreenWidth, 10)];
    //    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    //    [_searchView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:_titleView.bounds];
    slideView.backgroundColor = [UIColor purpleColor];
    [_titleView addSubview:slideView];
    
      _titles = @[@"收入", @"支出"];

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
    _moduleIndex = (int)index;
    
    [_myTableView reloadData];
    
}

- (void)createTableView {
    //table view
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight-kNavBarHAbove7-kBottomSafeHeight-45) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor clearColor];
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
    
    _myTableView.ly_emptyView = [LYEmptyView emptyViewWithImage:[UIImage imageNamed:@"emptycell.png"] titleStr:@"暂无消息…" detailStr:@""];
    
    //    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
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
    _page = 1;
    
    [self requestForTradList];
    
    [self mjRefreshStopWhenTen];
}
- (void)upDown
{
    _page ++;
    
    [self requestForTradList];
    
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
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headView.backgroundColor = LINECOLOR;
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"NewChartListSYTableViewCell";
    NewChartListSYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //    TradDetailTableViewController *detailVC = [[TradDetailTableViewController alloc] initWithNibName:@"TradDetailTableViewController" bundle:nil];
    //    detailVC.hidesBottomBarWhenPushed = YES;
    //    detailVC.detailDict = [NSDictionary new];
    //    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)requestForTradList {
    
    //    [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
    //    typeof(self) wSelf = self;
    //
    //    NSDictionary *parametDic = [[NSDictionary alloc] initWithObjectsAndKeys:
    //                                 [NSString stringWithFormat:@"%d",_page],@"PAGE_NUM",
    //                                 @"10",@"PAGE_SIZE",
    //                                 _startDateString,@"ORD_TIM_START",
    //                                 _endDataString,@"ORD_TIM_END",
    //                                 [NSString stringWithFormat:@"%.2f",[[_typeDict objectForKey:@"minPrice"] floatValue]],@"ORD_AMT_START",
    //                                 [NSString stringWithFormat:@"%.2f",[[_typeDict objectForKey:@"maxPrice"] floatValue]],@"ORD_AMT_END",
    //                                [NSString stringWithFormat:@"%d",[[_typeDict objectForKey:@"state"] intValue]],@"TXN_STS",
    //                                [NSString stringWithFormat:@"%d",[[_typeDict objectForKey:@"type"] intValue]],@"TXN_CD",
    //                                 nil];
    //
    //    [YanNetworkOBJ postWithURLString:ord_list parameters:parametDic success:^(id  _Nonnull responseObject) {
    //        [ToolsObject SVProgressHUDDismiss];
    //        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
    //
    //            if (wSelf.page == 1) {
    //                wSelf.tradListArray = [[NSMutableArray alloc] init];
    //                wSelf.tradListArray = [responseObject objectForKey:@"rspData"];
    //
    //            }else{
    //                if ([[responseObject objectForKey:@"rspData"] count] == 0) {
    //                    [ToolsObject showMessageTitle:@"没有更多了哦" andDelay:1.0f andImage:nil];
    //
    //                    [self tableEndRefresh];
    //
    //                    return ;
    //                }
    //
    //                [wSelf.tradListArray addObjectsFromArray:[responseObject objectForKey:@"rspData"]];
    //            }
    //
    //            [wSelf.myTableView reloadData];
    //
    //        }else{
    //            //filed
    //            [ToolsObject showMessageTitle:[responseObject objectForKey:@"rspInf"] andDelay:1.0f andImage:nil];
    //        }
    //
    //    } failure:^(NSError * _Nonnull error) {
    //        NSLog(@"test filed ");
    //        [ToolsObject SVProgressHUDDismiss];
    //    }];
}

@end

