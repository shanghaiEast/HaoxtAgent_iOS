//
//  ShopManagerDetailViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ShopManagerDetailViewController.h"

#import "PartnerDetaliTableViewCell.h"
#import "StateView.h"

#import <JXCategoryTitleView.h>

@interface ShopManagerDetailViewController ()<UITableViewDelegate, UITableViewDataSource, JXCategoryViewDelegate>

@property (retain, nonatomic) UIView *searchView;


@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int moduleIndex;//切换的标签

@property (retain, nonatomic) NSMutableArray *resultArrar;

@property (retain, nonatomic) NSArray *keyArray, *hoderArray, *valueArray;

@property (nonatomic, retain) StateView *stateView;

@property (nonatomic, retain) UISwitch *mySwitch;



@end

@implementation ShopManagerDetailViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"业务员详情" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
     [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)creatSearchView {
    
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 55)];
    [self.view addSubview:_searchView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _searchView.frame.size.height-10, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [_searchView addSubview:lineView];
    
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _searchView.frame.size.height-10)];
    slideView.backgroundColor = [UIColor purpleColor];
    [_searchView addSubview:slideView];
    
    
    [self slideView:slideView];
}

- (void)slideView:(UIView *)slideView {
    if (_jumpType == 1) {
        _titles = @[@"基本信息", @"结算信息", @"费率", @"额度"];
        
        _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
        self.categoryView.titles = self.titles;
        self.categoryView.backgroundColor = [UIColor whiteColor];
        self.categoryView.delegate = self;
        self.categoryView.titleSelectedColor = IMPORTANT_TEXT;
        self.categoryView.titleColor = NORMAL_TEXT_LEVEL_1;
        self.categoryView.titleColorGradientEnabled = YES;
        self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
        self.categoryView.titleLabelZoomEnabled = YES;
        self.categoryView.titleLabelZoomEnabled = YES;
        [slideView addSubview:self.categoryView];
        
        
        return;
    }
    
    _titles = @[@"基本信息", @"秒结管理", @"交易分润"];
    
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
    
    if (_moduleIndex == index) {
        return;
    }
    _moduleIndex = index;
    [self creadeData];
    [_myTableView reloadData];
}

