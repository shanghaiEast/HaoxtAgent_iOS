//
//  WithdrawalViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/29.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *bankView;


@property (weak, nonatomic) IBOutlet UITextField *inputMonetTextField;

@property (weak, nonatomic) IBOutlet UILabel *allMonetLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherMoneyLabel;

- (IBAction)getAllMoneyBtnClick:(id)sender;
- (IBAction)confirmBtnClicked:(id)sender;


@end

NS_ASSUME_NONNULL_END
