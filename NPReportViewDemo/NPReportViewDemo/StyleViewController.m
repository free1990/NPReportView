//
//  StyleViewController.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/20.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "StyleViewController.h"
#import "NPReport.h"

@interface StyleViewController () <NPReportViewDatasource>

@end

@implementation StyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    style.stripeBackgroundColor = [UIColor colorWithWhite:0.85 alpha:1.f];
    style.stripeTextColor = [UIColor whiteColor];
    NPReportView *reportView = [[NPReportView alloc] initWithFrame:CGRectMake(16.f, 80.f, 320.f - 16.f * 2, 320)];
    reportView.style = style;
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
