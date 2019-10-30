//
//  TerminalMainTableViewCell.h
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TerminalMainTableViewCell : UITableViewCell

//第一行
- (IBAction)machinesSearchBtn:(id)sender;

- (IBAction)machinesUnBing:(id)sender;


//第二行
- (IBAction)terminalBtn:(id)sender;


//第三行
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
- (IBAction)detailBtn:(id)sender;




@property (retain, nonatomic) UIViewController *rootVC;
- (void)createView;

@end

NS_ASSUME_NONNULL_END
