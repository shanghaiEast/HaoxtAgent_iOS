//
//  QueryFilterHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "QueryFilterHeaderView.h"

#import "QueryFilterTimeView.h"
#import "LevelOneView.h"
#import "LevelTwoView.h"

#import "QueryFilterCollectionViewCell.h"


@interface QueryFilterHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (retain, nonatomic) QueryFilterTimeView *timeView;
@property (retain, nonatomic) LevelOneView *levelOneView;
@property (retain, nonatomic) LevelTwoView *levelTwoView;

@property (retain, nonatomic) NSMutableArray *levelTwoArray;


@property (retain, nonatomic) UICollectionViewFlowLayout *titleFlowLayout;
@property (retain, nonatomic) UICollectionView *titleCollectionView;

@end

@implementation QueryFilterHeaderView

//单边边框(底边)
- (void)createBtnBottomBorder:(UIButton *)button {
    CALayer *BtnBorder = [CALayer layer];
    float height=button.frame.size.height;
    float width=button.frame.size.width;
    BtnBorder.frame = CGRectMake(0, height, width, 2);
    BtnBorder.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"].CGColor;
    [button.layer addSublayer:BtnBorder];
}
- (NSString *)dateToday {
    //将日期转换成需要的样式
    
    NSDateFormatter* YMD = [[NSDateFormatter alloc]init];
    if (_screenType == 0) {
        [YMD setDateFormat:@"yyyy-MM-dd"];
    }else{
        [YMD setDateFormat:@"yyyy-MM"];
    }
    NSDate *date = [NSDate date];
    NSString *dateString = [YMD stringFromDate:date];
    
    NSLog(@"时间：%@",dateString);
    
    return dateString;
}

- (void)createView {
    typeof(self) wSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self createBtnBottomBorder:wSelf.startTimeBtn];
        [self createBtnBottomBorder:wSelf.endTimeBtn];
       
    });
    
    _showView.hidden = YES;
    
    UIImageView *serviceImageView = [[UIImageView alloc]init];
    serviceImageView.image = [UIImage imageNamed:@""];
    [serviceImageView setFrame:CGRectMake(0, 0, 15, 15)];
    serviceImageView.contentMode = UIViewContentModeCenter;
    _nameTextField.leftView = serviceImageView;
    _nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    [_startTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    [_endTimeBtn setTitle:[self dateToday] forState:UIControlStateNormal];
    
    [self buttonImageLocation];
}

- (void)buttonImageLocation {
    [ToolsObject buttonImageRight:_level1Btn];
    [ToolsObject buttonImageRight:_level2Btn];
}

- (void)createDateView:(int)tag{
    typeof(self) wSelf = self;
    
    _timeView = [[[NSBundle mainBundle] loadNibNamed:@"QueryFilterTimeView" owner:self options:nil] lastObject];
    _timeView.buttonTag = tag;
    _timeView.screenType = _screenType;
    [_timeView setFrame:_rootVC.view.bounds];
    [_timeView createView];
    [_rootVC.view addSubview:_timeView];
    _timeView.startTimeBolck = ^(NSString * _Nonnull startTimeString) {
        NSLog(@"startTimeBolck: %@",startTimeString);
        if (startTimeString.length == 0) {
            return ;
        }
        [wSelf.startTimeBtn setTitle:startTimeString forState:UIControlStateNormal];
    };
    _timeView.endTimeBolck = ^(NSString * _Nonnull endTimeString) {
        NSLog(@"endTimeBolck: %@",endTimeString);
        if (endTimeString.length == 0) {
            return ;
        }
        [wSelf.endTimeBtn setTitle:endTimeString forState:UIControlStateNormal];
    };
}

-(BOOL)dateCompare
{
    NSString *startDateString = _startTimeBtn.currentTitle;
    NSString *endDateString = _endTimeBtn.currentTitle;

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *startDate=[formatter dateFromString:startDateString];
    NSDate *endDate=[formatter dateFromString:endDateString];
    NSComparisonResult result=[endDate compare:startDate];

    switch (result) {
        case NSOrderedAscending: {
            NSLog(@"FlyElephant:%@--时间小于---%@",startDate,endDate);
            break;

            return NO;
        }
        case NSOrderedSame: {
            NSLog(@"FlyElephant:%@--时间等于---%@",startDate,endDate);

            return YES;

            break;
        }
        case NSOrderedDescending: {
            NSLog(@"FlyElephant:%@--时间大于---%@",startDate,endDate);

            return YES;

            break;
        }
    }

    return NO;
}



