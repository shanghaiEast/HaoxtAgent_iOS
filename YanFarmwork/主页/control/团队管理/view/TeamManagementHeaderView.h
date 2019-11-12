//
//  TeamManagementHeaderView.h
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ScreenBtnClickedBlock)(NSInteger integer);

NS_ASSUME_NONNULL_BEGIN

@interface TeamManagementHeaderView : UIView

- (IBAction)screenClicked:(id)sender;



@property (copy, nonatomic) ScreenBtnClickedBlock screenBtnClickedBlock;

@end

NS_ASSUME_NONNULL_END
