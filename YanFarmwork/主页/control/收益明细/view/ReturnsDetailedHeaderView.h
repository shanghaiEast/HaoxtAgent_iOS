//
//  ReturnsDetailedHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/30.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReturnsDetailedHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *whiteView;

@property (weak, nonatomic) IBOutlet UILabel *allMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *inMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *outMoneyLabel;

@property (weak, nonatomic) IBOutlet UIButton *moneyButton;
- (IBAction)moneyBtnClied:(id)sender;



@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
