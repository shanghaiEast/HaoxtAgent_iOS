//
//  AddCreditCardViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/9/5.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddCreditCardViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *headBankBtn;
- (IBAction)headBankBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *bankNameBtn;
- (IBAction)bankNameBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
- (IBAction)addressBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *bankBranchBtn;
- (IBAction)bankBranchClick:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
- (IBAction)commitBtnClick:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;





@end

NS_ASSUME_NONNULL_END
