//
//  AddressTableViewCell.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/21.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textField = [[UITextField alloc] init];
        
        self.textField.frame = CGRectMake(15, 0,  [UIScreen mainScreen].bounds.size.width - 20, 44);
        
        self.textField.font = [UIFont systemFontOfSize:14];
        
        [self addSubview:self.textField];
        
        
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
