//
//  FMTabBarButton.h
//  fleamarket
//
//  Created by ma arno on 16/7/18.
//  Copyright © 2016年 amsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMTabBarButton : UIControl

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *badgeValueView;
@property (nonatomic,strong) UILabel *badgeValueLabel;


@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *selectedImage;
@property (nonatomic,copy) NSString *badgeValue;
@property (nonatomic,copy) NSString *title;

@end
