//
//  TeamManagementHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "TeamManagementHeaderView.h"

@implementation TeamManagementHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)screenClicked:(id)sender {
    if (_screenBtnClickedBlock) {
        _screenBtnClickedBlock(0);
    }
}
@end
