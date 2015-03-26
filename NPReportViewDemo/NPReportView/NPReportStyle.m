//
//  NPReportStyle.m
//  NPReportView
//
//  Created by Chenly on 15/2/27.
//  Copyright (c) 2015年 Chenly. All rights reserved.
//

#import "NPReportStyle.h"

NSString *const NPRHeightOfHeaderRowSettingName = @"NPRHeightOfHeaderRow";
NSString *const NPRHeightOfRowSettingName = @"NPRHeightOfRow";
NSString *const NPRWidthOfFirstColSettingName = @"NPRWidthOfFirstCol";
NSString *const NPRWidthOfColSettingName = @"NPRWidthOfCol";
NSString *const NPRAutoFitHeightSettingName = @"NPRAutoFitHeight";
NSString *const NPRBackgroundColorSettingName = @"NPRBackgroundColor";
NSString *const NPRBackgroundColorOfHeaderSettingName = @"NPRBackgroundColorOfHeader";
NSString *const NPRTextColorSettingName = @"NPRTextColor";
NSString *const NPRTextColorOfHeaderSettingName = @"NPRTextColorOfHeader";
NSString *const NPRFontSettingName = @"NPRFont";
NSString *const NPRFontOfHeaderSettingName = @"NPRFontOfHeader";
NSString *const NPRTextAlignmentSettingName = @"NPRTextAlignment";
NSString *const NPRTextAlignmentOfHeaderSettingName = @"NPRTextAlignmentOfHeader";
NSString *const NPRSpacingSettingName = @"NPRSpacing";
NSString *const NPRBorderColorSettingName = @"NPRBorderColor";
NSString *const NPRBorderInsetsSettingName = @"NPRBorderInsets";
NSString *const NPRTrimWidthSpaceSettingName = @"NPRTrimWidthSpace";
NSString *const NPRTrimHeightSpaceSettingName = @"NPRTrimHeightSpace";
NSString *const NPRStripeBackgroundColorSettingName = @"NPRStripeBackgroundColor";
NSString *const NPRStripeTextColorSettingName = @"NPRStripeTextColor";

@implementation NPReportStyle
{
    BOOL _isTextAlignmentOfHeaderOrigin;
}

@synthesize textAlignmentOfHeader = _textAlignmentOfHeader;

- (instancetype)init {
    return [self initWithSettings:nil];
}

