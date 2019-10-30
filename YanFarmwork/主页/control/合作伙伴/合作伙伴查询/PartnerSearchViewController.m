//
//  PartnerSearchViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PartnerSearchViewController.h"

#import "PartnerSearchTableViewCell.h"
#import "PNSearchViewController.h"
#import "PartnerDetailViewController.h"
#import "PartnerScreenView.h"
#import "PartnerSalemanDetailViewController.h"


#import <JXCategoryTitleView.h>


@interface PartnerSearchViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property ( nonatomic) BOOL partnerSearchBool;

@property (retain, nonatomic) UIView *searchView;
@property (retain, nonatomic) UIButton *searchBtn;

@property (retain, nonatomic) PartnerScreenView *partnerScreenView;

@property (retain, nonatomic) NSMutableArray *resultArrar;


@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;


@end

@implementation PartnerSearchViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"合作伙伴查询" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _partnerSearchBool = NO;
    
    [self creatSearchView];
    [self createTableView];
}

- (void)creatSearchView {
    
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    [self.view addSubview:_searchView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height-10, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [_searchView addSubview:lineView];
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchBtn setFrame:CGRectMake(ScreenWidth-55-15, 10, 55, 24)];
    _searchBtn.layer.cornerRadius = 12;
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.backgroundColor = IMPORTANT_BACKGROUND;
    [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:_searchBtn];
    
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, _searchView.frame.size.height-10)];
    slideView.backgroundColor = [UIColor purpleColor];
    [_searchView addSubview:slideView];
    
    
    [self slideView:slideView];
}

- (void)slideView:(UIView *)slideView {
    
    _titles = @[@"已完善", @"待完善"];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor whiteColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = IMPORTANT_TEXT;
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.categoryView.titleColor = NORMAL_TEXT_LEVEL_1;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    [slideView addSubview:self.categoryView];
    
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"JXCategoryViewDelegate === %ld",index); self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
}

- (void)searchBtnClick{
    NSLog(@"搜索");
    _partnerSearchBool = !_partnerSearchBool;
    if (_partnerSearchBool == YES) {
        _searchBtn.hidden = YES;
    }else{
        _searchBtn.hidden = NO;
    }
    
    [_myTableView reloadData];
    
}

- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, ScreenHeight-kTabBarHeight-55-kBottomSafeHeight) style:UITableViewStylePlain];
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
//    return _resultArrar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (_partnerSearchBool == YES) {
        return 240;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row/2 == 1) {
        return 174;
    }
    return 153;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (_partnerSearchBool == YES) {
        _partnerScreenView = [[[NSBundle mainBundle] loadNibNamed:@"PartnerScreenView" owner:self options:nil] lastObject];
        [_partnerScreenView setFrame:CGRectMake(0, 0, ScreenWidth, 240)];
        [_partnerScreenView createView];
        _partnerScreenView.btnSelectedBlock = ^(NSInteger tag, NSDictionary *dict) {
            NSLog(@"PartnerScreenView == %@",dict);
            _partnerSearchBool = !_partnerSearchBool;
            _searchBtn.hidden = !_searchBtn.hidden;
            
            [_myTableView reloadData];
            
        };
        
        return _partnerScreenView;
    }
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell;
    if (indexPath.row/2 == 1) {
        topCell = @"PartnerSearchTableViewCell";
    }else{
        topCell = @"PartnerSearchOneTableViewCell";
    }
    PartnerSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell createCell:nil];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_roleInt == 0) {
        PartnerDetailViewController *pnSerchVC = [[PartnerDetailViewController alloc] initWithNibName:@"PartnerDetailViewController" bundle:nil];
        pnSerchVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pnSerchVC animated:YES];
    }else{
        PartnerSalemanDetailViewController *pnSerchVC = [[PartnerSalemanDetailViewController alloc] initWithNibName:@"PartnerSalemanDetailViewController" bundle:nil];
        pnSerchVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pnSerchVC animated:YES];
    }
    
}


@end
