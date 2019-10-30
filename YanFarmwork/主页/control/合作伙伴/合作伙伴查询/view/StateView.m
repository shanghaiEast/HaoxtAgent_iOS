//
//  StateView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/21.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "StateView.h"

@implementation StateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)yesOrNoBtnClick:(id)sender {
    UIButton *button = (id)sender;
    if (button == _yesBtn) {
        _yesBtn.selected = YES;
        _noBtn.selected = NO;
        if (_stateBlock) {
            _stateBlock(1);
        }
    }else{
        _yesBtn.selected = NO;
        _noBtn.selected = YES;
        if (_stateBlock) {
            _stateBlock(0);
        }
    }

}

@end
