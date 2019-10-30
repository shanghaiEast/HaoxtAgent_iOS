//
//  PersonCenterView.h
//  YanFarmwork
//
//  Created by HG on 2019/9/4.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonCenterView : UIView

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameAndPhoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *toListBtn;
- (IBAction)setBtnClick:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *fenRunLabel;

@property (weak, nonatomic) IBOutlet UILabel *jiHuoLabel;

@property (weak, nonatomic) IBOutlet UILabel *mentionLabel;



@property (weak, nonatomic) IBOutlet UIImageView *bottonImageView;



@property (retain, nonatomic) UIViewController *rootVC;
@property (retain, nonatomic) NSDictionary *detialDict;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
