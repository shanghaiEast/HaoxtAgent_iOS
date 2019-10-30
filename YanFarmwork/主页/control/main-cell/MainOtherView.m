//
//  MainOtherView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/18.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MainOtherView.h"

#import "ResultQueryViewController.h"

@implementation MainOtherView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)createView {
    
    
}

- (IBAction)detailClicked:(id)sender {
    UIButton *button = (id)sender;
    if (button.tag == 0) {
        
    }
    
    if (button.tag == 1) {
        ResultQueryViewController *VC = [[ResultQueryViewController alloc] initWithNibName:@"ResultQueryViewController" bundle:nil];
        VC.hidesBottomBarWhenPushed = YES;
        [_rootVC.navigationController pushViewController:VC animated:YES];
    }
    
    if (button.tag == 2) {
        
    }
}
@end
