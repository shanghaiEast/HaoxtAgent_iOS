//
//  PartnerSalemanDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "PartnerSalemanDetailViewController.h"

#import "PartnerDetaliTableViewCell.h"
#import "StateView.h"


#import <JXCategoryTitleView.h>


@interface PartnerSalemanDetailViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property ( nonatomic) BOOL partnerEditBool;
@property (retain, nonatomic) UIView *searchView;
@property (retain, nonatomic) UIButton *searchBtn;

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic) int moduleIndex;


@property (nonatomic, retain) StateView *stateView;

@property (retain, nonatomic) NSMutableArray *resultArrar;

@property (retain, nonatomic) NSArray *keyArray, *hoderArray, *valueArray;

@end

@implementation PartnerSalemanDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"基本信息" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"姓名",@"身份证号", nil];
    NSArray *sectionTwoKeyArray = [[NSArray alloc] initWithObjects:@"地址",@"手机号",@"邮箱", nil];
     NSArray *sectionThreeKeyArray = [[NSArray alloc] initWithObjects:@"状态",@"开通时间",@"银行卡号",@"开户银行", nil];
    _keyArray = @[sectionOneKeyArray, sectionTwoKeyArray, sectionThreeKeyArray];
    
    NSArray *sectionOneHoderKeyArray = [[NSArray alloc] initWithObjects:@"请输入姓名",@"请输入身份证号", nil];
    NSArray *sectionTwoHoderKeyArray = [[NSArray alloc] initWithObjects:@"请输入地址",@"请输入手机号",@"请输入邮箱", nil];
    NSArray *sectionThreeHoderKeyArray = [[NSArray alloc] initWithObjects:@"请选择状态",@"请输入开通时间",@"请输入银行卡号",@"请输入开户银行", nil];
    _hoderArray = @[sectionOneHoderKeyArray, sectionTwoHoderKeyArray, sectionThreeHoderKeyArray];
    
    
    [self creatEditView];
    [self createTableView];
}
- (void)creatEditView {
    
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
    [_searchBtn setTitle:@"编辑" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_searchView addSubview:_searchBtn];
    
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-120, _searchView.frame.size.height-10)];
    slideView.backgroundColor = [UIColor purpleColor];
    [_searchView addSubview:slideView];
    
    
    [self slideView:slideView];
}

- (void)slideView:(UIView *)slideView {
    
    _titles = @[@"基本信息", @"交易分润"];
    
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
    
    if (_moduleIndex == (int)index) {
        return;
    }
    
    _moduleIndex = (int)index;
    if (_moduleIndex == 0) {
        NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"姓名",@"身份证号", nil];
        NSArray *sectionTwoKeyArray = [[NSArray alloc] initWithObjects:@"地址",@"手机号",@"邮箱", nil];
        NSArray *sectionThreeKeyArray = [[NSArray alloc] initWithObjects:@"状态",@"开通时间",@"银行卡号",@"开户银行", nil];
        _keyArray = @[sectionOneKeyArray, sectionTwoKeyArray, sectionThreeKeyArray];
        
        NSArray *sectionOneHoderKeyArray = [[NSArray alloc] initWithObjects:@"请输入姓名",@"请输入身份证号", nil];
        NSArray *sectionTwoHoderKeyArray = [[NSArray alloc] initWithObjects:@"请输入地址",@"请输入手机号",@"请输入邮箱", nil];
        NSArray *sectionThreeHoderKeyArray = [[NSArray alloc] initWithObjects:@"请选择状态",@"请输入开通时间",@"请输入银行卡号",@"请输入开户银行", nil];
        _hoderArray = @[sectionOneHoderKeyArray, sectionTwoHoderKeyArray, sectionThreeHoderKeyArray];
    }else{
        NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"激活返现提成",@"交易返现提成", nil];
        _keyArray = @[sectionOneKeyArray];
        
        NSArray *sectionOneHoderKeyArray = [[NSArray alloc] initWithObjects:@"低于等于本级日结参数",@"低于等于本级日结参数", nil];
        _hoderArray = @[sectionOneHoderKeyArray];
    }
    
    _partnerEditBool = YES;
     [self searchBtnClick];
    
}

- (void)searchBtnClick{
    NSLog(@"搜索");
    _partnerEditBool = !_partnerEditBool;
    if (_partnerEditBool == YES) {
        [_searchBtn setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [_searchBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
    
    [_myTableView reloadData];
    
    //    PNSearchViewController *pnSerchVC = [[PNSearchViewController alloc] initWithNibName:@"PNSearchViewController" bundle:nil];
    //    pnSerchVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:pnSerchVC animated:YES];
}


- (void)createTableView {
    //table view
    
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, ScreenHeight-kTabBarHeight-55) style:UITableViewStylePlain];
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
    return _keyArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_keyArray objectAtIndex:section] count];
    //    return _resultArrar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"PartnerDetaliTableViewCell";
    
    PartnerDetaliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PartnerDetaliTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.keyLabel.text = [[_keyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    cell.valueTextField.userInteractionEnabled = _partnerEditBool;
    cell.valueTextField.enabled = _partnerEditBool;
    cell.valueTextField.placeholder = [[_hoderArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.valueTextField.text = @"";
    
    if (indexPath.section == 2 && _partnerEditBool == YES && indexPath.row == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(115, 0, ScreenWidth-115, 49)];
        [cell addSubview:view];
        _stateView = [[[NSBundle mainBundle] loadNibNamed:@"StateView" owner:self options:nil] lastObject];
        [_stateView setFrame:view.bounds];
        [view addSubview:_stateView];
        _stateView.stateBlock = ^(NSInteger tag) {
            NSLog(@"stateBlock: %ld",tag);
        };
    }
    
    
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

@end

