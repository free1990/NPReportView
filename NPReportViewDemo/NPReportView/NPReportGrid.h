//
//  NPReportGrid.h
//  NPReportView
//
//  Created by Chenly on 15/2/27.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPReportGrid : NSObject

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@property (nonatomic, readonly) BOOL isTextAlignmentOriginal;
@property (nonatomic, assign) BOOL underline;
@property (nonatomic, assign) NSInteger rowspan;
@property (nonatomic, assign) NSInteger colspan;
@property (nonatomic, strong) UIImage *image;
@end
