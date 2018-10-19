//
//  PayCollectionViewCell.m
//  cellAnimation
//
//  Created by youxin on 2018/10/19.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "PayCollectionViewCell.h"

@implementation PayCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    self.imgV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgV];
    
    self.title = [[UILabel alloc] init];
    self.title.font = [UIFont systemFontOfSize:13];
    self.title.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.title];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imgV.frame = CGRectMake(0, 0, 20, 20);
    self.imgV.center = self.contentView.center;
    
    self.title.frame = CGRectMake(self.contentView.left, self.imgV.bottom, self.contentView.width, 28);
}

@end
