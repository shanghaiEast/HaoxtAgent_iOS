//
//  NewChartListSYViewController.h
//  YanFarmwork
//
//  Created by 国时 on 2019/4/12.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    NewChart_LIST_SY_JIHUO     = 0,
    NewChart_LIST_SY_JIAOYI    = 1,
    NewChart_LIST_SY_SHOUYI    = 2,

} listSYType;

NS_ASSUME_NONNULL_BEGIN

@interface NewChartListSYViewController : UIViewController





@property (retain, nonatomic)  UITableView *myTableView;




@property (nonatomic) int listSYType;//

@end

NS_ASSUME_NONNULL_END
