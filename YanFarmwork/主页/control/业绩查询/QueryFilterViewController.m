//
//  QueryFilterViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "QueryFilterViewController.h"


#import "QueryFilterHeaderView.h"

@interface QueryFilterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) QueryFilterHeaderView *headerView;


@property (nonatomic) int pageSize;


@end

@implementation QueryFilterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"筛选" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
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
    
    //    _myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    //    _myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDown)];
    //
    //    [self refreshTableView];
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
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return _myTableView.frame.size.height-60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 56;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"QueryFilterHeaderView" owner:self options:nil] lastObject];
    [_headerView setFrame:CGRectMake(0, 0, ScreenWidth, _myTableView.frame.size.height-60)];
    _headerView.screenType = 1;
    _headerView.rootVC = self;
    [_headerView createView];
    
    
    
    
    return _headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 56)];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(15, 0, ScreenWidth-30, 56)];
    button.layer.cornerRadius = 4;
    button.layer.masksToBounds = YES;
    button.backgroundColor = IMPORTANT_BACKGROUND;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [button addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nibString = @"UITableViewCell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)confirmBtnClick {
    NSLog(@"确定");
}

@end
