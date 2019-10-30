//
//  PartnersViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PARTNER    = 0,
    SALESMAN      = 1,
} payType;


NS_ASSUME_NONNULL_BEGIN

@interface PartnersViewController : UIViewController

@property (retain, nonatomic)  UITableView *myTableView;


@property (nonatomic) int roleInt;//角色

@end

NS_ASSUME_NONNULL_END
