//
//  FMTabBar.h
//  fleamarket
//
//  Created by ma arno on 16/7/17.
//  Copyright © 2016年 amsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTabBarButton.h"
@class FMTabBar;

@protocol FMTabBarDelegate <NSObject>

@required
-(void)fmTabBar:(FMTabBar *)tabBar selectedIndex:(NSInteger)index;

@end

@interface FMTabBar : UIView

@property (nonatomic,copy) NSArray *tabBarItems;
@property (nonatomic) id<FMTabBarDelegate> delegate;

@end
