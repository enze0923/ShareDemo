//
//  ViewController.m
//  share
//
//  Created by 武恩泽 on 16/4/16.
//  Copyright © 2016年 武恩泽. All rights reserved.
//

#import "ViewController.h"
#import "CRShareView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"分享";

    CGRect rect =  [[UIScreen mainScreen]bounds];
    UIButton* button = [[UIButton alloc]initWithFrame:CGRectMake((rect.size.width -100)/2, 150,100, 40)];
    [button setTitle:@"点我开始分享" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(ClickToShare:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)ClickToShare:(id)sender {
    CRShareView *view = [[CRShareView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200)];
    
    [view show];
    
    
}

@end
