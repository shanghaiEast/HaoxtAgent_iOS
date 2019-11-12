//
//  ConfirmSignViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/3.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CER_SUCCESS    = 0,
    CER_FAilE    = 1,
    SUCCESS    = 2,
    
    
} payType;




@interface ConfirmSignViewController : UIViewController

@property(nonatomic) int payType;//0==实名认证成功成功，======= 1==失败，2==未知, 5==实名认证结果, 6==信用卡绑定成功， 7==机具绑定成功

@property (weak, nonatomic) IBOutlet UIImageView *stateImageView;

@property (weak, nonatomic) IBOutlet UILabel *title_main;

@property (weak, nonatomic) IBOutlet UILabel *title_other;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
- (IBAction)cancelBtnClick:(id)sender;




@property (nonatomic) int processTag;//支付流程


@end

NS_ASSUME_NONNULL_END
