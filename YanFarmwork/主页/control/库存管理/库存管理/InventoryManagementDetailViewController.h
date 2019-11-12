//
//  InventoryManagementDetailViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger {
    UN_BUND      =  0,
    BUND         =  1,
} bundType;

NS_ASSUME_NONNULL_BEGIN

@interface InventoryManagementDetailViewController : UIViewController

@property (retain, nonatomic)  UITableView *myTableView;




@property (nonatomic) int bundType;

@end

NS_ASSUME_NONNULL_END
