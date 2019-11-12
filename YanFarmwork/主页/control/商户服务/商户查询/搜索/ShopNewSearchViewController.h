//
//  ShopNewSearchViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger {
    SEARCH_SHOP       =   0,//商户搜索
    SEARCH_TERMINAL   =   1,//终端划拨搜索
} searchType;


NS_ASSUME_NONNULL_BEGIN

@interface ShopNewSearchViewController : UIViewController

@property (retain, nonatomic)  UITableView *myTableView;



@property (nonatomic) int searchType;
@property (nonatomic) int jumpType;//0-秒结管理; 1-商户管理

@end

NS_ASSUME_NONNULL_END