- (instancetype)initWithSettings:(NSDictionary *)settings {
    if (self = [super init]) {
        _heightOfHeaderRow = 0.f;
        _heightOfRow = 0.f;
        _widthOfFirstCol = 0.f;
        _widthOfCol = 0.f;
        _backgroundColor = [UIColor whiteColor];
        _backgroundColorOfHeader = nil;
        _textColor = [UIColor blackColor];
        _textColorOfHeader = nil;
        _font = [UIFont systemFontOfSize:17.f];
        _fontOfHeader = nil;
        _textAlignment = NSTextAlignmentCenter;
        _isTextAlignmentOfHeaderOrigin = YES;
        _spacing = 1.f;
        _borderColor = [UIColor grayColor];
        _borderInsets = UIEdgeInsetsMake(1.f, 1.f, 1.f, 1.f);
        _trimWidthSpace = YES;
        _trimHeightSpace = YES;
        _stripeBackgroundColor = nil;
        _stripeTextColor = nil;
        
        if (settings) {
            id obj;
            if ((obj = [settings objectForKey:NPRHeightOfHeaderRowSettingName])) _heightOfHeaderRow = [obj floatValue];
            if ((obj = [settings objectForKey:NPRHeightOfRowSettingName])) _heightOfRow = [obj floatValue];
            if ((obj = [settings objectForKey:NPRWidthOfFirstColSettingName])) _widthOfFirstCol = [obj floatValue];
            if ((obj = [settings objectForKey:NPRWidthOfColSettingName])) _widthOfCol = [obj floatValue];
            if ((obj = [settings objectForKey:NPRAutoFitHeightSettingName])) _autoFitHeight = [obj boolValue];
            if ((obj = [settings objectForKey:NPRBackgroundColorSettingName])) _backgroundColor = obj;
            if ((obj = [settings objectForKey:NPRBackgroundColorOfHeaderSettingName])) _backgroundColorOfHeader = obj;
            if ((obj = [settings objectForKey:NPRTextColorSettingName])) _textColor = obj;
            if ((obj = [settings objectForKey:NPRTextColorOfHeaderSettingName])) _textColorOfHeader = obj;
            if ((obj = [settings objectForKey:NPRFontSettingName])) _font = obj;
            if ((obj = [settings objectForKey:NPRFontOfHeaderSettingName])) _fontOfHeader = obj;
            if ((obj = [settings objectForKey:NPRTextAlignmentSettingName])) _textAlignment = [obj integerValue];
            if ((obj = [settings objectForKey:NPRTextAlignmentOfHeaderSettingName])) self.textAlignmentOfHeader = [obj floatValue];
            if ((obj = [settings objectForKey:NPRSpacingSettingName])) _spacing = [obj floatValue];
            if ((obj = [settings objectForKey:NPRBorderColorSettingName])) _borderColor = obj;
            if ((obj = [settings objectForKey:NPRBorderInsetsSettingName])) _borderInsets = [obj UIEdgeInsetsValue];
            if ((obj = [settings objectForKey:NPRTrimWidthSpaceSettingName])) _trimWidthSpace = [obj boolValue];
            if ((obj = [settings objectForKey:NPRTrimHeightSpaceSettingName])) _trimHeightSpace = [obj boolValue];
            if ((obj = [settings objectForKey:NPRStripeBackgroundColorSettingName])) _stripeBackgroundColor = obj;
            if ((obj = [settings objectForKey:NPRStripeTextColorSettingName])) _stripeTextColor = obj;
        }
    }
    return self;
}

+ (instancetype)defaultStyle {
    NSDictionary *settings = @{
                               NPRBackgroundColorOfHeaderSettingName: [UIColor colorWithRed:61/255.f green:178/255.f blue:161/255.f alpha:1.f],
                               NPRBorderColorSettingName: [UIColor colorWithRed:59/255.f green:165/255.f blue:153/255.f alpha:1.f],
                               NPRHeightOfHeaderRowSettingName: @30.f,
                               NPRHeightOfRowSettingName: @20.f,
                               NPRWidthOfFirstColSettingName: @80.f,
                               NPRWidthOfColSettingName: @60.f,
                               NPRFontOfHeaderSettingName: [UIFont systemFontOfSize:15.f],
                               NPRFontSettingName: [UIFont systemFontOfSize:15.f],
                               NPRTextColorSettingName: [UIColor blackColor],
                               NPRTextColorOfHeaderSettingName: [UIColor whiteColor],
                               };
    return [NPReportStyle styleWithSettings:settings];
}

+ (instancetype)styleWithSettings:(NSDictionary *)settings {
    return [[NPReportStyle alloc] initWithSettings:settings];
}

- (UIColor *)backgroundOfHeader {
    return _backgroundColorOfHeader ?: _backgroundColor;
}

- (void)setTextAlignmentOfHeader:(NSTextAlignment)textAlignmentOfHeader {
    _textAlignmentOfHeader = textAlignmentOfHeader;
    _isTextAlignmentOfHeaderOrigin = NO;
}

- (NSTextAlignment)textAlignmentOfHeader {
    return _isTextAlignmentOfHeaderOrigin ? _textAlignment : _textAlignmentOfHeader;
}

- (UIFont *)fontOfHeader {
    return _fontOfHeader ?: _font;
}

- (UIColor *)textColorOfHeader {
    return _textColorOfHeader ?: _textColor;
}

- (CGFloat)widthOfFirstCol {
    return _widthOfFirstCol > 0 ? _widthOfFirstCol : _widthOfCol;
}

- (CGFloat)heightOfHeaderRow {
    return _heightOfHeaderRow > 0 ? _heightOfHeaderRow : _heightOfRow;
}

@end