//
//  ImageAndTitleBtn.m
//  Sailor
//
//  Created by 曹进龙 on 2017/7/6.
//  Copyright © 2017年 shenhai. All rights reserved.
//

#import "ImageAndTitleBtn.h"

@implementation ImageAndTitleBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [[UIImageView alloc] init];
        self.atitleLabel = [[UILabel alloc] init];
        [self addSubview:self.image];
        [self addSubview:self.atitleLabel];
        
        [self.image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
//            make.top.mas_equalTo(self).with.offset(5);
            make.centerX.mas_equalTo(self);
            make.centerY.mas_equalTo(self).with.offset(-13);
        }];
//        self.image.backgroundColor = [UIColor redColor];
//        self.atitleLabel.backgroundColor = [UIColor yellowColor];
        
        [self.atitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(self).with.offset(5);
//            make.right.mas_equalTo(self).with.offset(-5);
            make.top.mas_equalTo(self.image.mas_bottom).with.offset(10);
            make.height.mas_equalTo(15);
            make.centerX.mas_equalTo(self);
        }];

    }
    return self;
}

@end
