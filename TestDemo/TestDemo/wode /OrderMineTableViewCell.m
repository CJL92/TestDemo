//
//  OrderMineTableViewCell.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/23.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "OrderMineTableViewCell.h"

@implementation OrderMineTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.paymentBtn = [[ImageAndTitleBtn alloc] init];
        self.sendBtn = [[ImageAndTitleBtn alloc] init];
        self.shippedBtn = [[ImageAndTitleBtn alloc] init];
        self.afterBtn = [[ImageAndTitleBtn alloc] init];
        self.allBtn = [[UIButton alloc] init];
        self.allBtnImage = [[UIButton alloc] init];
    
        UILabel *myOrder = [[UILabel alloc] init];
        UILabel *line = [[UILabel alloc] init];
        UILabel *line1 = [[UILabel alloc] init];
        UILabel *line2 = [[UILabel alloc] init];
        UILabel *line3 = [[UILabel alloc] init];
        
        [self addSubview:line1];
        [self addSubview:line2];
        [self addSubview:line3];
        [self addSubview:line];
        [self addSubview:myOrder];
        [self addSubview:self.paymentBtn];
        [self addSubview:self.sendBtn];
        [self addSubview:self.shippedBtn];
        [self addSubview:self.afterBtn];
        [self addSubview:self.allBtn];
        [self addSubview:self.allBtnImage];
        
        [myOrder mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).with.offset(15);
            make.top.mas_equalTo(self).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        myOrder.text = @"我的订单";
        myOrder.font = [UIFont systemFontOfSize:15];
        
        [self.allBtnImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
//            make.centerX.mas_equalTo(myOrder);
            make.top.mas_equalTo(self).with.offset(15);
            make.right.mas_equalTo(self.mas_right).with.offset(-10);
        }];
//        self.allBtnImage.backgroundColor = [UIColor redColor];
        
        
        
        [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 20));
            make.right.mas_equalTo(self.allBtnImage.mas_left).with.offset(-5);
//            make.centerX.mas_equalTo(self.allBtnImage);
            make.top.mas_equalTo(self).with.offset(15);
        }];
        self.allBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.allBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.allBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.allBtn setTitle:@"全部订单" forState:UIControlStateNormal];
        
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(myOrder.mas_bottom).with.offset(15);
            make.left.and.right.mas_equalTo(self).with.offset(0);
            make.height.mas_equalTo(1);
        }];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.paymentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kDeiveWidth/4, 88));
            make.top.mas_equalTo(line).with.offset(0);
            make.left.mas_equalTo(self).with.offset(0);
        }];
        self.paymentBtn.atitleLabel.text = @"待付款";
        self.paymentBtn.atitleLabel.font = [UIFont systemFontOfSize:15];

        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, 50));
            make.left.mas_equalTo(self.paymentBtn.mas_right).with.offset(0);
            make.centerY.mas_equalTo(self.paymentBtn);
        }];
        line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        
        [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kDeiveWidth/4, 88));
            make.top.mas_equalTo(line).with.offset(0);
            make.left.mas_equalTo(self.paymentBtn.mas_right).with.offset(0);
        }];
        self.sendBtn.atitleLabel.text = @"待发货";
        self.sendBtn.atitleLabel.font = [UIFont systemFontOfSize:15];

        
        
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, 50));
            make.left.mas_equalTo(self.sendBtn.mas_right).with.offset(0);
            make.centerY.mas_equalTo(self.sendBtn);
        }];
        line2.backgroundColor = [UIColor groupTableViewBackgroundColor];

        [self.shippedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kDeiveWidth/4, 88));
            make.top.mas_equalTo(line).with.offset(0);
            make.left.mas_equalTo(self.sendBtn.mas_right).with.offset(0);
        }];
        self.shippedBtn.atitleLabel.text = @"已发货";
        self.shippedBtn.atitleLabel.font = [UIFont systemFontOfSize:15];

        [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(1, 50));
            make.left.mas_equalTo(self.shippedBtn.mas_right).with.offset(0);
            make.centerY.mas_equalTo(self.shippedBtn);
        }];
        line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [self.afterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(kDeiveWidth/4, 88));
            make.top.mas_equalTo(line).with.offset(0);
            make.left.mas_equalTo(self.shippedBtn.mas_right).with.offset(0);
        }];
        self.afterBtn.atitleLabel.text = @"售后";
        self.afterBtn.atitleLabel.font = [UIFont systemFontOfSize:15];
        
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
