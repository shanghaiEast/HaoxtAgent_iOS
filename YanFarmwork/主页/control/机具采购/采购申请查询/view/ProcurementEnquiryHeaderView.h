//
//  ProcurementEnquiryHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/25.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProcurementEnquiryHeaderView : UIView

@property (weak, nonatomic) IBOutlet UITextField *orderNoLabel;
@property (weak, nonatomic) IBOutlet UITextField *goodsPeopleLabel;

//采购机具类型
@property (weak, nonatomic) IBOutlet UIButton *typeOneBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeTwoBtn;
- (IBAction)chooseTypeClicked:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
- (IBAction)timeBtnClick:(id)sender;


- (IBAction)confirmBtnClicked:(id)sender;






@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
