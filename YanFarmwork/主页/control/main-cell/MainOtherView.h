//
//  MainOtherView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MainOtherView : UIView


//我的收益
@property (weak, nonatomic) IBOutlet UILabel *topLeftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLeftLabel;

//交易数据汇总
@property (weak, nonatomic) IBOutlet UILabel *middleAllLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleDayLabel;

//终端数据汇总
@property (weak, nonatomic) IBOutlet UILabel *bottomAllLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomMonthLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomDayLabel;


- (IBAction)detailClicked:(id)sender;



@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
