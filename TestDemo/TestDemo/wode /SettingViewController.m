//
//  SettingViewController.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/24.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"设置";
    
    [self.view addSubview:self.tableView];
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeiveWidth, kDeiveHeight) style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = @"setting";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            CGFloat cacheContentSize = [self folderSizeAtPath:cachePath];
            cell.textLabel.text = @"清除缓存";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fM",cacheContentSize];
            
        }
        
    }
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
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
    }
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
