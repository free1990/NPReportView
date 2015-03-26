//
//  SimpleViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/20.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "SimpleViewController.h"
#import "NPReport.h"

@interface SimpleViewController () <NPReportViewDatasource>

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 320)];
    reportView.datasource = self;
    [self.view addSubview:reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource

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

@end
