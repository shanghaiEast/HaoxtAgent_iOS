//
//  TrendChartLineTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TrendChartLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *myChartView;
@property (weak, nonatomic) IBOutlet UIView *selectView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)buttonSelected:(id)sender;



@property (nonatomic,retain) LineView *lineView;

@end

NS_ASSUME_NONNULL_END
