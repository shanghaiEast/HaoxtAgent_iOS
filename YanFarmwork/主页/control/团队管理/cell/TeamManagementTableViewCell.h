//
//  TeamManagementTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LineView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamManagementTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *myChartView;


@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;


@property (nonatomic,retain) LineView *lineView;

@end

NS_ASSUME_NONNULL_END
