//
//  NewChartListScreenViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/11/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    screen_LIST_JIHUO     = 0,
    screen_LIST_JIAOYI    = 1,
    screen_LIST_SHOUYI    = 2,
    screen_LIST_TUANDUI    = 3,
    
} screenType;
NS_ASSUME_NONNULL_BEGIN

@interface NewChartListScreenViewController : UIViewController


@property (retain, nonatomic)  UITableView *myTableView;

@property (nonatomic) int screenType;//

@end

NS_ASSUME_NONNULL_END
