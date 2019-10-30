//
//  DeliveryRecordDetailHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/28.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeliveryRecordDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIView *shadowView;





@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
