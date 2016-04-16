//
//  CRShareView.m
//  share
//
//  Created by 武恩泽 on 16/4/16.
//  Copyright © 2016年 武恩泽. All rights reserved.
//

#import "CRShareView.h"

#define APPFONT(c_font)           [UIFont systemFontOfSize:(c_font)]
#define ApplicationframeValue     [[UIScreen mainScreen]bounds].size

@interface CRShareView()

@property (nonatomic, strong) NSArray* titleArr;
@property (nonatomic, strong) NSArray* imageArr;

@end

@implementation CRShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, ApplicationframeValue.width, 200);
        [self initViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
    }
    return self;
}

#pragma mark --
#pragma mark Private funcs

- (void)initViews
{
   
    [self addSubview:self.viewS];
    
}

#pragma mark -- 
#pragma mark Public funcs

-(void)show
{
    UIWindow* window = [[UIApplication sharedApplication]keyWindow];
    [window addSubview:self.overlayView];
    [window addSubview:self];
    
    [self fadeIn];
}

-(void)dismiss
{
    [self fadeOut];
}


-(void)fadeIn
{
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
    }];
}

-(void)fadeOut
{
    [UIView animateWithDuration:.35 animations:^{
        
        self.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self.overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}


#pragma mark --
#pragma mark Event Controls

-(void)onBtn:(UIButton*)sender
{
    switch (sender.tag) {
        case 1:
            [self shareWechat];
            break;
        case 2:
            [self sharePengYouQuan];
            break;
        default:
            break;
    }
}


- (void)shareWechat
{
    NSLog(@"share wechat");
}


- (void)sharePengYouQuan
{
    NSLog(@"share pengyouquan");
}


#pragma mark --
#pragma mark 懒加载

-(NSArray *)titleArr
{
    if (!_titleArr) {
        _titleArr = [NSArray arrayWithObjects:@"微信好友",@"朋友圈", nil];
    }
    return _titleArr;
}

-(NSArray *)imageArr
{
    if (!_imageArr) {
        _imageArr = [NSArray arrayWithObjects:@"share_wechat",@"share_pengyouquan", nil];
    }
    return _imageArr;
}

- (UIControl *)overlayView
{
    if (!_overlayView) {
        _overlayView = [[UIControl alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
        _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
        [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _overlayView;
}


- (UIView *)viewS
{
    if (!_viewS) {
        _viewS = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ApplicationframeValue.width, 200)];
        _viewS.backgroundColor = [UIColor whiteColor];
        
        UILabel *TitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((ApplicationframeValue.width-100)/2, 15, 100, 20)];
        TitleLabel.textAlignment = NSTextAlignmentCenter;
        TitleLabel.text = @"立即分享";
        TitleLabel.backgroundColor = [UIColor whiteColor];
        TitleLabel.font = APPFONT(14);
        [_viewS addSubview:TitleLabel];
        
        UIImageView *lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 45, ApplicationframeValue.width, 1)];
        lineImage.alpha = 0.5f;
        lineImage.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4f];
        [_viewS addSubview:lineImage];
        
        for (int i = 0; i < [self.imageArr count]; i++) {
            
            CGSize size = [UIImage imageNamed:@"share_pengyouquan"].size;
            NSInteger shareCount = self.titleArr.count;
            
            float Margin = ceilf((ApplicationframeValue.width - (shareCount*size.width))/(shareCount+1));
            NSInteger btnWidth = size.width;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = i + 1;
            btn.frame = CGRectMake(Margin*i + btnWidth*i + Margin,60, btnWidth, size.height);
            [btn setBackgroundImage:[UIImage imageNamed:self.imageArr[i]] forState:UIControlStateNormal];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(btn.frame), CGRectGetMaxY(btn.frame)+10, btnWidth, 15)];
            
            label.textAlignment = NSTextAlignmentCenter;
            label.text = self.titleArr[i];
            label.font = APPFONT(12);
            label.adjustsFontSizeToFitWidth = YES;
            [btn addTarget:self action:@selector(onBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [_viewS addSubview:label];
            [_viewS addSubview:btn];
        }
        
        
        UIButton* cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(30, self.frame.size.height - 50, ApplicationframeValue.width-60, 35);
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1.0]];
        cancelBtn.titleLabel.font = APPFONT(18);
        [cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
        UIBezierPath* cornerPath = [UIBezierPath bezierPathWithRoundedRect:cancelBtn.bounds cornerRadius:5.0f];
        CAShapeLayer* shaplayer = [[CAShapeLayer alloc]init];
        shaplayer.path = cornerPath.CGPath;
        shaplayer.borderColor = [UIColor redColor].CGColor;
        
        cancelBtn.layer.mask = shaplayer;
        
        [_viewS addSubview:cancelBtn];
        
    }
    return _viewS;
}
@end
