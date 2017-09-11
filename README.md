# Custom-Button
基础控件button多个样式定制
一共含有13种不同的按钮类型，包括`@"默认", @"文字左图片右", @"文字右图片左", @"文字上图片下", @"文字下图片上", @"文字最左图片最右", @"文字最右图片最左", @"文字图片最左", @"文字图片最右", @"图片文字最左", @"图片文字最右", @"只有文字", @"只有图片"`

![样式](http://img0.ph.126.net/ZPWAufC_A4sRC0MSsSvmaQ==/6632640067326692922.png)
- - -
- 文件夹`TapButton`，导入导入头文件`#import "TapButton.h"`
- 创建按钮代码
```
    TapButton *btn1 = [[TapButton alloc]initWithFrame:frame];
    [btn1 setTitle:title forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor darkTextColor] forState:(UIControlStateNormal)];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setImage:[UIImage imageNamed:imageStr] forState:(UIControlStateNormal)];
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:12.f]];
    btn1.controlsType = type;// 按钮类型
    [self.view addSubview:btn1];
    [btn1 addTapBlock:^(TapButton *sender) {
      // 点击事件block    
    }];

```
- 还有一部分图片文字的偏移量，可在Tapbutton.h文件中查询
