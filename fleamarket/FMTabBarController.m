//
//  FMTabBarController.m
//  fleamarket
//
//  Created by ma arno on 16/7/17.
//  Copyright © 2016年 amsoft. All rights reserved.
//

#import "FMTabBarController.h"
#import "FMTabBar.h"

@interface FMTabBarController ()<FMTabBarDelegate>

@property (nonatomic,strong) FMTabBar *fmTb;

@end

@implementation FMTabBarController


+(instancetype)initWithControllers:(NSArray *)controllers{
    FMTabBarController *tbController = [[self alloc] init];
    for (UIViewController *item in controllers) {
        [tbController addChildViewController:item];
    }
    [tbController initTabBar];
    
    return tbController;
}
-(void)initTabBar{
    
    FMTabBar *tabBar = [[FMTabBar alloc] init];
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;

    NSMutableArray *items = [NSMutableArray array];
    for (UIViewController *item in self.viewControllers) {
        [items addObject:item.tabBarItem];
    }
    tabBar.tabBarItems = items;
    
    [self.tabBar addSubview:tabBar];
    self.fmTb = tabBar;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    //进行TabBar多余元素的移除
    for (UIView *sv in self.tabBar.subviews) {
        if (![sv isKindOfClass:[FMTabBar class]]) {
            [sv removeFromSuperview];
        }
    }
    
    //改变TabBar的高度
    CGRect newFrame = self.tabBar.frame;
    newFrame.size.height = 69;
    newFrame.origin.y = [UIScreen mainScreen].bounds.size.height - 69;
    self.tabBar.frame = newFrame;
    self.fmTb.frame = self.tabBar.bounds; //frame必须等于bounds才可以
}

-(void)fmTabBar:(FMTabBar *)tabBar selectedIndex:(NSInteger)index{
    self.selectedIndex = index;
}
@end
