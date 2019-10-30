//
//  MainViewController.m
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import "MainViewController.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"


#import "LocationObject.h"


#import "MainTopView.h"
#import "MainOtherView.h"


#pragma mark swift图标桥接文件
#import "YanFarmwork-Bridging-Header.h"

#import "MyWebViewController.h"



//test
#import "TerminalTransferDetailViewController.h"
#import "FilterViewController.h"
#import "QueryFilterViewController.h"
#import "PurchasingApplicationViewController.h"
#import "DeliveryRecordDetailViewController.h"
#import "WithdrawalViewController.h"
#import "WithdrawalDetailViewController.h"
#import "WithdrawalListViewController.h"
#import "ReturnsDetailedViewController.h"
#import "AddressManagementViewController.h"


static float mainTopViewHeight = 189 + (320 - 30)/4*2 + 30;

static float mainOtherViewHeight = 589;


@interface MainViewController () <UITableViewDelegate, UITableViewDataSource>

@property int page;

@property (retain, nonatomic) NSArray *noticesArray;
@property (retain, nonatomic) NSDictionary *receiveDict;


@property (retain, nonatomic) MainTopView *mainTopView;
@property (retain, nonatomic) MainOtherView *mainOtherView;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
////test
    AddressManagementViewController *VC = [[AddressManagementViewController alloc] initWithNibName:@"AddressManagementViewController" bundle:nil];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
 
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    [self createTableView];
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTabBarHeight) style:UITableViewStylePlain];
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
//    _myTableView.ly_emptyView.contentViewY = 540;//
//    _myTableView.ly_emptyView.titleLabTextColor = [UIColor colorWithHexString:@"#AFAFAF"];
//    _myTableView.ly_emptyView.titleLabFont = [UIFont systemFontOfSize:12];
//    [_myTableView ly_showEmptyView];
//    
//        _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
//        _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
//    
//        [self refreshTableView];
}
#pragma mark  -----  Refresh
-(void)refreshTableView
{
    [self refreshHeader];
}
- (void)refreshHeader
{
    _page = 1;
    
    [self mjRefreshStopWhenTen];
}
- (void)upDown
{
    _page ++;
    
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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    //头部
    if (section == 0) {
        return mainTopViewHeight+kTopBarSafeHeight;
    }
    //我的收益
    if (section == 1) {
        return mainOtherViewHeight;
    }
    //交易数据汇总
    if (section == 2) {
        
    }
    //终端数据汇总
    if (section == 3) {
        
    }
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    
    //头部
    if (section == 0) {
        _mainTopView = [[[NSBundle mainBundle] loadNibNamed:@"MainTopView" owner:self options:nil] lastObject];
        [_mainTopView setFrame:CGRectMake(0, 0, ScreenWidth, mainTopViewHeight+kTopBarSafeHeight)];
        _mainTopView.rootVC = self;
        [_mainTopView createView];
        
        
        return _mainTopView;
    }
    //我的收益
    if (section == 1) {
        _mainOtherView = [[[NSBundle mainBundle] loadNibNamed:@"MainOtherView" owner:self options:nil] lastObject];
        [_mainOtherView setFrame:CGRectMake(0, 0, ScreenWidth, mainOtherViewHeight)];
        _mainOtherView.rootVC = self;
        [_mainOtherView createView];
        
        
        return _mainOtherView;
        
    }
    //交易数据汇总
    if (section == 2) {
        
    }
    //终端数据汇总
    if (section == 3) {
        
    }
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nibString = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nibString];
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
}

//UITableView顶部不可拖动
-(void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if(offset.y<=0) {
        
        offset.y=0;
        
    }
    scrollView.contentOffset= offset;
}



@end
