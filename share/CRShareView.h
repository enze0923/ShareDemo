//
//  CRShareView.h
//  share
//
//  Created by 武恩泽 on 16/4/16.
//  Copyright © 2016年 武恩泽. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CRShareDataModel.h"

@interface CRShareView : UIView


@property (nonatomic, strong) UIControl* overlayView;//灰色背景
@property(nonatomic, strong) UIView* viewS;//底部选择视图

/**
 *  保存要分享的数据
 *  title, content
 *  img, shareUrl
 */
//@property (nonatomic, strong) CRShareModel* shareModel;

-(void)show;
-(void)dismiss;

@end
