//
//  TabBarViewController.m
//  品生活
//
//  Created by Mac on 15/11/3.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "TabBarViewController.h"
#import "NavigationController.h"
#import "ProfileViewController.h"
#import "MIneViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //添加子控制器
    [self addAllChildVcs];
    
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    
    MIneViewController *scanView = [[MIneViewController alloc] init];
    [self addOneChlildVc:scanView title:@"地址" imageName:@"应用" selectedImageName:@"应用选中"];

    UIViewController *scanV2iew = [[UIViewController alloc] init];
    [self addOneChlildVc:scanV2iew title:@"地址" imageName:@"应用" selectedImageName:@"应用选中"];

    
    ProfileViewController *wifiView = [[ProfileViewController alloc] init];
    [self addOneChlildVc:wifiView title:@"我的" imageName:@"攻略" selectedImageName:@"攻略选中"];
    
    
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.selectedImage = selectedImage;
    self.tabBar.tintColor=[UIColor redColor];//选中图标颜色
    // 添加为tabbar控制器的子控制器
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:childVc];
   
    [self addChildViewController:nav];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
