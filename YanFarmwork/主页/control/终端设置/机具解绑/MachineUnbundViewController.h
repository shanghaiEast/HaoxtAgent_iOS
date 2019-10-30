//
//  MachineUnbundViewController.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MachineUnbundViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *machineNOTextField;

- (IBAction)scanBtnClicked:(id)sender;

- (IBAction)confirmBtnClicked:(id)sender;



@end

NS_ASSUME_NONNULL_END
