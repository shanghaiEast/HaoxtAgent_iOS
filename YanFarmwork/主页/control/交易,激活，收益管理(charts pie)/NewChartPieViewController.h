//
//  NewChartPieViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/11/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CHANRTS_JIHUO     = 0,
    CHANRTS_JIAOYI    = 1,
    CHANRTS_SHOUYI    = 2,
    
    
} chartsType;

NS_ASSUME_NONNULL_BEGIN

@interface NewChartPieViewController : UIViewController


@property (retain, nonatomic)  UITableView *myTableView;

@property (nonatomic) int chartsType;//

@end

NS_ASSUME_NONNULL_END
