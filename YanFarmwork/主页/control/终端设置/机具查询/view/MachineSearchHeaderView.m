//
//  MachineSearchHeaderView.m
//  YanFarmwork
//
//  Created by HG on 2019/10/22.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MachineSearchHeaderView.h"

@implementation MachineSearchHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)createView {
    _cancelBtn.layer.borderWidth = 1.0f;
    _cancelBtn.layer.borderColor = [IMPORTANT_BACKGROUND CGColor];
    _cancelBtn.layer.masksToBounds = YES;
    
    UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *oneImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    oneImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [oneView addSubview:oneImage];
    _textFieldOne.leftViewMode = UITextFieldViewModeAlways;
    _textFieldOne.leftView = oneView;
    
    UIView *twoView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *twoImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    twoImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [twoView addSubview:twoImage];
    _textFieldTwo.leftViewMode = UITextFieldViewModeAlways;
    _textFieldTwo.leftView = twoView;
    
    UIView *threeView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, 25, 20)];
    UIImageView *threeImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 15, 15)];
    threeImage.image = [UIImage imageNamed:@"searchIcon.png"];
    [threeView addSubview:threeImage];
    _textFieldThree.leftViewMode = UITextFieldViewModeAlways;
    _textFieldThree.leftView = threeView;
    
    
}

- (IBAction)buttonClicked:(id)sender {
    UIButton *button = (id)sender;
    
    
    if (button.tag == 0) {
        if (_buttonClickedBlock) {
            _buttonClickedBlock(button.tag, nil);
        }
        
        [self clearTextFeild];
        
        return;
    }
    
    if (_buttonClickedBlock) {
        NSDictionary *tempDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  _textFieldOne.text,@"text_one",
                                  _textFieldTwo.text,@"text_two",
                                  _textFieldThree.text,@"text_three",
                                  nil];
        _buttonClickedBlock(button.tag, tempDict);
        
        [self clearTextFeild];
    }
    
}

- (void)clearTextFeild {
    _textFieldOne.text = @"";
    _textFieldTwo.text = @"";
    _textFieldThree.text = @"";
    
    [_textFieldOne resignFirstResponder];
    [_textFieldTwo resignFirstResponder];
    [_textFieldThree resignFirstResponder];
}
@end
