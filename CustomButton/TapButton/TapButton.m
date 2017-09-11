//
//  TapButton.m
//  Tool
//
//  Created by 侯猛 on 2017/3/22.
//  Copyright © 2017年 HouMeng. All rights reserved.
//

#import "TapButton.h"
#import <objc/runtime.h>

@interface UIView (Additions)

/// 控件顶部坐标
@property (nonatomic, assign) CGFloat top;
/// 控件底部坐标
@property (nonatomic, assign) CGFloat bottom;
/// 控件左侧坐标
@property (nonatomic, assign) CGFloat left;
/// 控件右侧坐标
@property (nonatomic, assign) CGFloat right;
/// 控件宽度
@property (nonatomic, assign) CGFloat width;
/// 控件高度
@property (nonatomic, assign) CGFloat height;
/// 控件中心x坐标
@property (nonatomic, assign) CGFloat centerX;
/// 控件中心y坐标
@property (nonatomic, assign) CGFloat centerY;
/// 控件尺寸(width,height)
@property (nonatomic, assign) CGSize  size;
/// 控件坐标(x，y)
@property (assign, nonatomic) CGPoint origin ;
/// 控件坐标自身中心点
@property (assign, nonatomic, readonly) CGPoint middle ;
/// 控件坐标自身中心点
@property (assign, nonatomic, readonly) CGFloat middleX ;
/// 控件坐标自身中心点
@property (assign, nonatomic, readonly) CGFloat middleY ;
@end

@implementation UIView (Additions)

#pragma mark - get frame
- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGPoint)middle
{
    return CGPointMake(self.frame.size.width * .5, self.frame.size.height * .5);
}

- (CGFloat)middleX
{
    return self.frame.size.width * .5;
}

- (CGFloat)middleY
{
    return self.frame.size.height * .5;
}

#pragma mark - set frame
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
#pragma mark -

@end

@implementation TapButton

-(void)layoutSubviews {
    [super layoutSubviews];
    // 获取文字的坐标+宽高
    CGSize titleSize = self.titleLabel.size;
    // 重新赋予文字宽度 **注** 有时系统会计算出错，和按钮的宽度有关 向上取整
    titleSize.width  = ceil([self getSpaceLabelHeight:self.titleLabel.text].width);
    titleSize.height = ceil([self getSpaceLabelHeight:self.titleLabel.text].height);
    self.titleLabel.size = titleSize;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    // 获取图片的左标 + 宽高
    CGSize imageSize = self.imageView.size;
    // 通过设置的偏移量 计算图片或者文字的x值
    CGFloat titleOrImageleft = (self.width - (titleSize.width + imageSize.width + _imageOffsetLeftOrRight + _imageTitleIsDistance)) / 2.0 + _titleOffsetLeftOrRight;
    
    // 获取图片和文字的总高加上距离 来设置顶部 底部 让图片和文字总体位于按钮中心
    NSInteger totalHeight = self.imageView.height + self.titleLabel.height + _imageTitleIsDistance;
    // 图片or文字 顶部or底部
    CGFloat topOrBottom = (self.height - totalHeight) * .5;
    
    
    switch (self.controlsType) {
        case TitleImageDefault: // 不做任何操作 保持系统原样
            break;
        case TitleIsLeftImageIsRight: // 标题左 图片右
        {
            self.titleLabel.left = titleOrImageleft + _titleOffsetLeftOrRight;
            // 图片的x值为 同上
            self.imageView.left  = self.titleLabel.right + _imageOffsetLeftOrRight + _titleOffsetLeftOrRight + _imageTitleIsDistance;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;
        }
            break;
        case TitleIsRightImageIsLeft: // 标题右 图片左
        {
            self.imageView.left = titleOrImageleft + _imageOffsetLeftOrRight;
            // 文字的x值为 图片的最右边+文字图片间距+文字的偏移量+图片的偏移量
            self.titleLabel.left  = self.imageView.right + _imageOffsetLeftOrRight + _titleOffsetLeftOrRight + _imageTitleIsDistance;
            // 图片和文字的上下位置 默认居中(有偏移量 根据偏移量改变位置)
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;
        }
            break;
        case TitleIsTopImageIsBottom: // 标题上 图片下
        {
            self.titleLabel.top = topOrBottom + _titleOffsetTopOrBottom;
            self.imageView.top = self.titleLabel.bottom + _imageOffsetTopOrBottom +_imageTitleIsDistance;
            // 图片和文字的中心位置 同上
            self.titleLabel.centerX = self.middleX + _titleOffsetLeftOrRight;
            self.imageView.centerX = self.middleX + _imageOffsetLeftOrRight;
        }
            break;
        case TitleIsBottomImageIsTop: // 标题下 图片上
        {
            self.imageView.top = topOrBottom + _imageOffsetTopOrBottom;
            self.titleLabel.top = self.imageView.bottom + _titleOffsetTopOrBottom +_imageTitleIsDistance;
            // 图片和文字的中心位置 同上
            self.titleLabel.centerX = self.middleX + _titleOffsetLeftOrRight;
            self.imageView.centerX = self.middleX + _imageOffsetLeftOrRight;
            
        }
            break;
        case TitleBestLeftImageBestRight: // 标题在最左 图片在最右
        {
            // 文字在最左
            self.titleLabel.left = _titleOffsetLeftOrRight;
            // 图片在最右
            self.imageView.right  = self.width + _imageOffsetLeftOrRight;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;

        }
            break;
        case TitleBestRightImageBestLeft: // 标题在最右 图片在最左
        {
            // 图片在最左
            self.imageView.left  = _imageOffsetLeftOrRight;
            // 文字在最右
            self.titleLabel.right = self.width + _titleOffsetLeftOrRight;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;
        }
            break;
        case TitleImageBestLeft: // 标题->图片 最左
        {
            // 标题、图片 在最左顺序排列
            self.titleLabel.left = _titleOffsetLeftOrRight;
            self.imageView.left = self.titleLabel.right + _imageOffsetLeftOrRight + _imageTitleIsDistance;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;

        }
            break;
        case TitleImageBestRight: // 标题->图片 最右
        {
            // 标题、图片 在最右顺序排列
            self.imageView.right = self.width + _imageOffsetLeftOrRight;
            self.titleLabel.right = self.imageView.left + _titleOffsetLeftOrRight - _imageTitleIsDistance;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;
        }
            break;
        case ImageTitleBestLeft: // 图片->标题 最左
        {
            // 图片、标题 在最左顺序排列
            self.imageView.left = _imageOffsetLeftOrRight;
            self.titleLabel.left = self.imageView.right + _titleOffsetLeftOrRight + _imageTitleIsDistance;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;
        }
            break;
        case ImageTitleBestRight: // 图片->标题 最右
        {
            // 图片、标题 在最右顺序排列
            self.titleLabel.right = self.width + _titleOffsetLeftOrRight;
            self.imageView.right = self.titleLabel.left + _imageOffsetLeftOrRight - _imageTitleIsDistance;
            // 图片和文字的上下位置 同上
            self.titleLabel.centerY = self.middleY + _titleOffsetTopOrBottom;
            self.imageView.centerY  = self.middleY + _imageOffsetTopOrBottom;
        }
            break;
        case OnlyTitleIsCenter: // 标题居中
        {
            self.titleLabel.centerX = self.width * .5f;
            self.titleLabel.centerY = self.height * .5f;
            [self setImage:nil forState:(UIControlStateNormal)];
            self.imageView.hidden = true;
        }
            break;
        case OnlyImageIsCenter: // 图片居中
        {
            self.imageView.centerX = self.width * .5f;
            self.imageView.centerY = self.height * .5f;
            [self setTitle:@"" forState:(UIControlStateNormal)];
            self.titleLabel.hidden = true;
        }
            break;
        default:
            break;
    }
    
    // titleLabel的宽度不能大于button和image宽度的差值
    if (self.controlsType != TitleIsTopImageIsBottom && self.controlsType != TitleIsBottomImageIsTop) {
        if (self.titleLabel.width > self.width - self.imageView.width - self.imageTitleIsDistance - self.titleOffsetLeftOrRight - self.imageOffsetLeftOrRight) {
            
            self.titleLabel.width = self.width - self.imageView.width - self.titleOffsetLeftOrRight - self.imageOffsetLeftOrRight;
        }
        
    }else{
        if (self.titleLabel.width > self.width - self.titleOffsetLeftOrRight) {
            self.titleLabel.width = self.width - self.titleOffsetLeftOrRight;
        }
        
    }

}

