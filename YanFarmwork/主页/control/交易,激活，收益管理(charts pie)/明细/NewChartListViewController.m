//
//  NewChartListViewController.m
//  YanFarmwork
//
//  Created by 国时 on 2019/4/12.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "NewChartListViewController.h"

#import "TradingTableViewCell.h"

#import "TradDetailTableViewController.h"
#import "NewChartListScreenViewController.h"

#import "FilterView.h"
#import "TimeView.h"



@interface NewChartListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int page;
@property (retain, nonatomic) UIButton *leftBtn;


@property (retain, nonatomic) UIButton *rightBtn;

@end

@implementation NewChartListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    NSString *titleStr;
    if (_listType == NewChart_LIST_JIHUO) {
        titleStr = @"激活明细";
    }
    if (_listType == NewChart_LIST_SHOUYI) {
        titleStr = @"收益明细";
    }
    if (_listType == NewChart_LIST_JIAOYI) {
        titleStr = @"交易明细";
    }
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
    if (_listType == NewChart_LIST_JIHUO) {
        VC.screenType = NewChart_LIST_JIHUO;
    }
    if (_listType == NewChart_LIST_SHOUYI) {
        VC.screenType = NewChart_LIST_SHOUYI;
    }
    if (_listType == NewChart_LIST_JIAOYI) {
        VC.screenType = NewChart_LIST_JIAOYI;
    }
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    [self createTableView];
    
   
}

- (void)createTableView {
    //table view
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kNavBarHAbove7-kBottomSafeHeight) style:UITableViewStylePlain];
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
    if (_listType == NewChart_LIST_JIHUO) {
        return 100;
    }
    if (_listType == NewChart_LIST_SHOUYI) {
        return 100;
    }
    if (_listType == NewChart_LIST_JIAOYI) {
        return 72;
    }
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headView.backgroundColor = LINECOLOR;
    
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_listType == NewChart_LIST_JIHUO) {
        
    }
    if (_listType == NewChart_LIST_SHOUYI) {
        
    }
    if (_listType == NewChart_LIST_JIAOYI) {
        static NSString *topCell = @"TradingTableViewCell";
        TradingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    return [UITableViewCell new];
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
