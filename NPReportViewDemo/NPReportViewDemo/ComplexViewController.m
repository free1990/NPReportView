//
//  ComplexViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/20.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "ComplexViewController.h"
#import "NPReport.h"

@interface ComplexViewController ()<NPReportViewDatasource>
{
    NPReportView *_reportView;
    NSArray *_datas;
    NSInteger _numberOfHeadRows;
}
@end

@implementation ComplexViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _reportView = [[NPReportView alloc] init];
    _reportView.datasource = self;
    [self.view addSubview:_reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGRect rect = self.view.bounds;
    rect.origin.x = 16.f;
    rect.origin.y = 80.f;
    rect.size.width = CGRectGetWidth(rect) - 16.f * 2;
    rect.size.height = CGRectGetHeight(rect) - (36.f + 20.f);
    _reportView.frame = rect;
    [_reportView setNeedsLayout];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

// 模拟获取数据的过程
- (void)loadData {
    NSString *jsonString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *jsonDatas = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    __block NSMutableArray *headers = [NSMutableArray array];
    NSArray *itemsOfHeader = jsonDatas[@"header"];
    NSMutableArray *gridsOfRow;
    for (NSDictionary *item in itemsOfHeader) {
        NPReportGrid *grid = [NPReportGrid new];
        NSInteger row = [item[@"rowId"] integerValue];
        NSInteger col = [item[@"colId"] integerValue];
        NSInteger rowspan = [item[@"rowSpan"] integerValue];
        NSInteger colspan = [item[@"colSpan"] integerValue];
        NSString *text = item[@"text"];
        grid.text = text;
        grid.indexPath = [NSIndexPath indexPathForCol:col inRow:row];
        grid.rowspan = rowspan;
        grid.colspan = colspan;
        if (row >= headers.count) {
            gridsOfRow = [NSMutableArray array];
            [headers addObject:gridsOfRow];
        }
        [gridsOfRow addObject:grid];
    }
    _numberOfHeadRows = headers.count;
    NSMutableArray *bodys = [NSMutableArray array];
    NSInteger row = _numberOfHeadRows;
    NSArray *itemsOfBody = jsonDatas[@"body"];
    for (NSArray *textsOfRow in itemsOfBody) {
        NSMutableArray *gridsOfRow = [NSMutableArray array];
        NSInteger col = 0;
        for (NSString *text in textsOfRow) {
            NPReportGrid *grid = [NPReportGrid new];
            grid.text = text;
            grid.indexPath = [NSIndexPath indexPathForCol:col inRow:row];
            [gridsOfRow addObject:grid];
            col ++;
        }
        [bodys addObject:gridsOfRow];
        row ++;
    }
    _datas = [headers arrayByAddingObjectsFromArray:bodys];
    [_reportView reloadData];
}

#pragma mark - datasource

- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView {
    return _datas.count;
}

- (NSInteger)numberOfHeadRowsInReportView:(NPReportView *)reportView {
    return _numberOfHeadRows;
}

- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView {
    return 6;
}

- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    for (NPReportGrid *grid in _datas[indexPath.row]) {
        if ([grid.indexPath isEqual:indexPath]) {
            return grid;
        }
    }
    return nil;
}

@end