- (void)setControlsType:(ControlsType)controlsType
{
    _controlsType = controlsType;
}

- (void)setImageTitleIsDistance:(CGFloat)imageTitleIsDistance
{
    _imageTitleIsDistance = imageTitleIsDistance;
}

- (void)setImageOffsetLeftOrRight:(CGFloat)imageOffsetLeftOrRight
{
    _imageOffsetLeftOrRight = imageOffsetLeftOrRight;
}

- (void)setImageOffsetTopOrBottom:(CGFloat)imageOffsetTopOrBottom
{
    _imageOffsetTopOrBottom = imageOffsetTopOrBottom;
}

- (void)setTitleOffsetLeftOrRight:(CGFloat)titleOffsetLeftOrRight
{
    _titleOffsetLeftOrRight = titleOffsetLeftOrRight;
}

- (void)setTitleOffsetTopOrBottom:(CGFloat)titleOffsetTopOrBottom
{
    _titleOffsetTopOrBottom = titleOffsetTopOrBottom;
}

- (void)setCloseBlowUpHotSpots:(BOOL)closeBlowUpHotSpots
{
    _closeBlowUpHotSpots = closeBlowUpHotSpots;
}

static const char BLOCKKEY;
- (void)addTapBlock:(HanderBlock)block
{
    objc_setAssociatedObject(self, &BLOCKKEY, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonAction:(TapButton *)button
{
    HanderBlock block = objc_getAssociatedObject(self, &BLOCKKEY);
    !block ? nil : block(self);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    if (!_closeBlowUpHotSpots) {
        //若原热区小于44x44，则放大热区，否则保持原大小不变
        CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
        CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
        bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    }
    return CGRectContainsPoint(bounds, point);
}

-(CGSize)getSpaceLabelHeight:(NSString*)str{
    NSDictionary *dic = @{NSFontAttributeName:self.titleLabel.font};
    CGSize size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size;
}

@end
