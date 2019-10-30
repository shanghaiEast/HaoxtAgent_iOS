//
//  LevelTwoTableViewCell.m
//  YanFarmwork
//
//  Created by HG on 2019/10/24.
//  Copyright © 2019 Yanhuaqiang. All rights reserved.
//

#import "LevelTwoTableViewCell.h"

@implementation LevelTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _dianImageView.layer.cornerRadius = 7.5;
    _dianImageView.layer.borderWidth = 1;
    _dianImageView.layer.borderColor = [LINECOLOR CGColor];
    _dianImageView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
