//
//  PersonCenterViewController.m
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import "PersonCenterViewController.h"

#import "PersonCenterTableViewCell.h"
#import "PersonCenterView.h"
#import "SetAppViewController.h"
#import "TCreditCardCerTableViewController.h"
#import "SettlementManagerViewController.h"
#import "CheckRealNameTableViewController.h"
#import "UserCertificationViewController.h"
#import "CommonProblemsViewController.h"


@interface PersonCenterViewController () <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) PersonCenterView *personCenterView;

@property (retain, nonatomic) NSArray *titleArrar, *picturArray;

//@property (retain, nonatomic) NSDictionary *merchantsDict;


@end

@implementation PersonCenterViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createTableView];
 
}

- (void)createTableView {
    //table view
    
    _titleArrar = @[@"实名认证", @"商户APP下载", @"帮助中心", @"设置"];
    _picturArray = @[
                     [UIImage imageNamed:@"实名认证.png"],
                     [UIImage imageNamed:@"xiazai (2).png"],
                     [UIImage imageNamed:@"help.png"],
                     [UIImage imageNamed:@"组 10.png"]];
    
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
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titleArrar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 255+kTopBarSafeHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    _personCenterView = [[[NSBundle mainBundle] loadNibNamed:@"PersonCenterView" owner:self options:nil] lastObject];
    [_personCenterView setFrame:CGRectMake(0, 0, ScreenWidth, 255+kTopBarSafeHeight)];
//    if (_merchantsDict.count != 0) {
//        _personCenterView.detialDict = SHOP_DETAIL;
//    }
    _personCenterView.rootVC = self;
    [_personCenterView createView];

    return _personCenterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"PersonCenterTableViewCell";
    PersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.leftImageView.image = [_picturArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",[_titleArrar objectAtIndex:indexPath.row]];
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    if ([myData TOKEN_ID].length != 0) {
//        if (([[myData USR_STATUS] intValue] == 0 && [MY_USR_REAL_STS intValue] != 2)) {
//
//            [self requestMerchantsMessage];
//
//            return;
//        }
//    }
    
    
    if (indexPath.row == _titleArrar.count-1) {
        //设置
        SetAppViewController *setAppVC = [[SetAppViewController alloc] initWithNibName:@"SetAppViewController" bundle:nil];
        setAppVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setAppVC animated:YES];
    }
    if (indexPath.row == 0) {
        UserCertificationViewController *VC = [[UserCertificationViewController alloc] initWithNibName:@"UserCertificationViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 1) {
        //商户APP下载
//        TCreditCardCerTableViewController *cardVC = [[TCreditCardCerTableViewController alloc] initWithNibName:@"TCreditCardCerTableViewController" bundle:nil];
//        cardVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:cardVC animated:YES];
    }
    if (indexPath.row == 2) {
        //帮助中心
        CommonProblemsViewController *VC = [[CommonProblemsViewController alloc] initWithNibName:@"CommonProblemsViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
//    if (indexPath.row == 3) {
//        //
////        CheckRealNameTableViewController *partnersVC = [[CheckRealNameTableViewController alloc] initWithNibName:@"CheckRealNameTableViewController" bundle:nil];
////        partnersVC.hidesBottomBarWhenPushed = YES;
////        [self.navigationController pushViewController:partnersVC animated:YES];
//    }
    
    
}

//UITableView顶部不可拖动
-(void)scrollViewDidScroll:(UIScrollView*)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if(offset.y<=0) {
        
        offset.y=0;
        
    }
    scrollView.contentOffset= offset;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)requestMerchantsMessage {
    
//    if ([SHOP_DETAIL count] == 0) {//第一次展示
//        [ToolsObject SVProgressHUDShowStatus:nil WithMask:YES];
//    }
//
//    typeof(self) wSelf = self;
//
//    NSDictionary *parametDic = [[NSDictionary alloc] init];
//
//    [YanNetworkOBJ postWithURLString:usr_get parameters:parametDic success:^(id  _Nonnull responseObject) {
//        [ToolsObject SVProgressHUDDismiss];
//        if ([[responseObject objectForKey:@"rspCd"] intValue] == 000000) {
//
//            wSelf.merchantsDict = [responseObject objectForKey:@"rspMap"];
//
//
//            [[NSUserDefaults standardUserDefaults] setObject:wSelf.merchantsDict forKey:@"shopDetail"];
//
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
