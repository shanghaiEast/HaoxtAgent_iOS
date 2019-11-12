
//
//  ProductTypeView.m
//  YanFarmwork
//
//  Created by HG on 2019/11/7.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "ProductTypeView.h"

#import "NormalTableViewCell.h"

@interface ProductTypeView ()<UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) NSMutableArray *resultArray;
@property (nonatomic) float tableViewHeight;

@end

static floatHeight = 50;



@implementation ProductTypeView


- (void) createView {
    _resultArray = [@[@"MPos", @"大pos", @"小pos", @"ppp"] mutableCopy];
    
    [self createTableView];
}

// 展开动画
- (void)beginAnimations:(UITableView *)view
{
    typeof(self)wSelf = self;
    [UIView animateWithDuration: 0.3 delay: 0 options: UIViewAnimationOptionCurveEaseOut animations: ^{

        [view setFrame:CGRectMake(0, (ScreenHeight-kNavBarHAbove7-kTabBarHeight)-wSelf.tableViewHeight, ScreenWidth, wSelf.tableViewHeight)];
        
    } completion: nil];
    
}

- (void)createTableView {
    //table view
    if (_resultArray.count*floatHeight < (ScreenHeight-kNavBarHAbove7-kTabBarHeight)/2) {
        _tableViewHeight = _resultArray.count*floatHeight;
    }else{
        _tableViewHeight = (ScreenHeight-kNavBarHAbove7-kTabBarHeight)/2;
    }
    
    _myTableView = [[UITableView alloc] init];
     [_myTableView setFrame:CGRectMake(0, (ScreenHeight-kNavBarHAbove7-kTabBarHeight), ScreenWidth, 0)];
    _myTableView.backgroundColor = [UIColor whiteColor];
    _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.sectionFooterHeight = CGFLOAT_MIN;
    _myTableView.tableFooterView = [UIView new];
    [self addSubview:_myTableView];
    
    if (@available(iOS 11.0, *)) {
        _myTableView.estimatedRowHeight = 0;
        _myTableView.estimatedSectionFooterHeight = 0;
        _myTableView.estimatedSectionHeaderHeight = 0;
        _myTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
//        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self beginAnimations:_myTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _resultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    return floatHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *nibString = @"NormalTableViewCell";
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nibString];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:nibString owner:self options:nil] lastObject];
    }
    
    cell.titleLabel.text = [_resultArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (_selectLisyRowBlock) {
        _selectLisyRowBlock([NSDictionary new]);
    }
}

@end
