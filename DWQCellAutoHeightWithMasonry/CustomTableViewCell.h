//
//  CustomTableViewCell.h
//  DWQCellAutoHeightWithMasonry
//
//  Created by 杜文全 on 15/7/22.
//  Copyright © 2015年 com.iosDeveloper.duwenquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *pic;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *JS;
@property (nonatomic,strong) UILabel *GitHub;

@property (nonatomic, strong) UIView *dwq_lastViewInCell;//最后一个控件

@property (nonatomic,assign) CGFloat dwq_bottomOffsetToCell;//距离最后一个控件的高度
@end
