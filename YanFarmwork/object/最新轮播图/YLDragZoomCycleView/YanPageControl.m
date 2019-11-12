//
//  YanPageControl.m
//  HuaTongAPP
//
//  Created by huatong on 2018/9/26.
//  Copyright © 2018年 yan. All rights reserved.
//

#import "YanPageControl.h"

#define dotW 8 // 圆点宽
#define dotH 2  // 圆点高
#define magrin 7    // 圆点间距

@implementation YanPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews{
    [super layoutSubviews];    //计算圆点间距
    CGFloat marginX = dotW + magrin;        //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;        //设置新frame
    self.frame = CGRectMake(ScreenWidth/2-(newW + dotW)/2, self.frame.origin.y, newW + dotW, self.frame.size.height);        //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
            
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
            
        }
        
    }
    
}
    



@end
