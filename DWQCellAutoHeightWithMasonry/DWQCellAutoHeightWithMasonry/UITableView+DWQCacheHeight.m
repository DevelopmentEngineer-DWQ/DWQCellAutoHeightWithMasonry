//
//  UITableView+DWQCacheHeight.m
//  DWQCellAutoHeightWithMasonry
//
//  Created by 杜文全 on 15/7/22.
//  Copyright © 2015年 com.iosDeveloper.duwenquan. All rights reserved.
//

#import "UITableView+DWQCacheHeight.h"
#import <objc/runtime.h>

static const void *__dwq_tableview_cacheCellHeightKey = "__dwq_tableview_cacheCellHeightKey";
static const void *__dwq_tableview_reuse_cells_key = "__dwq_tableview_reuse_cells_key";
@implementation UITableView (DWQCacheHeight)
- (NSMutableDictionary *)dwq_cacheCellHeightDict {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, __dwq_tableview_cacheCellHeightKey);
    
    if (dict == nil) {
        dict = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 __dwq_tableview_cacheCellHeightKey,
                                 dict,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return dict;
}

- (NSMutableDictionary *)dwq_reuseCells {
    NSMutableDictionary *cells = objc_getAssociatedObject(self, __dwq_tableview_reuse_cells_key);
    
    if (cells == nil) {
        cells = [[NSMutableDictionary alloc] init];
        
        objc_setAssociatedObject(self,
                                 __dwq_tableview_reuse_cells_key,
                                 cells,
                                 OBJC_ASSOCIATION_RETAIN);
    }
    
    return cells;
}

@end
