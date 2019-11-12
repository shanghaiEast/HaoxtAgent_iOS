//
//  MachineSearchHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^ButtonClickedBlock)(NSInteger buttonTag, NSDictionary *inputDict);

NS_ASSUME_NONNULL_BEGIN

@interface MachineSearchHeaderView : UIView

@property (copy, nonatomic) ButtonClickedBlock buttonClickedBlock;



@property (weak, nonatomic) IBOutlet UITextField *textFieldOne;

@property (weak, nonatomic) IBOutlet UITextField *textFieldTwo;

@property (weak, nonatomic) IBOutlet UITextField *textFieldThree;


@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
- (IBAction)buttonClicked:(id)sender;




- (void)createView;


@end

NS_ASSUME_NONNULL_END
