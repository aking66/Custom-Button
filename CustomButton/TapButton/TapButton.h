//
//  TapButton.h
//  Tool
//
//  Created by 侯猛 on 2017/3/22.
//  Copyright © 2017年 HouMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ControlsType) {
    /// 不做任何操作 保持系统原样
    TitleImageDefault               = 0,
    /// 标题左 图片右
    TitleIsLeftImageIsRight         = 1,
    /// 标题右 图片左
    TitleIsRightImageIsLeft         = 2,
    /// 标题上 图片下
    TitleIsTopImageIsBottom         = 3,
    /// 标题下 图片上
    TitleIsBottomImageIsTop         = 4,
    /// 标题在最左 图片在最右
    TitleBestLeftImageBestRight     = 5,
    /// 标题在最右 图片在最左
    TitleBestRightImageBestLeft     = 6,
    /// 标题->图片 最左
    TitleImageBestLeft              = 7,
    /// 标题->图片 最右
    TitleImageBestRight             = 8,
    /// 图片->标题 最左
    ImageTitleBestLeft              = 9,
    /// 图片->标题 最右
    ImageTitleBestRight             = 10,
    /// 只存在标题 则把标题居中 (直接使用默认可能会因为按钮宽度问题略有偏差)
    OnlyTitleIsCenter               = 11,
    /// 只存在图片 则把图片居中 (同上)
    OnlyImageIsCenter               = 12,
};

@interface TapButton : UIButton

typedef void (^HanderBlock)(TapButton *sender);

/// 添加block点击回调
/// block参数为自身
- (void)addTapBlock:(HanderBlock)block;

/// 按钮的图片 标题图片排列格式
@property (assign, nonatomic) ControlsType controlsType ;

/// 标题和图片间距 (相对于上部和左部的控件设置 若上下则下方的移动 若左右则右方的移动)
@property (assign, nonatomic) CGFloat imageTitleIsDistance ;

/// 图片的左右偏移量 (正数向右移动 负数向左移动)
@property (assign, nonatomic) CGFloat imageOffsetLeftOrRight ;

/// 图片的上下偏移量 (正数向下移动 负数向上移动)
@property (assign, nonatomic) CGFloat imageOffsetTopOrBottom ;

/// 标题的左右偏移量 (正数向右移动 负数向左移动)
@property (assign, nonatomic) CGFloat titleOffsetLeftOrRight ;

/// 标题的上下偏移量 (正数向下移动 负数向上移动)
@property (assign, nonatomic) CGFloat titleOffsetTopOrBottom ;

/// 是否关闭热区放大 default = false
@property (assign, nonatomic) BOOL closeBlowUpHotSpots ;

@end
