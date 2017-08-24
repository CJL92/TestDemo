//
//  ProfileViewController.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/22.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "ProfileViewController.h"
#import "OrderMineTableViewCell.h"
#import "PersonalDataVC.h"
#import "SettingViewController.h"
#import "AllViewController.h"
#import "MIneViewController.h"



static CGFloat const imageBGHeight = 200; // 背景图片的高度


@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    
    UIImageView *iconimage;//头像
    UILabel *nameLabel;//名字
    UILabel *telLabel;//手机号
}
@property (nonatomic, strong) UITableView *aTableView;

/**
 *空间的背景图片BgImage
 */
@property(weak,nonatomic)UIImageView* BgImage;
/**
 *空间的背景图片bgView
 */
@property(nonatomic,weak)UIView* bgView;
/**
 * 右边设置的按钮
 */
@property(nonatomic,weak)UIButton* settingBtn;

@property(nonatomic,strong)NSMutableArray *tableData;


@end

@implementation ProfileViewController


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    self.aTableView = nil;
//    self.view = nil;

    self.navigationController.navigationBar.alpha = 1;
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
//    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self setupData];
    
    [self createTableView];
    [self createBgImageView];

    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)setupData{
    
    NSArray *section4 = @[@{@"title":@"我的云币",@"imageNamed":@"密码服务1.4"},@{@"title":@"我的优惠券",@"imageNamed":@"绑定手机1.4"}];
    NSArray *section2 = @[@{@"title":@"我的拼团",@"imageNamed":@"我的钱包1.4"}];
    NSArray *section3 = @[@{@"title":@"我的收货地址",@"imageNamed":@"我的视频1.4"}];
    NSArray *section1 = @[@{@"title":@"邀请店铺",@"imageNamed":@"证书管理1.4"}];
    
    _tableData = [NSMutableArray arrayWithObjects:section4 ,section2,section3, section1, nil];

}

-(void)createTableView{
    
    //    if (!_tableView) {
    //        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kDeiveWidth, kDeiveHeight) style:UITableViewStyleGrouped];
    self.aTableView=tableView;
    
    self.aTableView.dataSource = self;
    self.aTableView.delegate = self;
    self.aTableView.tableFooterView = [[UIView alloc] init];
    self.aTableView.contentInset=UIEdgeInsetsMake(imageBGHeight, 0, 0, 0);
    self.aTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.aTableView];
    
    [self createBgImageView];
    //    }
    //    return _tableView;
    
}

#pragma mark -- header的大背景
-(void)createBgImageView
{
    /**
     *创建用户空间背景图片
     */
    UIImageView *BgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, -imageBGHeight, kDeiveWidth, imageBGHeight)];
//    BgImage.image=[UIImage imageNamed:@"屏幕快照"];
    BgImage.backgroundColor = [UIColor blackColor];
    BgImage.userInteractionEnabled = YES;
    self.BgImage=BgImage;
    [self.aTableView addSubview:self.BgImage];
    
    /**
     *创建用户空间背景图片的容器View
     */
    UIView*  bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, -imageBGHeight, kDeiveWidth, imageBGHeight);
    self.bgView=bgView;
    [self.aTableView addSubview:self.bgView];
    
    [self createBgUI];
    [self createLeftBtn];
    
}


