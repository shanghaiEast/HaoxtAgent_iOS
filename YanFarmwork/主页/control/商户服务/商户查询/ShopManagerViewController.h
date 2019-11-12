//
//  ShopManagerViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum :NSInteger {
    AGENT   =   0,//秒结管理
    SALEMAN =   1,//商户管理
} jumpType;

NS_ASSUME_NONNULL_BEGIN

@interface ShopManagerViewController : UIViewController


@property (retain, nonatomic)  UITableView *myTableView;





@property (nonatomic) int jumpType;


@end

NS_ASSUME_NONNULL_END
