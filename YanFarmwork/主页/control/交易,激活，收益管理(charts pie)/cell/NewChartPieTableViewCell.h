//
//  NewChartPieTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/11/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewChartPieTableViewCell : UITableViewCell

//block one
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)rightBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *selectView;

//block two
@property (weak, nonatomic) IBOutlet UIView *myChartView;

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;



@end

NS_ASSUME_NONNULL_END