- (void)createBgUI{

    iconimage = [[ UIImageView alloc] init];
    iconimage.frame = CGRectMake(10, 90, 80, 80);
    iconimage.layer.cornerRadius = 40;
    iconimage.layer.masksToBounds = YES;
    iconimage.backgroundColor = [UIColor redColor];
    [self.bgView addSubview:iconimage];
    
    nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(CGRectGetMaxX(iconimage.frame) + 15, 105, 120, 20);
    nameLabel.backgroundColor = [UIColor yellowColor];
    [self.bgView addSubview:nameLabel];
    
    telLabel = [[UILabel alloc] init];
    telLabel.frame = CGRectMake(CGRectGetMaxX(iconimage.frame) + 15, 135, 120, 20);
    telLabel.backgroundColor = [UIColor blueColor];
    [self.bgView addSubview:telLabel];
    
    UIButton *lookBtn = [[UIButton alloc] initWithFrame:CGRectMake(kDeiveWidth - 80, 90, 80, 80)];
    UIImage *imgArrow = [UIImage imageNamed:@"返回"];
    [lookBtn setImage:imgArrow forState:UIControlStateNormal];
    [lookBtn addTarget:self action:@selector(personClick) forControlEvents:UIControlEventTouchUpInside];
    [self.bgView addSubview:lookBtn];
    
    
}
- (void)personClick{
    
    PersonalDataVC *vc = [[PersonalDataVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -- 导航按钮
-(void)createLeftBtn
{
    self.navigationItem.title = @"";
    
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
//    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    //    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.settingBtn=leftBtn;
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:self.settingBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    UIButton *rightBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
//    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;

    
}
#pragma mark -- 设置
- (void) rightBtnAction{
    
    SettingViewController *vc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _tableData.count + 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 1){
//        return 2;
//    }
//    return 1;
    if(section == 0){
        return 1;
    }else{
        return [_tableData[section - 1] count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 132;
    }
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = @"jjjj";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
        if(indexPath.section == 0){
            
            NSString *cellID = @"OrderMineTableViewCell";
            OrderMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
                cell = [[OrderMineTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:cellID];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell.allBtn addTarget:self action:@selector(allOrderClcik) forControlEvents:UIControlEventTouchUpInside];
            [cell.allBtnImage addTarget:self action:@selector(allOrderClcik) forControlEvents:UIControlEventTouchUpInside];
            [cell.paymentBtn addTarget:self action:@selector(paymentBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.shippedBtn addTarget:self action:@selector(shippedBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.afterBtn addTarget:self action:@selector(afterBtnClick) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }else{
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            NSDictionary *dic = self.tableData[indexPath.section - 1][indexPath.row];
            
            cell.imageView.image = [UIImage imageNamed:[dic objectForKey:@"imageNamed"]];
            cell.textLabel.text = [dic objectForKey:@"title"];

        }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 3) {
        MIneViewController *vc = [[MIneViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

#pragma mark -- 全部订单
- (void)allOrderClcik{
    AllViewController *vc = [[AllViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -- 待付款
- (void) paymentBtnClick{
    AllViewController *vc = [[AllViewController alloc] init];
    vc.judeString = @"1";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 待发货
- (void) sendBtnClick{
    AllViewController *vc = [[AllViewController alloc] init];
    vc.judeString = @"2";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -- 已发货
- (void) shippedBtnClick{
    AllViewController *vc = [[AllViewController alloc] init];
    vc.judeString = @"3";
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark -- 售后
- (void) afterBtnClick{
    
    
}

#pragma mark - UIScrollViewdelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat yOffset  = scrollView.contentOffset.y;
    CGFloat xOffset = (yOffset + imageBGHeight)/2;
    
    if (yOffset < -imageBGHeight ) {
        
        CGRect rect = self.BgImage.frame;
        rect.origin.y = yOffset;
        rect.size.height =  -yOffset ;
        rect.origin.x = xOffset;
        rect.size.width = self.view.bounds.size.width + fabs(xOffset)*2;
        self.BgImage.frame = rect;
        
    }
    
    CGFloat alpha = (yOffset + imageBGHeight)/imageBGHeight;
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    //self.titleLabel.alpha=alpha;
//    alpha=fabs(alpha);
//    alpha=fabs(1-alpha);
//    
//    alpha=alpha<0.2? 0:alpha-0.1;
//    //    self.navigationController.navigationBar.alpha = alpha;
//    self.bgView.alpha=alpha;
}
 
- (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}


#pragma mark -- 懒加载
- (NSMutableArray *)tableData
{
    if (!_tableData) {
        self.tableData = [NSMutableArray array];
    }
    return _tableData;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
