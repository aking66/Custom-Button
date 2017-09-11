//
//  ViewController.m
//  CustomButton
//
//  Created by 程磊 on 17/9/11.
//  Copyright © 2017年 程磊. All rights reserved.
//

#import "ViewController.h"
#import "TapButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)viewDidLayoutSubviews
{
    // 一共十三种按钮类型
    NSArray *titles = @[@"默认", @"文字左图片右", @"文字右图片左", @"文字上图片下", @"文字下图片上", @"文字最左图片最右", @"文字最右图片最左", @"文字图片最左", @"文字图片最右", @"图片文字最左", @"图片文字最右", @"只有文字", @"只有图片", @"", @""];
    for (int i = 0; i <= OnlyImageIsCenter; i ++) {
        CGRect rect = CGRectMake(40 + i % 2 * 150, 70 * ((i+1) / 2 + 1), 120, 50);
        [self creatButtonWithFrame:rect title:titles[i] imageStr:@"test1" type:TitleImageDefault + i];
    }
    
}


/**
 创建button

 @param frame frame
 @param title 文字
 @param imageStr 图片名字
 @param type button类型
 */
- (void)creatButtonWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr type:(ControlsType)type
{
    TapButton *btn1 = [[TapButton alloc]initWithFrame:frame];
    [btn1 setTitle:title forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor darkTextColor] forState:(UIControlStateNormal)];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setImage:[UIImage imageNamed:imageStr] forState:(UIControlStateNormal)];
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    btn1.controlsType = type;
    [self.view addSubview:btn1];
    [btn1 addTapBlock:^(TapButton *sender) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
