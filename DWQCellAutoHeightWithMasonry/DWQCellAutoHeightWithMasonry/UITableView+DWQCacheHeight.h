//
//  UITableView+DWQCacheHeight.h
//  DWQCellAutoHeightWithMasonry
//
//  Created by 杜文全 on 15/7/22.
//  Copyright © 2015年 com.iosDeveloper.duwenquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DWQCacheHeight)
/**
 *	@author 杜文全, 15-07-22 16:04:23
 *
 *	用于缓存cell的行高
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *dwq_cacheCellHeightDict;

/**
 *	@author 杜文全, 15-07-22 16:08:08
 *
 *	用于获取或者添加计算行高的cell，因为理论上只有一个cell用来计算行高，以降低消耗
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *dwq_reuseCells;
@end
