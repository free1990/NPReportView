//
//  AutoFitViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/24.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "AutoFitViewController.h"
#import "NPReport.h"

@interface AutoFitViewController () <NPReportViewDatasource>

@end

@implementation AutoFitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 360)];
    reportView.datasource = self;
    reportView.style.autoFitHeight = YES;
    [self.view addSubview:reportView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource

- (NSInteger)numberOfRowsInReportView:(NPReportView *)tableView {
    return 5;
}

- (NSInteger)numberOfColsInReportView:(NPReportView *)tableView {
    return 5;
}

- (NPReportGrid *)reportView:(NPReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    NPReportGrid *grid = [NPReportGrid new];
    NSString *text = [NSString stringWithFormat:@"第%ld行第%ld列", indexPath.row, indexPath.col];
    if (indexPath.col == 0) {
        NSMutableString *mutableString = [text mutableCopy];
        NSInteger i = 0;
        while (i < indexPath.row) {
            [mutableString appendString:text];
            i ++;
        }
        text = [mutableString copy];
    }
    grid.text = text;
    grid.indexPath = indexPath;
    return grid;
}

@end
