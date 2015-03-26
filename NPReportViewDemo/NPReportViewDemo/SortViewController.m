//
//  SortViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/24.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "SortViewController.h"
#import "NPReport.h"

@interface SortViewController () <NPReportViewDatasource, NPReportViewDelegate>
{
    NSMutableArray *_datas;
}
@end

@implementation SortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 320)];
    reportView.datasource = self;
    reportView.delegate = self;
    [self.view addSubview:reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    _datas = [NSMutableArray arrayWithCapacity:6];
    for (int row = 0; row < 6; row ++) {
        NSMutableArray *gridsOfRow = [NSMutableArray arrayWithCapacity:6];
        for (int col = 0; col < 6; col ++) {
            NPReportGrid *grid = [NPReportGrid new];
            if (row == 0) {
                grid.text = [NSString stringWithFormat:@"第%d列", col];
            }
            else {
                if (col == 0) {
                    grid.text = @(row).stringValue;
                }
                else {
                    grid.text = @(arc4random() % 1000).stringValue;
                }
            }
            grid.indexPath = [NSIndexPath indexPathForCol:col inRow:row];
            [gridsOfRow addObject:grid];
        }
        [_datas addObject:gridsOfRow];
    }
}

#pragma mark - datasource

- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView {
    return 6;
}

- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView {
    return 6;
}

- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    return _datas[indexPath.row][indexPath.col];
}

#pragma mark - delegate

- (NSOrderedSet *)reportView:(NPReportView *)reportView indexesSortedByCol:(NSInteger)col order:(NPReportOrder)order {
    NSMutableArray *gridsInCol = [NSMutableArray arrayWithCapacity:[reportView numberOfRows] - 1];
    NSInteger row = 1;
    while (row < [reportView numberOfRows]) {
        NPReportGrid *grid = [reportView gridAtIndexPath:[NSIndexPath indexPathForCol:col inRow:row]];
        [gridsInCol addObject:grid];
        row ++;
    }
    [gridsInCol sortUsingComparator:^NSComparisonResult(NPReportGrid *obj1, NPReportGrid *obj2) {
        if ([obj1.text integerValue] > [obj2.text integerValue]) {
            return NSOrderedDescending;
        }
        else
            return NSOrderedAscending;
    }];
    __block NSMutableOrderedSet *indexes = [[NSMutableOrderedSet alloc] init];
    [gridsInCol enumerateObjectsUsingBlock:^(NPReportGrid *obj, NSUInteger idx, BOOL *stop) {
        [indexes addObject:@(obj.indexPath.row)];
    }];
    if (order == NPReportOrderedDescending) {
        return [indexes reversedOrderedSet];
    }
    return [indexes copy];
}

- (void)reportView:(NPReportView *)reportView didTapLabel:(NPReportLabel *)label {
    if (label.indexPath.row == 0) {
        if (label.indexPath.col == reportView.sortedCol && reportView.sortedOrder != NPReportOrderedNature) {
            [reportView sortByCol:label.indexPath.col order:-(reportView.sortedOrder)];
        }
        else {
            [reportView sortByCol:label.indexPath.col order:NPReportOrderedDescending];
        }
    }
}

@end