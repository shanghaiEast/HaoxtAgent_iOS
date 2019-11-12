//
//  BSFitdpiUtil.m
//  YanFarmwork
//
//  Created by HG on 2019/11/7.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "BSFitdpiUtil.h"

@implementation BSFitdpiUtil

+ (CGFloat)adaptWidthWithValue:(CGFloat)floatV;
{
    return floatV*[[UIScreen mainScreen] bounds].size.width/kRefereWidth;
}


@end
