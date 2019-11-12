//
//  ShopSearchViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopSearchViewController : UIViewController

@property (retain, nonatomic)  UITableView *myTableView;



@property (nonatomic) int jumpType;//0-秒结管理; 1-商户管理

@end

NS_ASSUME_NONNULL_END