- (IBAction)timeBtnClick:(id)sender {
    NSLog(@"时间选择");
    UIButton *button = (id)sender;
    [self createDateView:(int)button.tag];
}

//- (IBAction)confireBtnClicked:(id)sender {
//    NSLog(@"确定");
//    [_nameTextField resignFirstResponder];
//
//    if ([self dateCompare] == NO) {
//        [ToolsObject showMessageTitle:@"起始时间不能小于结束时间" andDelay:1.0 andImage:nil];
//
//        return;
//    }
//
//
//}
- (IBAction)levelBtnClicked:(id)sender {
    UIButton *button = (id)sender;
    
    if (button.tag == 0) {
        _levelOneView = [[[NSBundle mainBundle] loadNibNamed:@"LevelOneView" owner:sender options:nil] lastObject];
        [_levelOneView setFrame:_rootVC.view.bounds];
        [_levelOneView createView];
        _levelOneView.rowClickedBlock = ^(NSDictionary *myDict) {
            NSLog(@"_levelOneView: %@",myDict);
            
            _showView.hidden = NO;
            
            
            [_level1Btn setTitle:[myDict objectForKey:@"test"] forState:UIControlStateNormal];
            
             [self buttonImageLocation];
        };
        [_rootVC.view addSubview:_levelOneView];
    }
    
    if (button.tag == 1) {
        _levelTwoView = [[[NSBundle mainBundle] loadNibNamed:@"LevelTwoView" owner:sender options:nil] lastObject];
        [_levelTwoView setFrame:_rootVC.view.bounds];
        [_levelTwoView createView];
        _levelTwoView.confirmClickedBlock = ^(NSArray * _Nonnull array) {
            NSLog(@"array: %@", array);
            _levelTwoArray = [[NSMutableArray alloc] init];
            _levelTwoArray = [array mutableCopy];
            
            [self createCollectionView];
            
        };
        [_rootVC.view addSubview:_levelTwoView];
    }
}

- (void)createCollectionView{
    _titleFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [_titleFlowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _titleFlowLayout.minimumLineSpacing = 10.0f;
    _titleFlowLayout.minimumInteritemSpacing = 10.0f;
    _titleFlowLayout.itemSize = CGSizeMake(70, 30);
    
    [_titleCollectionView removeFromSuperview];
    _titleCollectionView = [[UICollectionView alloc] initWithFrame:_listView.bounds collectionViewLayout:_titleFlowLayout];
    _titleCollectionView.delegate = self;
    _titleCollectionView.dataSource = self;
    _titleCollectionView.allowsMultipleSelection = NO;
    [_titleCollectionView setBackgroundColor:[UIColor clearColor]];
    _titleCollectionView.showsHorizontalScrollIndicator = NO;
    _titleCollectionView.showsVerticalScrollIndicator = NO;
    _titleCollectionView.pagingEnabled = NO;
    
    static NSString *cityHistoryCell = @"QueryFilterCollectionViewCell";
    [_titleCollectionView registerNib:[UINib nibWithNibName:@"QueryFilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cityHistoryCell];
    
     [_listView addSubview:_titleCollectionView];
}
#pragma mark - UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _levelTwoArray.count;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    CGSize size = [ToolsObject getText:[_dataArr objectAtIndex:indexPath.row] withTextSize:CGSizeMake(self.frame.size.width, _myHeight) withTextFont:16];
//
//    return CGSizeMake(size.width+10, _myHeight);
//}

//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    static NSString *collectionID = @"QueryFilterCollectionViewCell";
    QueryFilterCollectionViewCell *cell = (QueryFilterCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionID forIndexPath:indexPath];
    
    
    cell.titleLabel.text = @"test";
//    cell.titleLabel.userInteractionEnabled = YES;
//    cell.titleLabel.tag = indexPath.row;
//    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delectView:)];
//    [cell.titleLabel addGestureRecognizer:touch];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [_levelTwoArray removeObjectAtIndex:indexPath.row];
    
    
    [_titleCollectionView reloadData];
}

//- (void)delectView:(UITapGestureRecognizer *)tapGestureRecognizer {
//
//    [_levelTwoArray removeObjectAtIndex:tapGestureRecognizer.view.tag];
//
//
//    [_titleCollectionView reloadData];
//
//}


@end
