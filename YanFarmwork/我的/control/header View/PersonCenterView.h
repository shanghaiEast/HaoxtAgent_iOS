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
@property (weak, nonatomic) IBOutlet UIView *renZhenView;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;


- (IBAction)personDetailBtnClicked:(id)sender;

- (IBAction)listBtnClicked:(id)sender;




@property (retain, nonatomic) UIViewController *rootVC;
@property (retain, nonatomic) NSDictionary *detialDict;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
