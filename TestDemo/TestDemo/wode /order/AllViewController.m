//
//  AllViewController.m
//  TestDemo
//
//  Created by 曹进龙 on 2017/8/24.
//  Copyright © 2017年 曹进龙. All rights reserved.
//

#import "AllViewController.h"
#import "SCNavTabBarController.h"


@interface AllViewController ()


@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *oneViewController = [[UIViewController alloc] init];
    oneViewController.title = @"全部订单";
    oneViewController.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *twoViewController = [[UIViewController alloc] init];
    twoViewController.title = @"待付款";
    twoViewController.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *threeViewController = [[UIViewController alloc] init];
    threeViewController.title = @"待发货";
    threeViewController.view.backgroundColor = [UIColor whiteColor];
    
    UIViewController *fourViewController = [[UIViewController alloc] init];
    fourViewController.title = @"已发货";
    fourViewController.view.backgroundColor = [UIColor whiteColor];
   
    
    
    NSArray *vcs  = @[oneViewController, twoViewController, threeViewController, fourViewController];
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] initWithSubViewControllers:vcs];
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    navTabBarController.navTabBarLineColor = [UIColor redColor];
    navTabBarController.navTabBarFont = [UIFont systemFontOfSize:12];
    
    [navTabBarController addParentController: self];
    
    
    if ([self.judeString isEqualToString:@"1"]) {
        
        navTabBarController.navTabBar.currentItemIndex = 1;
        [navTabBarController.mainView setContentOffset:CGPointMake(kDeiveWidth * 1, 0)];
        
    }else if ([self.judeString isEqualToString:@"2"]){
        
        navTabBarController.navTabBar.currentItemIndex = 2;
        [navTabBarController.mainView setContentOffset:CGPointMake(kDeiveWidth * 2, 0)];
    }else if ([self.judeString isEqualToString:@"3"]){
        
        navTabBarController.navTabBar.currentItemIndex = 3;
        [navTabBarController.mainView setContentOffset:CGPointMake(kDeiveWidth * 3, 0)];
    }
    


    
    
    
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
