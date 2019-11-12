//
//  MyPolicyViewController.m
//  YanFarmwork
//
//  Created by HG on 2019/11/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MyPolicyViewController.h"

#import "MyPolicyCollectionViewCell.h"
#import "MyPolicyUnselectCollectionViewCell.h"
#import "MyPolicyTableViewCell.h"

#import <JXCategoryTitleView.h>

@interface MyPolicyViewController ()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, JXCategoryViewDelegate>

@property (retain, nonatomic) UICollectionViewFlowLayout *titleFlowLayout;
@property (retain, nonatomic) UICollectionView *titleCollectionView;
@property (nonatomic) int collectionIndex;


@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic) int slideIndex;

@end

@implementation MyPolicyViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    //    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [MyTools setViewController:self withNavigationBarColor:WHITECOLOR andItem:@"我的政策" itemColor:BLACKCOLOR haveBackBtn:YES withBackImage:defaultBarBackImage_black withBackClickTarget:self BackClickAction:@selector(popViewClick)];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    
}
- (void)popViewClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _collectionIndex = 1;
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [self slideView:_selectView];
         [self createCollectionView];
         [self createTableView];
    });
    
}

#pragma mark JXCategoryTitleView ---------------------------------
- (void)slideView:(UIView *)slideView {
    
    _titles = @[@"日结结算低价", @"月结结算低价"];
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:slideView.bounds];
    self.categoryView.titles = self.titles;
    self.categoryView.backgroundColor = [UIColor clearColor];
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = [UIColor whiteColor];
    self.categoryView.titleSelectedFont = [UIFont systemFontOfSize:17 weight:UIFontWeightBold];
    self.categoryView.titleColor = [UIColor whiteColor];
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = YES;
    [slideView addSubview:self.categoryView];
    
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"JXCategoryViewDelegate === %ld",index); self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    
    _slideIndex = (int)index;
    [_myTableView reloadData];
}


#pragma mark tableView ---------------------------------
- (void)createTableView {
    //table view
    
//    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 55, ScreenWidth, ScreenHeight-kTabBarHeight-55-kBottomSafeHeight) style:UITableViewStylePlain];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
//    [self.view addSubview:_myTableView];
    
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
    return 1;
    //    return _resultArrar.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return 400;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *topCell = @"MyPolicyTableViewCell";

    MyPolicyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:topCell];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:topCell owner:self options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell createCell:[NSDictionary new]];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
   
}


#pragma mark CollectionView ---------------------------------
- (void)createCollectionView{
    
    float width = (_HListView.frame.size.width)/3;
    
    _titleFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_titleFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _titleFlowLayout.minimumLineSpacing = 0.0f;
    _titleFlowLayout.minimumInteritemSpacing = 0.0f;
    _titleFlowLayout.itemSize = CGSizeMake(width, 50);
    
    [_titleCollectionView removeFromSuperview];
    _titleCollectionView = [[UICollectionView alloc] initWithFrame:_HListView.bounds collectionViewLayout:_titleFlowLayout];
    _titleCollectionView.delegate = self;
    _titleCollectionView.dataSource = self;
    _titleCollectionView.allowsMultipleSelection = NO;
    [_titleCollectionView setBackgroundColor:[UIColor clearColor]];
    _titleCollectionView.showsHorizontalScrollIndicator = NO;
    _titleCollectionView.showsVerticalScrollIndicator = NO;
    _titleCollectionView.pagingEnabled = NO;
    
    static NSString *cityHistoryCell = @"MyPolicyCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"MyPolicyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell];
    
    static NSString *cityHistoryCell1 = @"MyPolicyUnselectCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"MyPolicyUnselectCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell1];
    
    [_HListView addSubview:_titleCollectionView];
}
#pragma mark - UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = [ToolsObject getText:[_dataArr objectAtIndex:indexPath.row] withTextSize:CGSizeMake(self.frame.size.width, _myHeight) withTextFont:16];
//
//    return CGSizeMake(size.width+10, _myHeight);
//}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 0, 5, 0);
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row < _collectionIndex) {
        static NSString *collectionID = @"MyPolicyUnselectCollectionViewCell";
        
        MyPolicyUnselectCollectionViewCell *cell = (MyPolicyUnselectCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
        
        
        cell.layer.cornerRadius = 3.0f;
        cell.layer.masksToBounds = YES;
        
        
        return cell;
        
    }else {
        static NSString *collectionID = @"MyPolicyCollectionViewCell";
        
        MyPolicyCollectionViewCell *cell = (MyPolicyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
        
        
        cell.layer.cornerRadius = 3.0f;
        cell.layer.masksToBounds = YES;
        
        
        
        
        return cell;
    }
    
    
    return [UICollectionViewCell new];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
