//
//  LineView.h
//  YanFarmwork
//
//  Created by HG on 2019/11/1.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LineView : UIView

@property (weak, nonatomic) IBOutlet UIView *chartsView;




- (void)createChart;

@end

NS_ASSUME_NONNULL_END
