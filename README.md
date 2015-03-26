
NPReportView是一个多功能的报表控件，基本满足报表需求。

## Features

- 支持跨行跨列的复合表头。
- 支持自定义风格样式。
- 支持响应点击和长按事件。
- 支持行高自适应。
- 支持排序功能。

##示例

![demo](https://github.com/NoResound/NPReportView/blob/master/demo.gif?raw=true)


## Requirements

- iOS 7.0+

## CocoaPods

```ruby
pod 'NPReportView', '~> 1.0.0'
```

## Usage

### 创建和初始化ReportView

```objc
NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 320)];
reportView.datasource = self;
[self.view addSubview:reportView];
```

### 数据源

```objc
- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView {
    return 20;
}

- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView {
    return 10;
}

- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    NPReportGrid *grid = [NPReportGrid new];
    grid.text = [NSString stringWithFormat:@"%ld/%ld", indexPath.row, indexPath.col];
    grid.indexPath = indexPath;
    return grid;
}
```

### 设置风格样式

```objc
	// 使用键值对初始化
    NPReportStyle *style = [NPReportStyle styleWithSettings:@{
                                                              NPRBackgroundColorOfHeaderSettingName: [UIColor colorWithRed:224/255.f green:237/255.f blue:250/255.f alpha:1.f],
                                                              NPRBorderColorSettingName: [UIColor colorWithRed:106/255.f green:145/255.f blue:170/255.f alpha:1.f],
                                                              NPRHeightOfHeaderRowSettingName: @30.f,
                                                              NPRHeightOfRowSettingName: @20.f,
                                                              NPRWidthOfFirstColSettingName: @80.f,
                                                              NPRWidthOfColSettingName: @60.f,
                                                              NPRFontSettingName: [UIFont systemFontOfSize:14.f],
                                                              NPRTextColorSettingName: [UIColor darkGrayColor],
                                                              NPRTextColorOfHeaderSettingName: [UIColor blueColor],
                                                              }];
    // 或者使用style的属性来设置                                                          
    style.stripeBackgroundColor = [UIColor colorWithWhite:0.85 alpha:1.f];
    style.stripeTextColor = [UIColor whiteColor];
    // 赋值给reportView
    reportView.style = style;
```

### 指定单元格设置

```objc
	// 针对特定某个单元格设置样式，不额外设置时使用style设置
    grid.backgroundColor = [UIColor lightGrayColor];
    grid.font = [UIFont boldSystemFontOfSize:20.f];
    grid.textColor = [UIColor redColor];
    grid.textAlignment = NSTextAlignmentLeft;
    grid.underline = YES;
    // 单元格设置跨行跨列，默认为1，表示不跨行
    grid.rowspan = 3;
    grid.colspan = 3;
```

### 响应点击或长按事件

#### 设置delegate

```objc
    reportView.delegate = self;
```

#### 实现delegate方法

```objc
- (void)reportView:(NPReportView *)reportView didTapLabel:(NPReportLabel *)label {
    // label为被点击的标签
}

- (void)reportView:(NPReportView *)reportView didLongPressLabel:(NPReportLabel *)label {
    // label为被长按的标签，默认长按响应时间为1s，可以通过修改reportView.longPressGestureRecognizer.minimumPressDuration来修改
}
```

### 自适应行高

当设置自适应行高时，如果文字内容超出该单元格所在行高度，则自动调整整行高度以适应内容（在单元格存在跨行情况时表现可能有问题）。
```objc
reportView.style.autoFitHeight = YES;
```

### 排序

```objc
	[reportView sortByCol:col order:NPReportOrderedDescending];
```

需要实现以下代理方法，提供排序依据

```objc
- (NSOrderedSet *)reportView:(NPReportView *)reportView indexesSortedByCol:(NSInteger)col order:(NPReportOrder)order {
   // 返回一个NSOrderedSet，里面按顺序存放行索引。
}
```
**排序功能仅针对简单表格（表头只有一行，没有跨行跨列情况）。**

