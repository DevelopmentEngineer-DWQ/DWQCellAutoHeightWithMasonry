# DWQCellAutoHeightWithMasonry
Masonry布局的强大助手，自动计算UITableViewCell的高度
![DWQ-LOGO.jpeg](http://upload-images.jianshu.io/upload_images/2231137-283064a77cffaf1a.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

##使用方法
1.将DWQCellAutoHeightWithMasonry文件夹拖入工程中，然后在PCH文件中引入头文件，或者在需要的Controller中引入头文件''UITableViewCell+DWQCellAutoHeightWithMasonry.h''

2.在自定义的Cell.h文件中声明两个属性，最后一个UIview控件dwq_lastViewInCell，和距离最后一个控件的高度 dwq_bottomOffsetToCell，示例代码如下
```objective-c
#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *pic;
@property (nonatomic,strong) UILabel *name;
@property (nonatomic,strong) UILabel *JS;
@property (nonatomic,strong) UILabel *GitHub;

@property (nonatomic, strong) UIView *dwq_lastViewInCell;//最后一个控件
@property (nonatomic,assign) CGFloat dwq_bottomOffsetToCell;//距离最后一个控件的高度
@end

```

3.然后在UITableview的返回行高的代理方法中调用  + (CGFloat)dwq_heightForIndexPath:(NSIndexPath *)indexPathconfig:(DWQCellBlock)config;示例代码如下：
```objective-c
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    
    //自动返回cell的高度
    return  [CustomTableViewCell dwq_heightForTableView:self.tableview config:^(UITableViewCell *sourceCell) {
        
        //由于数据源不同而每个cell高度又不同的需要在这里设置数据源，
        
        //[cellconfigCellWithModel:model];
    }];

}
```
