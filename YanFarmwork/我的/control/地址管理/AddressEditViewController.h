//
//  AddressEditViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/31.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSInteger {
    edit_yes   = 1,
    edit_no    = 0,
    
}editType;

NS_ASSUME_NONNULL_BEGIN

@interface AddressEditViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextField;

@property (weak, nonatomic) IBOutlet UIButton *areaBtn;
- (IBAction)areaBtnClick:(id)sender;





@property (nonatomic) int editType;

@end

NS_ASSUME_NONNULL_END
