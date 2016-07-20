//
//  FMTabBarButton.m
//  fleamarket
//
//  Created by ma arno on 16/7/18.
//  Copyright © 2016年 amsoft. All rights reserved.
//

#import "FMTabBarButton.h"
#import "NSString+Extension.h"

#define IMAGE_SIZE_W_H 24

@implementation FMTabBarButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addComponents];
    }
    return self;
}
-(void)addComponents{
    
    self.imageView = [[UIImageView alloc] init];
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:8.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.badgeValueView = [[UIView alloc] init];
    self.badgeValueView.backgroundColor = [UIColor redColor];
    self.badgeValueLabel = [[UILabel alloc] init];
    self.badgeValueLabel.font = [UIFont systemFontOfSize:8.f];
    self.badgeValueLabel.textColor = [UIColor whiteColor];
    self.badgeValueLabel.textAlignment = NSTextAlignmentCenter;
    [self.badgeValueView addSubview:self.badgeValueLabel];
    
    
    [self addSubview:self.badgeValueView];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    
}
-(void)setImage:(UIImage *)image{
    [self.imageView setImage:image];
}
-(void)setTitle:(NSString *)title{
    [self.titleLabel setText:title];
}
-(void)setSelectedImage:(UIImage *)selectedImage{
    [self.imageView setHighlightedImage:selectedImage];
}
-(void)setBadgeValue:(NSString *)badgeValue{
    self.badgeValueLabel.text = badgeValue;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"布局TabBarButton内的控件");
    CGFloat meH = self.frame.size.height;
    CGFloat meW = self.frame.size.width;
    CGFloat centerX = meW / 2 - IMAGE_SIZE_W_H/2;
    CGFloat centerY = meH / 2 - IMAGE_SIZE_W_H/2;
    
    self.imageView.frame = CGRectMake(centerX,centerY - 4, IMAGE_SIZE_W_H, IMAGE_SIZE_W_H);
    CGSize textSize = [self.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:8.f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    NSLog(@"%@",NSStringFromCGSize(textSize));

    self.titleLabel.frame = CGRectMake(meW / 2 - textSize.width/2,CGRectGetMaxY(self.imageView.frame) + 3, textSize.width, textSize.height);
    
    
    //布局badgeValueLabel
    
    if ([self.badgeValueLabel.text integerValue] > 0) {
        if (self.badgeValueLabel.text.length >= 3) { //如果是三位数
            self.badgeValueLabel.text= @"99+";
        }
        CGSize badgeSize = [self.badgeValueLabel.text sizeWithFont:[UIFont systemFontOfSize:8.f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        self.badgeValueView.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 3, CGRectGetMinY(self.imageView.frame), badgeSize.width + 5, badgeSize.height);
        self.badgeValueLabel.frame = self.badgeValueView.bounds;
        self.badgeValueView.layer.cornerRadius = badgeSize.height / 2;
    }
}
-(void)setSelected:(BOOL)selected{
    self.imageView.highlighted = selected;
}
@end
