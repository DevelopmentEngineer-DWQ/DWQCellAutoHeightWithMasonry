//
//  UITableViewCell+DWQCellAutoHeightWithMasonry.m
//  DWQCellAutoHeightWithMasonry
//
//  Created by 杜文全 on 15/7/22.
//  Copyright © 2015年 com.iosDeveloper.duwenquan. All rights reserved.
//

#import "UITableViewCell+DWQCellAutoHeightWithMasonry.h"
#import <objc/runtime.h>
#import "UITableView+DWQCacheHeight.h"
NSString *const kDWQCacheUniqueKey = @"kDWQCacheUniqueKey";
NSString *const kDWQCacheStateKey = @"kDWQCacheStateKey";
NSString *const kDWQRecalculateForStateKey = @"kDWQRecalculateForStateKey";
NSString *const kDWQCacheForTableViewKey = @"kDWQCacheForTableViewKey";

const void *s_dwq_lastViewInCellKey = "dwq_lastViewInCellKey";
const void *s_dwq_bottomOffsetToCellKey = "dwq_bottomOffsetToCellKey";
@implementation UITableViewCell (DWQCellAutoHeightWithMasonry)

#pragma mark - Public
+ (CGFloat)dwq_heightForTableView:(UITableView *)tableView config:(DWQCellBlock)config {
    UITableViewCell *cell = [tableView.dwq_reuseCells objectForKey:[[self class] description]];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                           reuseIdentifier:nil];
        [tableView.dwq_reuseCells setObject:cell forKey:[[self class] description]];
    }
    
    if (config) {
        config(cell);
    }
    
    return [cell private_dwq_heightForTableView:tableView];
}

+ (CGFloat)dwq_heightForTableView:(UITableView *)tableView
                           config:(DWQCellBlock)config
                            cache:(DWQCacheHeight)cache {
    
    NSAssert(tableView, @"tableView is necessary param");
    
    if (cache) {
        NSDictionary *cacheKeys = cache();
        NSString *key = cacheKeys[kDWQCacheUniqueKey];
        NSString *stateKey = cacheKeys[kDWQCacheStateKey];
        NSString *shouldUpdate = cacheKeys[kDWQRecalculateForStateKey];
        
        NSMutableDictionary *stateDict = tableView.dwq_cacheCellHeightDict[key];
        NSString *cacheHeight = stateDict[stateKey];
        
        if (tableView.dwq_cacheCellHeightDict.count == 0
            || shouldUpdate.boolValue
            || cacheHeight == nil) {
            CGFloat height = [self dwq_heightForTableView:tableView config:config];
            
            if (stateDict == nil) {
                stateDict = [[NSMutableDictionary alloc] init];
                tableView.dwq_cacheCellHeightDict[key] = stateDict;
            }
            
            [stateDict setObject:[NSString stringWithFormat:@"%lf", height] forKey:stateKey];
            
            return height;
        } else if (tableView.dwq_cacheCellHeightDict.count != 0
                   && cacheHeight != nil
                   && cacheHeight.integerValue != 0) {
            return cacheHeight.floatValue;
        }
    }
    
    return [self dwq_heightForTableView:tableView config:config];
}

- (void)setDwq_lastViewInCell:(UIView *)dwq_lastViewInCell {
    objc_setAssociatedObject(self,
                             s_dwq_lastViewInCellKey,
                             dwq_lastViewInCell,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dwq_lastViewInCell {
    return objc_getAssociatedObject(self, s_dwq_lastViewInCellKey);
}

- (void)setDwq_lastViewsInCell:(NSArray *)dwq_lastViewsInCell {
    objc_setAssociatedObject(self,
                             @selector(dwq_lastViewsInCell),
                             dwq_lastViewsInCell,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSArray *)dwq_lastViewsInCell {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDwq_bottomOffsetToCell:(CGFloat)dwq_bottomOffsetToCell {
    objc_setAssociatedObject(self,
                             s_dwq_bottomOffsetToCellKey,
                             @(dwq_bottomOffsetToCell),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)dwq_bottomOffsetToCell {
    NSNumber *valueObject = objc_getAssociatedObject(self, s_dwq_bottomOffsetToCellKey);
    
    if ([valueObject respondsToSelector:@selector(floatValue)]) {
        return valueObject.floatValue;
    }
    
    return 0.0;
}

#pragma mark - Private
- (CGFloat)private_dwq_heightForTableView:(UITableView *)tableView {
    //    NSAssert(self.dwq_lastViewInCell != nil
    //             || self.dwq_lastViewsInCell.count != 0,
    //             @"您未指定cell排列中最后的视图对象，无法计算cell的高度");
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    
    CGFloat rowHeight = 0.0;
    
    for (UIView *bottomView in self.contentView.subviews) {
        if (rowHeight < CGRectGetMaxY(bottomView.frame)) {
            rowHeight = CGRectGetMaxY(bottomView.frame);
        }
    }
    
    //    if (self.dwq_lastViewInCell) {
    //        rowHeight = self.dwq_lastViewInCell.frame.size.height + self.dwq_lastViewInCell.frame.origin.y;
    //    } else {
    //        for (UIView *view in self.dwq_lastViewsInCell) {
    //            if (rowHeight < CGRectGetMaxY(view.frame)) {
    //                rowHeight = CGRectGetMaxY(view.frame);
    //            }
    //        }
    //    }
    
    rowHeight += self.dwq_bottomOffsetToCell;
    
    return rowHeight;
}


@end
