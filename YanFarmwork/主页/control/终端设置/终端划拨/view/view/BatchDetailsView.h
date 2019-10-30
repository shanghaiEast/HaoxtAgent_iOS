//
//  BatchDetailsView.h
//  YanFarmwork
//
//  Created by HG on 2019/10/23.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BatchDetailsView : UIView


@property (retain, nonatomic) UITableView *myTableView;



- (IBAction)closeBtnClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *showView;










@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