- (void)creadeData {
    if (_jumpType == 1) {
        if (_moduleIndex == 0) {
            NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"商户名称",@"银联编号", nil];
            NSArray *sectionTwoKeyArray = [[NSArray alloc] initWithObjects:@"法人姓名",@"手机号",@"法人身份证号",@"结算卡", nil];
            _keyArray = @[sectionOneKeyArray, sectionTwoKeyArray];
            
        }else if (_moduleIndex == 1) {
            NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"总行号",@"支行号",@"支行名称", nil];
             NSArray *sectionTwoKeyArray = [[NSArray alloc] initWithObjects:@"用户名",@"卡号", nil];
            _keyArray = @[sectionOneKeyArray, sectionTwoKeyArray];
            
        }else if (_moduleIndex == 2) {
            NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"有卡卡费率(%)",@"无卡卡费率(%)", nil];
            _keyArray = @[sectionOneKeyArray];
            
        }else if (_moduleIndex == 3) {
            NSArray *sectionOneKeyArray = [[NSArray alloc] init];
            _keyArray = @[sectionOneKeyArray];
            
        }
        
        return;
    }
    
    if (_moduleIndex == 0) {
        NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"姓名",@"身份证号码", nil];
        NSArray *sectionTwoKeyArray = [[NSArray alloc] initWithObjects:@"地址",@"手机号",@"邮箱", nil];
        NSArray *sectionThreeKeyArray = [[NSArray alloc] initWithObjects:@"状态",@"开通时间",@"银行卡号",@"开户银行", nil];
        _keyArray = @[sectionOneKeyArray, sectionTwoKeyArray, sectionThreeKeyArray];
        
        NSArray *sectionOneHoderKeyArray = [[NSArray alloc] initWithObjects:@"请输入姓名",@"请输入身份证号", nil];
        NSArray *sectionTwoHoderKeyArray = [[NSArray alloc] initWithObjects:@"请输入地址",@"请输入手机号",@"请输入邮箱", nil];
        NSArray *sectionThreeHoderKeyArray = [[NSArray alloc] initWithObjects:@"请选择状态",@"请输入开通时间",@"请输入银行卡号",@"请输入开户银行", nil];
        _hoderArray = @[sectionOneHoderKeyArray, sectionTwoHoderKeyArray, sectionThreeHoderKeyArray];
        
    }else if (_moduleIndex == 1) {
        NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"交易分润秒结",@"激活返现秒结",@"交易分润提现",@"激活提现返现", nil];
        _keyArray = @[sectionOneKeyArray];
        
        NSArray *sectionOneHoderKeyArray = [[NSArray alloc] initWithObjects:@"未开通",@"未开通",@"未开通",@"未开通", nil];
        _hoderArray = @[sectionOneHoderKeyArray];

    }else if (_moduleIndex == 2) {
        NSArray *sectionOneKeyArray = [[NSArray alloc] initWithObjects:@"交易分润提成",@"激活返现提成", nil];
        _keyArray = @[sectionOneKeyArray];
        
        NSArray *sectionOneHoderKeyArray = [[NSArray alloc] initWithObjects:@"低于等于本级日结参数",@"低于等于本级日结参数", nil];
        _hoderArray = @[sectionOneHoderKeyArray];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self creadeData];
    [self creatSearchView];
    [self createTableView];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (_editBool == YES && _moduleIndex == 2) {
        return 150;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (_editBool == YES && _moduleIndex == 2) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
        view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        [button setFrame:CGRectMake(15, 100, ScreenWidth-30, 50)];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitle:@"确  定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.backgroundColor = IMPORTANT_BACKGROUND;
        [button addTarget:self action:@selector(ifEditAddConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        
        return view;
    }
    
    return [UIView new];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *topCell = @"PartnerDetaliTableViewCell";
    
    PartnerDetaliTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"PartnerDetaliTableViewCell" owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.keyLabel.text = [[_keyArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.valueTextField.userInteractionEnabled = _editBool;
    cell.valueTextField.enabled = _editBool;
    cell.valueTextField.placeholder = [[_hoderArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//    cell.valueTextField.text = @"";
    
    
    if (_editBool == YES && _moduleIndex == 0 && indexPath.section == 2 && indexPath.row == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(115, 0, ScreenWidth-115, 49)];
        [cell addSubview:view];
        _stateView = [[[NSBundle mainBundle] loadNibNamed:@"StateView" owner:self options:nil] lastObject];
        [_stateView setFrame:view.bounds];
        [view addSubview:_stateView];
        _stateView.stateBlock = ^(NSInteger tag) {
            NSLog(@"stateBlock: %ld",tag);
        };
    }
    
    if (_editBool == YES && _moduleIndex == 1) {
        cell.valueTextField.userInteractionEnabled = !_editBool;
        cell.valueTextField.enabled = !_editBool;
        
        [self createSwitch:cell withIndexPath:indexPath];
    }
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
}

- (void)createSwitch:(UITableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(115, 0, ScreenWidth-115, 49)];
    view.backgroundColor = [UIColor whiteColor];
    [cell addSubview:view];
   
    _mySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(view.frame.size.width-70, 9, 70, 30)];
    //设置初始状态(默认状态为NO)
//     mySwitch.on = YES;
    //设置按钮处于关闭状态时边框的颜色
    _mySwitch.tintColor = [UIColor colorWithHexString:@"#E2E2E2"];
    //设置开关处于开启时的状态
    _mySwitch.onTintColor = IMPORTANT_BACKGROUND;
    //设置开关的状态钮颜色
    _mySwitch.thumbTintColor = [UIColor whiteColor];
    //整个开关背景色,设置后可以明显看到一个矩形背景
    _mySwitch.backgroundColor = [UIColor colorWithHexString:@"#E2E2E2"];
    _mySwitch.layer.cornerRadius = _mySwitch.frame.size.height/2;
    _mySwitch.layer.masksToBounds = YES;
    //添加点击事件
    _mySwitch.tag = indexPath.row;
    [_mySwitch addTarget:self action:@selector(scitchChanged:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:_mySwitch];
}
- (void)scitchChanged:(UISwitch *)myswitch {
    NSLog(@"myswitch.tag: %ld",myswitch.tag);
    myswitch.on = !myswitch.on;
    
    NSLog(@"myswitch.on: %d",myswitch.on);
}
                                                                

- (void)ifEditAddConfirmBtn {
     NSLog(@"提交修改");
}

@end
