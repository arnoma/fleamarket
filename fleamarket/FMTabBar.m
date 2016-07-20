//
//  FMTabBar.m
//  fleamarket
//
//  Created by ma arno on 16/7/17.
//  Copyright © 2016年 amsoft. All rights reserved.
//

#import "FMTabBar.h"
#import "FMMidMenu.h"
#import "NSString+Extension.h"

@interface FMTabBar()

@property (nonatomic,copy) NSMutableArray *tabButtons;
@property (nonatomic,strong) UIView *shadowView;
@property (nonatomic,strong) UIImageView *publishView;
@property (nonatomic,strong) FMTabBarButton *activeButton;
@property (nonatomic,strong) UILabel *publishLabel;

@end

@implementation FMTabBar

-(NSMutableArray *)tabButtons{
    if (_tabButtons == nil) {
        _tabButtons = [NSMutableArray array];
    }
    return _tabButtons;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //设置TabBar顶部阴影效果
        self.shadowView = [[UIView alloc] init];
        self.shadowView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.shadowView.layer.shadowOffset = CGSizeMake(0, 0);
        self.shadowView.layer.shadowOpacity = 0.2;
        self.shadowView.layer.shadowRadius = 3;
        self.shadowView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shadowView];

        self.publishView = [[UIImageView alloc] init];
        self.publishView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.publishView.layer.shadowOffset = CGSizeMake(0, 0);
        self.publishView.layer.shadowOpacity = 0.1;
        self.publishView.layer.shadowRadius = 2;
        self.publishView.layer.masksToBounds = NO;
        
        

        
//        self.publishView.layer.borderWidth = 1.f;
        self.publishView.layer.cornerRadius = 56 / 2;
        self.publishView.layer.borderColor = [UIColor whiteColor].CGColor;
        [self.publishView setImage:[UIImage imageNamed:@"post_animate_add"]];
        [self addSubview:self.publishView];
        
        
        //发布文字
        self.publishLabel = [[UILabel alloc] init];
        self.publishLabel.font = [UIFont systemFontOfSize:8.f];
        self.publishLabel.text = @"发布";
        [self addSubview:self.publishLabel];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSLog(@"布局TabBar内的控件");
    //布局添加的控件  中间为特殊部件 5部分
    CGFloat tW = self.frame.size.width;
    CGFloat tH = self.frame.size.height;
    CGFloat itemW = tW / 5;
    CGFloat topMargin = 20;
    CGFloat middleImageViewW = 56;
    CGFloat shadowViewH = tH - topMargin;
    self.shadowView.frame = CGRectMake(0, topMargin, tW, shadowViewH);
    
    for (FMTabBarButton *btn in self.tabButtons) {
        if (btn.tag >= 2) {
            btn.frame = CGRectMake(itemW*(btn.tag+1), 0, itemW, shadowViewH);
        } else {
            btn.frame = CGRectMake(itemW*btn.tag, 0, itemW, shadowViewH);
        }
    }
    
    
    
    
    
    //布局中部添加按钮
    self.publishView.frame = CGRectMake(itemW*2 + (itemW / 2 - middleImageViewW/2), 0, middleImageViewW, middleImageViewW);
    self.publishView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabBarAddAction)];
    [self.publishView addGestureRecognizer:touch];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(middleImageViewW/2, middleImageViewW/2) radius:middleImageViewW/2 startAngle:0 endAngle:M_PI clockwise:NO];
    self.publishView.layer.shadowPath = path.CGPath;
    
    
    //发布文字位置
    CGSize pTextSize = [self.publishLabel.text sizeWithFont:[UIFont systemFontOfSize:8.f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.publishLabel.frame = CGRectMake(itemW*2 + (itemW/2 - pTextSize.width/2),CGRectGetMaxY(self.publishView.frame), pTextSize.width, pTextSize.height);
    
    
    
}
-(void)tabBarAddAction{
    FMMidMenu *menu = [[FMMidMenu alloc] initWithFrame:[UIScreen mainScreen].bounds];
    menu.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    [[UIApplication sharedApplication].keyWindow addSubview:menu];
    
    [UIView animateWithDuration:0.2 animations:^{
        menu.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.8];
    } completion:^(BOOL finished) {
        
        [menu startAnimateComponents:^{
            
        }];
        
    }];
    
    
    
}
-(void)setTabBarItems:(NSArray *)tabBarItems{

    //添加控件
    int i = 0;
    
    for (UITabBarItem *item in tabBarItems) {
    
        FMTabBarButton *btn = [[FMTabBarButton alloc] init];
        btn.image = item.image;
        btn.selectedImage = item.selectedImage;
        btn.badgeValue = item.badgeValue;
        btn.title = item.title;
        
        btn.tag = i;
        i++;
        [btn addTarget:self action:@selector(touchTabButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabButtons addObject:btn];
        [self.shadowView addSubview:btn];
        
        if (btn.tag == 0) {
            [self touchTabButton:btn];
        }
    }
    
}
-(void)touchTabButton:(FMTabBarButton *)button{
    if (self.activeButton) {
        self.activeButton.selected = NO;
    }
    button.selected = YES;
    if ([self.delegate respondsToSelector:@selector(fmTabBar:selectedIndex:)]) {
        [self.delegate fmTabBar:self selectedIndex:button.tag];
    }
    self.activeButton = button;
}


@end
