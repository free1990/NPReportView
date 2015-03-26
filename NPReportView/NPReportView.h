
#import <UIKit/UIKit.h>

@class NPReportView;
@class NPReportGrid;
@class NPReportLabel;
@class NPReportStyle;

typedef NS_ENUM(NSInteger, NPReportOrder) {
    NPReportOrderedAscending = -1,
    NPReportOrderedNature,
    NPReportOrderedDescending
};

@protocol NPReportViewDatasource <NSObject>

@required
- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView;
- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView;
- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfHeadRowsInReportView:(NPReportView *)reportView; // 表头行数，默认为1
- (CGFloat)reportView:(NPReportView *)reportView heightOfRow:(NSInteger)row; // 某一行的高度，如果未实现则取style中的heightOfHeaderRow/heightOfRow的值
- (CGFloat)reportView:(NPReportView *)reportView widthOfCol:(NSInteger)col; // 某一列的宽度，如果未实现则取style中的widthOfFirstCol/widthOfCol的值

@end

@protocol NPReportViewDelegate <NSObject>

@optional
- (void)reportView:(NPReportView *)reportView didTapLabel:(NPReportLabel *)label;
- (void)reportView:(NPReportView *)reportView didLongPressLabel:(NPReportLabel *)label;
- (NSOrderedSet *)reportView:(NPReportView *)reportView indexesSortedByCol:(NSInteger)col order:(NPReportOrder)order;

@end

@interface NPReportView : UIView

@property (nonatomic, weak) id<NPReportViewDatasource> datasource;
@property (nonatomic, weak) id<NPReportViewDelegate> delegate;

@property (nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, readonly) UILongPressGestureRecognizer *longPressGestureRecognizer; // 默认minimumPressDuration = 1.0。

@property (nonatomic, strong) NPReportStyle *style; // 报表整体风格样式，在报表已加载过的情况下(didMoveToSuperview)，需要调用手动reloadData来刷新样式。

@property (nonatomic, assign) NSInteger sortedCol;
@property (nonatomic, assign) NPReportOrder sortedOrder;

- (instancetype)initWithFrame:(CGRect)frame; // 在frame.size.width/height == 0 时候，会自动拉伸至内容所需宽度/长度
- (void)reloadData;
- (void)sortByCol:(NSInteger)col order:(NPReportOrder)order;

- (NSInteger)numberOfRows;
- (NSInteger)numberOfCols;
- (NSInteger)numberOfHeadRows;
- (NPReportGrid *)gridAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightOfRow:(NSInteger)row;
- (CGFloat)widthOfCol:(NSInteger)col;

@end
