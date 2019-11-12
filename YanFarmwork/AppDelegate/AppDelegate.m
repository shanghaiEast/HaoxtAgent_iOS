//
//  AppDelegate.m
//  YanFarmwork
//
//  Created by Jack Yan on 2019/2/21.
//  Copyright © 2019年 Yanhuaqiang. All rights reserved.
//

#import "AppDelegate.h"

#import <mach/mach.h>


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //屏蔽烦人的Masonry约束警告控制台输出
    [[NSUserDefaults standardUserDefaults] setValue:@(NO) forKey:@"_UIConstraintBasedLayoutLogUnsatisfiable"];
    
   
#pragma mark  IQKeyboardManager
    _keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    _keyboardManager.enable = YES; // 控制整个功能是否启用
    _keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    _keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
//    _keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    _keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    _keyboardManager.shouldShowToolbarPlaceholder = NO; // 是否显示占位文字
    _keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    _keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离
    
    
    [self initView];
    
    
    return YES;
    
    
    
#pragma mark 中间凸起标签栏
    //    _myTabBarC = [[MyTabBarController alloc]init];
    //        [_myTabBarC setViewControllers:bars];
    //
    //    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //    self.window.rootViewController = _myTabBarC;
    //    self.window.backgroundColor = [UIColor whiteColor];
    //    [self.window makeKeyAndVisible];
    //    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (void)initView{
    _mainVC = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    _mainVC.title = @"首页";
    UINavigationController *mainNav = [[UINavigationController alloc]initWithRootViewController:_mainVC];
    
    _collegeVC = [[CollegeViewController alloc]initWithNibName:@"CollegeViewController" bundle:nil];
    _collegeVC.title = @"商学院";
    UINavigationController *optionalNav = [[UINavigationController alloc]initWithRootViewController:_collegeVC];
    
    _personCenterVC = [[PersonCenterViewController alloc]initWithNibName:@"PersonCenterViewController" bundle:nil];
    _personCenterVC.title = @"我的";
    UINavigationController *personCenterNav = [[UINavigationController alloc]initWithRootViewController:_personCenterVC];
    
    NSArray *bars = [[NSArray alloc]initWithObjects:mainNav,optionalNav,personCenterNav, nil];
    
    
    
    
    
#pragma mark 正常标签栏
    _tabBarC = [[UITabBarController alloc]init];
    [_tabBarC setViewControllers:bars];
    
    UITabBar *tabBar = _tabBarC.tabBar;
    tabBar.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    NSArray *barName = [[NSArray alloc]initWithObjects:@"首页",@"商学院",@"我的", nil];
    
    NSArray *barColor = [[NSArray alloc]initWithObjects:
                         MAINCOLOR,
                         MAINCOLOR,
                          MAINCOLOR,
                         nil];
    
    NSArray *barPic = [[NSArray alloc]initWithObjects:
                       @"tab_one_unSelect",
                       @"tab_two_unSelect",
                       @"tab_three_unSelect",
                       nil];
    NSArray *barSelectPic = [[NSArray alloc]initWithObjects:
                             @"tab_one_Select",
                             @"tab_two_Select",
                             @"tab_three_Select",
                             nil];
    
    for (int a = 0; a<barPic.count; a++) {
        UITabBarItem *tabBarItem = [tabBar.items objectAtIndex:a];
        tabBarItem.tag = a;
        [tabBarItem setTitle:[barName objectAtIndex:a]];
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[barColor objectAtIndex:a], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
        [tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
        tabBarItem.image = [[UIImage imageNamed:[barPic objectAtIndex:a]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        tabBarItem.selectedImage = [[UIImage imageNamed:[barSelectPic objectAtIndex:a]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    _tabBarC.selectedIndex = 0;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = _tabBarC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
}


@end


