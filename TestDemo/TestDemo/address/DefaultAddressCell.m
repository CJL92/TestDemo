//
//  DefaultAddressCell.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/21.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "DefaultAddressCell.h"

@implementation DefaultAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.nameLabel = [[UILabel alloc] init];
        self.aSwitch = [[UISwitch alloc] init];
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.aSwitch];
        
        self.nameLabel.frame = CGRectMake(15, 0, 100, 44);
        self.aSwitch.frame = CGRectMake( [UIScreen mainScreen].bounds.size.width - 55, 8, 40, 24);
        
        self.nameLabel.text = @"设为默认地址";
        self.nameLabel.font = [UIFont systemFontOfSize:13];
        self.nameLabel.textColor = [UIColor grayColor];
        
        
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
