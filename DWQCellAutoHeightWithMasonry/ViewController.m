//
//  ViewController.m
//  DWQCellAutoHeightWithMasonry
//
//  Created by 杜文全 on 15/7/22.
//  Copyright © 2015年 com.iosDeveloper.duwenquan. All rights reserved.
//
#define screen_Width [UIScreen mainScreen].bounds.size.width
#define screen_Height [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "UITableViewCell+DWQCellAutoHeightWithMasonry.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    /**
     *  基于Masonry自动布局实现的自动计算cell的行高扩展
     *
     *  @author 杜文全
     *  @email duwenquan0414@gmail.com
     *  @github https://github.com/DevelopmentEngineer-DWQ
     *  @blog   http://www.jianshu.com/u/725459648801
     *
     *  @link ：QQ:(439878592)
    
     */

}

-(void)createUI{

    self.view.backgroundColor=[UIColor whiteColor];
    self.tableview.frame=CGRectMake(0, 64, screen_Width, (screen_Height-64)/2+20);
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    
    [self.view addSubview:self.tableview];
    
    UILabel *tishi=[[UILabel alloc]initWithFrame:CGRectMake(0, (screen_Height-64)/2+50, screen_Width, 100)];
    tishi.textAlignment=NSTextAlignmentCenter;
    tishi.textColor=[UIColor redColor];
    tishi.text=@"欢迎关注本人的简书和GitHub,会分享一系列的各类封装和工具，记得在简书上给个好评，在GitHub上给个Star噢！！！！";
    tishi.numberOfLines=0;
    [self.view addSubview:tishi];

}
#pragma mark tableview代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 3;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *rid=@"cell";
    
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        
        cell.pic.image=[UIImage imageNamed:@"杜文全正式.jpeg"];
        cell.name.text=@"杜文全";
        cell.JS.text=@"简书：iOS攻城狮DWQ";
        cell.GitHub.text=@"GitHub：DevelopmentEngineer-DWQ";
        
    }
    
    return cell;


}
//返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //
    
    //自动返回cell的高度
    return  [CustomTableViewCell dwq_heightForTableView:self.tableview config:^(UITableViewCell *sourceCell) {
        
        //由于数据源不同而每个cell高度又不同的需要在这里设置数据源，
        
        //[cellconfigCellWithModel:model];
    }];

}

-(UITableView *)tableview{
    
    if(!_tableview) {
        
        _tableview =[[UITableView alloc]init];
        
    }
    
    return _tableview;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
