//
//  PurchasingApplicationHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/25.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PurchasingApplicationHeaderView : UIView

@property (weak, nonatomic) IBOutlet UITextField *allMchNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *payPeopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMomeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *allMomeyNewLabel;

//采购机具类型
@property (weak, nonatomic) IBOutlet UIButton *typeOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeTwoBtn;
- (IBAction)chooseTypeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *listView;

- (IBAction)confirmBtnClicked:(id)sender;






@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
