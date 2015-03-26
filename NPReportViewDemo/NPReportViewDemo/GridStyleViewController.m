//
//  GridStyleViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/23.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "GridStyleViewController.h"
#import "NPReport.h"

@interface GridStyleViewController () <NPReportViewDatasource>

@end

@implementation GridStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 320)];
    reportView.datasource = self;
    reportView.style.widthOfFirstCol = 70.f;
    reportView.style.widthOfCol = 71.f;
    reportView.style.heightOfHeaderRow = 70.f;
    reportView.style.heightOfRow = 70.f;
    [self.view addSubview:reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource

- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView {
    return 4;
}

- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView {
    return 4;
}

- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    NPReportGrid *grid = [NPReportGrid new];
    // 奇偶行背景色
    if (indexPath.row % 2 == 0) {
        grid.backgroundColor = [UIColor colorWithRed:51/255.f green:102/255.f blue:153/255.f alpha:1.f];
    }
    else {
        grid.backgroundColor = [UIColor colorWithRed:153/255.f green:102/255.f blue:51/255.f alpha:1.f];
    }
    // 奇偶列字体色
    if (indexPath.col % 2 == 0) {
        grid.textColor = [UIColor colorWithRed:255/255.f green:204/255.f blue:170/255.f alpha:1.f];
    }
    else {
        grid.textColor = [UIColor colorWithRed:170/255.f green:204/255.f blue:204/255.f alpha:1.f];
    }
    // 行索引和列索引相等的单元格字体为20号粗体
    if (indexPath.row == indexPath.col) {
        grid.font = [UIFont boldSystemFontOfSize:20.f];
    }
    else {
        grid.font = [UIFont systemFontOfSize:11.f];
    }
    // 第一个单元格加下划线
    if (indexPath.row == 0 && indexPath.col == 0) {
        grid.underline = YES;
    }
    
    if (indexPath.row == 3 && indexPath.col == 0) {
        grid.image = [UIImage imageNamed:@"image0"];
    }
    else {
        grid.text = [NSString stringWithFormat:@"%ld/%ld", indexPath.row, indexPath.col];
    }
    grid.indexPath = indexPath;
    return grid;
}

@end
