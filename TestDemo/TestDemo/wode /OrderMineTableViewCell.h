//
//  OrderMineTableViewCell.h
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/23.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageAndTitleBtn.h"

@interface OrderMineTableViewCell : UITableViewCell

/**
待付款
 */
@property (nonatomic, strong) ImageAndTitleBtn * paymentBtn;

/**
 代发货
 */
@property (nonatomic, strong) ImageAndTitleBtn * sendBtn;

/**
 已发货
 */
@property (nonatomic, strong) ImageAndTitleBtn * shippedBtn;

/**
 售后
 */
@property (nonatomic, strong) ImageAndTitleBtn * afterBtn;

/**
 全部订单
 */
@property (nonatomic, strong) UIButton *allBtn;
@property (nonatomic, strong) UIButton *allBtnImage;

@end
