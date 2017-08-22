//
//  ProfileViewController.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/22.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "ProfileViewController.h"

static CGFloat const imageBGHeight = 240; // 背景图片的高度


@interface ProfileViewController ()<UITableViewDelegate, UITableViewDataSource>

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
 *中间导航栏的标题
 */
@property(weak,nonatomic)UILabel* titleLabel;

/**
 * 右边设置的按钮
 */
@property(nonatomic,weak)UIButton* settingBtn;

@end

@implementation ProfileViewController


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.aTableView = nil;
    self.view = nil;
    
//    self.navigationController.navigationBar.hidden = NO;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航条背景"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //
    self.automaticallyAdjustsScrollViewInsets=NO;
    
//    self.navigationController.navigationBar.hidden = YES;
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    [self createTableView];
    [self createBgImageView];
    
    //    [self viewDidLayoutSubviews];
    
}

-(void)createTableView
{
    //    if (!_tableView) {
    //        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) style:UITableViewStylePlain];
    UITableView* tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 20) style:UITableViewStyleGrouped];
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
    UIImageView *BgImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, -imageBGHeight, self.view.bounds.size.width, imageBGHeight)];
    BgImage.image=[UIImage imageNamed:@"屏幕快照"];
    BgImage.userInteractionEnabled = YES;
    self.BgImage=BgImage;
    [self.aTableView addSubview:self.BgImage];
    
    /**
     *创建用户空间背景图片的容器View
     */
    UIView*  bgView=[[UIView alloc]init];
    bgView.frame=CGRectMake(0, -imageBGHeight, self.view.bounds.size.width, imageBGHeight);
    self.bgView=bgView;
    [self.aTableView addSubview:self.bgView];
    
//    [self createTitleLabel];
    [self createLeftBtn];
    
}
//#pragma mark -- 标题
//-(void)createTitleLabel
//{
//    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
//    titleLabel.textColor=[UIColor whiteColor];
//    titleLabel.text=@"个人中心";
//    titleLabel.textAlignment=NSTextAlignmentCenter;
//    self.navigationItem.titleView=titleLabel;
//    self.titleLabel=titleLabel;
//    
//}

#pragma mark -- 设置按钮
-(void)createLeftBtn
{
    UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,0,40,40)];
    leftBtn.backgroundColor = [UIColor redColor];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    //    [leftBtn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    self.settingBtn=leftBtn;
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:self.settingBtn];
    self.navigationItem.rightBarButtonItem=leftItem;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1){
        return 2;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"jjjj";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test~~~~~%ld",indexPath.section + indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    CGFloat cacheContentSize = [self folderSizeAtPath:cachePath];
    
    NSString *hint = [NSString stringWithFormat:@"缓存大小为%.1fM,确定要清理缓存吗？",cacheContentSize];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:hint preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self clearCache];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 清除缓存
- (void)clearCache {
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    for (NSString *p in files) {
        NSError *error;
        NSString *path = [cachePath stringByAppendingPathComponent:p];
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
        }
    }
}

#pragma mark - 计算缓存文件大小
/**
 *  遍历文件夹获得文件夹大小，返回多少M
 */
- (float )folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

/**
 *  单个文件的大小
 *
 *  @param filePath 文件路径
 */
- (long long)fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
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
    
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[[UIColor redColor] colorWithAlphaComponent:alpha]] forBarMetrics:UIBarMetricsDefault];
    //self.titleLabel.alpha=alpha;
    alpha=fabs(alpha);
    alpha=fabs(1-alpha);
    
    alpha=alpha<0.2? 0:alpha-0.1;
    //    self.navigationController.navigationBar.alpha = alpha;
    self.bgView.alpha=alpha;
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
