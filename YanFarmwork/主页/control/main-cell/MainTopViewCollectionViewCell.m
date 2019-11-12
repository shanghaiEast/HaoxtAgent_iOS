//
//  MainTopViewCollectionViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/11/6.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "MainTopViewCollectionViewCell.h"


@implementation MainTopViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _titleNameLabel.font = [UIFont systemFontOfSize:AdaptW(14)];
}

@end
