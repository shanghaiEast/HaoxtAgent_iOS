//
//  StateView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^StateBlock)(NSInteger tag);

NS_ASSUME_NONNULL_BEGIN

@interface StateView : UIView


@property (copy, nonatomic) StateBlock stateBlock;


@property (weak, nonatomic) IBOutlet UIButton *yesBtn;
@property (weak, nonatomic) IBOutlet UIButton *noBtn;

- (IBAction)yesOrNoBtnClick:(id)sender;

@end

NS_ASSUME_NONNULL_END
