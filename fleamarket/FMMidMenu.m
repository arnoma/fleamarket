//
//  FMMidMenu.m
//  fleamarket
//
//  Created by ma arno on 16/7/19.
//  Copyright © 2016年 amsoft. All rights reserved.
//

#import "FMMidMenu.h"
#import "NSString+Extension.h"

@interface FMMidMenu()

@property (nonatomic,strong) UIButton *bottomRotateButton;
@property (nonatomic,strong) UIButton *akeyBtn;
@property (nonatomic,strong) UIButton *cameraBtn;
@property (nonatomic,strong) UIButton *albumBtn;

@property (nonatomic,strong) UILabel *akeyLabel;
@property (nonatomic,strong) UILabel *cameraLabel;
@property (nonatomic,strong) UILabel *albumLabel;

@end

@implementation FMMidMenu

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addComponents];
    }
    return self;
}
-(void)addComponents{
    //添加底部旋转按钮
    UIButton *btb = [UIButton buttonWithType:UIButtonTypeCustom];
    [btb setImage:[UIImage imageNamed:@"post_animate_add"] forState:UIControlStateNormal];
    btb.frame = CGRectMake(self.center.x - 56/2,self.frame.size.height - 69, 56, 56);
//    btb.layer.borderWidth = 1.f;
//    btb.layer.borderColor = [UIColor whiteColor].CGColor;
    btb.layer.cornerRadius = 56/2;
    
    btb.userInteractionEnabled = YES;
    self.bottomRotateButton = btb;
    [self.bottomRotateButton addTarget:self action:@selector(bottomBtnAction) forControlEvents:UIControlEventTouchUpInside];
//    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomBtnAction)];
//    [self.bottomRotateButton addGestureRecognizer:touch];
    [self addSubview:btb];
    
    
    
    //添加菜单
    CGFloat initY = CGRectGetMinY(self.bottomRotateButton.frame) - 140;
    CGFloat partW = self.frame.size.width / 3;
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraBtn setImage:[UIImage imageNamed:@"post_animate_camera"] forState:UIControlStateNormal];
    [cameraBtn setFrame:self.bottomRotateButton.frame];
    
    UIButton *albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [albumBtn setImage:[UIImage imageNamed:@"post_animate_album"] forState:UIControlStateNormal];
    [albumBtn setFrame:self.bottomRotateButton.frame];

    
    UIButton *akeyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [akeyBtn setImage:[UIImage imageNamed:@"post_animate_akey"] forState:UIControlStateNormal];
    [akeyBtn setFrame:self.bottomRotateButton.frame];
    
    [self insertSubview:cameraBtn belowSubview:self.bottomRotateButton];
    [self insertSubview:albumBtn belowSubview:cameraBtn];
    [self insertSubview:akeyBtn belowSubview:albumBtn];
    
    
    //添加菜单文字
    UILabel *cL = [[UILabel alloc] init];
    cL.text = @"拍照";
    cL.font = [UIFont systemFontOfSize:10.f];
    cL.alpha = 0;
    cL.textColor = [UIColor whiteColor];
    CGSize cLSize = [cL.text sizeWithFont:[UIFont systemFontOfSize:10.f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [cL setFrame:CGRectMake(partW/2 - cLSize.width/2, initY + 90, cLSize.width, cLSize.height)];
    [self addSubview:cL];
    
    
    UILabel *abL = [[UILabel alloc] init];
    abL.text = @"相册";
    abL.font = [UIFont systemFontOfSize:10.f];
    abL.alpha = 0;
    abL.textColor = [UIColor whiteColor];

    CGSize abLSize = [abL.text sizeWithFont:[UIFont systemFontOfSize:10.f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [abL setFrame:CGRectMake(partW + partW/2 - abLSize.width/2, initY + 90, abLSize.width, abLSize.height)];
    [self addSubview:abL];
    
    UILabel *akL = [[UILabel alloc] init];
    akL.text = @"淘宝一键转卖";
    akL.font = [UIFont systemFontOfSize:10.f];
    akL.alpha = 0;
    akL.textColor = [UIColor whiteColor];
    CGSize akLSize = [akL.text sizeWithFont:[UIFont systemFontOfSize:10.f] maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    [akL setFrame:CGRectMake(2*partW + partW/2 - akLSize.width/2, initY + 90, akLSize.width, akLSize.height)];
    [self addSubview:akL];
    
    self.albumLabel = abL;
    self.akeyLabel = akL;
    self.cameraLabel = cL;
    
    self.albumBtn = albumBtn;
    self.akeyBtn = akeyBtn;
    self.cameraBtn = cameraBtn;
    
}
-(void)bottomBtnAction{
    self.cameraLabel.alpha = 0;
    self.albumLabel.alpha = 0;
    self.akeyLabel.alpha = 0;
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            [self.akeyBtn setFrame:self.bottomRotateButton.frame];
            self.akeyBtn.alpha = 0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            [self.albumBtn setFrame:self.bottomRotateButton.frame];
            self.albumBtn.alpha = 0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
            [self.cameraBtn setFrame:self.bottomRotateButton.frame];
            self.cameraBtn.alpha = 0;
        }];
        self.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
        self.bottomRotateButton.transform = CGAffineTransformRotate(self.bottomRotateButton.transform,M_PI_4);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
-(void)startAnimateComponents:(void (^)())competion{
    CGFloat initY = CGRectGetMinY(self.bottomRotateButton.frame) - 140;
    CGFloat partW = self.frame.size.width / 3;
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            [self.cameraBtn setFrame:CGRectMake(partW/2 - 40, initY, 80, 80)];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            [self.albumBtn setFrame:CGRectMake(partW + partW/2 - 40, initY, 80, 80)];
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
            [self.akeyBtn setFrame:CGRectMake(2*partW + partW/2 - 40, initY, 80, 80)];
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateKeyframesWithDuration:0.6 delay:0.2 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.cameraLabel.alpha = 1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            self.albumLabel.alpha = 1;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
            self.akeyLabel.alpha = 1;
        }];
        
    } completion:^(BOOL finished) {
        
    }];
    

    
    [UIView animateWithDuration:0.6 delay:0.0 usingSpringWithDamping:0.45 initialSpringVelocity:0.0 options:0 animations:^{
        self.bottomRotateButton.transform = CGAffineTransformRotate(self.bottomRotateButton.transform, -M_PI_4);
    } completion:^(BOOL finished) {
        
    }];
    
}

@end
