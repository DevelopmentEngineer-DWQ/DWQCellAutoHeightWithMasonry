//
//  CustomTableViewCell.m
//  DWQCellAutoHeightWithMasonry
//
//  Created by 杜文全 on 15/7/22.
//  Copyright © 2015年 com.iosDeveloper.duwenquan. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"
@implementation CustomTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    [self.contentView addSubview:self.pic];
    self.pic.frame=CGRectMake(10, 10, 80, 80);
    
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.JS];
    [self.contentView addSubview: self.GitHub];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(self.pic.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.pic);
        make.height.mas_equalTo(20);
        
    }];
    
    [self.JS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.name);
        make.right.mas_equalTo(self.name);
        make.top.mas_equalTo(self.name.mas_bottom);
        make.height.mas_equalTo(self.name);
    }];
    
    [self.GitHub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.JS );
        make.right.mas_equalTo(self.JS);
        make.top.mas_equalTo(self.JS.mas_bottom);
        make.height.mas_equalTo(self.JS);
    }];
    
    // 自动计算行高必须加上这句
    self.dwq_lastViewInCell = self.pic;//以头像为最后一个控件
    self.dwq_bottomOffsetToCell = 20;//距离头像这个控件的高度是20；

}
#pragma mark 懒加载
-(UIImageView *)pic{
    
    if(!_pic) {
        
        _pic =[[UIImageView alloc]init];
        
    }
    
    return _pic;
    
}
-(UILabel *)name{
    
    if(!_name) {
        
        _name =[[UILabel alloc]init];
        
    }
    
    return _name;
    
}
-(UILabel *)JS{
    
    if(!_JS) {
        
        _JS =[[UILabel alloc]init];
        
    }
    
    return _JS;
    
}
-(UILabel *)GitHub{
    
    if(!_GitHub) {
        
        _GitHub =[[UILabel alloc]init];
        
    }
    
    return _GitHub;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
