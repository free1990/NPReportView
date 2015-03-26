//
//  HandleTouchViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/23.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "HandleTouchViewController.h"
#import "NPReport.h"

@interface HandleTouchViewController () <NPReportViewDatasource, NPReportViewDelegate>

@end

@implementation HandleTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 320)];
    reportView.datasource = self;
    reportView.delegate = self;
    reportView.style.heightOfHeaderRow = 0;
    reportView.style.heightOfRow = 44.f;
    [self.view addSubview:reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource

- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView {
    return 6;
}

- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView {
    return 6;
}

- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    NPReportGrid *grid = [NPReportGrid new];
    grid.text = [NSString stringWithFormat:@"%ld/%ld", indexPath.row, indexPath.col];
    grid.indexPath = indexPath;
    return grid;
}

#pragma mark - delegate

- (void)reportView:(NPReportView *)reportView didTapLabel:(NPReportLabel *)label {
    NSString *message = [NSString stringWithFormat:@"%ld/%ld", label.indexPath.row, label.indexPath.col];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"点击事件" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

- (void)reportView:(NPReportView *)reportView didLongPressLabel:(NPReportLabel *)label {
    NSString *message = [NSString stringWithFormat:@"%ld/%ld", label.indexPath.row, label.indexPath.col];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"长按事件" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
