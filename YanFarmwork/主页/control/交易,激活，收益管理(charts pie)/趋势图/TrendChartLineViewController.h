//
//  TrendChartLineViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/11/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CHANRTS_LINE_JIHUO     = 0,
    CHANRTS_LINE_JIAOYI    = 1,
    CHANRTS_LINE_SHOUYI    = 2,
    
    
} chartsLineType;

NS_ASSUME_NONNULL_BEGIN

@interface TrendChartLineViewController : UIViewController


@property (retain, nonatomic)  UITableView *myTableView;

@property (nonatomic) int chartsLineType;//

@end

NS_ASSUME_NONNULL_END
