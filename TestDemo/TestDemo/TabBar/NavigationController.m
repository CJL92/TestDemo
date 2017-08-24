//
//  NavigationController.m
//  品生活
//
//  Created by Mac on 15/11/3.
//  Copyright © 2015年 Mac. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
}

+ (void)initialize
{
    //设置UINavigationBarTheme的主题
    [self setupNavigationBarTheme];
    
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
     [appearance setBackgroundImage:[self imageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:15];
    // UIOffsetZero是结构体, 只要包装成NSValue对象, 才能放进字典\数组中
    textAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    [appearance setTitleTextAttributes:textAttrs];
    
}
/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)

        viewController.hidesBottomBarWhenPushed = YES;
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
        [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
//#warning 这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}

//- (void)more
//{
//   [self popToRootViewControllerAnimated:YES];
//}




+ (UIImage *)imageWithColor:(UIColor *)color
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













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
