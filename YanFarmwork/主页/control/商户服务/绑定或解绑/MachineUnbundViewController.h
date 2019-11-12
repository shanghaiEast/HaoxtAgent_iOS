//
//  MachineUnbundViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum :NSInteger {
    IS_BUND       =  0,
    IS_UN_BUND    =  1,
}bundType;

NS_ASSUME_NONNULL_BEGIN

@interface MachineUnbundViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *noLabel;

@property (weak, nonatomic) IBOutlet UITextField *machineMessageTextField;
@property (weak, nonatomic) IBOutlet UITextField *machineIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *machineNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *machineNOTextField;



- (IBAction)nextBtnClicked:(id)sender;
- (IBAction)scanBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)confirmBtnClicked:(id)sender;





@property (nonatomic) int bundType;

@end

NS_ASSUME_NONNULL_END
