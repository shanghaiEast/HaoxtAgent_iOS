//
//  NewChartListViewController.h
//  YanFarmwork
//
//  Created by 国时 on 2019/4/12.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    NewChart_LIST_JIHUO     = 0,
    NewChart_LIST_JIAOYI    = 1,
    NewChart_LIST_SHOUYI    = 2,

} listType;

NS_ASSUME_NONNULL_BEGIN

@interface NewChartListViewController : UIViewController





@property (retain, nonatomic)  UITableView *myTableView;




@property (nonatomic) int listType;//

@end

NS_ASSUME_NONNULL_END
