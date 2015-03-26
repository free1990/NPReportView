//
//  NSIndexPath+NPReport.m
//  NPReportViewDemo
//
//  Created by Chenly on 15/3/17.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "NSIndexPath+NPReport.h"

@implementation NSIndexPath (NPReport)

+ (NSIndexPath *)indexPathForCol:(NSInteger)col inRow:(NSInteger)row {
    return [NSIndexPath indexPathForRow:row inSection:col];
}

- (NSInteger)col {
    return self.section;
}

@end
