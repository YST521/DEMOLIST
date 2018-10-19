//
//  HIdeenNavigationController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/19.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "HIdeenNavigationController.h"

@interface HIdeenNavigationController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tabView;
    NSMutableArray * dataSource;    //数据源
    CGFloat beginContentY;          //开始滑动的位置
    CGFloat endContentY;            //结束滑动的位置
    CGFloat sectionHeaderHeight;    //section的header高度
}
@end

@implementation HIdeenNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
    sectionHeaderHeight = 40;
    
    dataSource = [[NSMutableArray alloc] init];
    for(int i=0;i<100;i++)
    {
        NSString * name = [NSString stringWithFormat:@"%d",i];
        [dataSource addObject:name];
    }
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
}

-(void)creatUI{
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    tabView.tableFooterView = [[UIView alloc]init];
    if (@available(iOS 11.0, *)) {
        tabView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"cells"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeaderHeight;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"this is a demo";
}

// 当开始滚动视图时，执行该方法。一次有效滑动（开始滑动，滑动一小段距离，只要手指不松开，只算一次滑动），只执行一次。
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //获取开始位置
    beginContentY = scrollView.contentOffset.y;
}

// 滑动scrollView，并且手指离开时执行。一次有效滑动，只执行一次。
// 当pagingEnabled属性为YES时，不调用，该方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //获取结束位置
    endContentY = scrollView.contentOffset.y;
    if(endContentY-beginContentY > 100)
    {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.navigationController.navigationBar.frame;
            rect.origin.y = -44;
            self.navigationController.navigationBar.frame = rect;
        }];
        sectionHeaderHeight = 0;
        [tabView reloadData];
    } else if(endContentY-beginContentY < -100)  {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect rect = self.navigationController.navigationBar.frame;
            rect.origin.y = 20;
            self.navigationController.navigationBar.frame = rect;
        } completion:^(BOOL finished) {
            sectionHeaderHeight = 40;
            [tabView reloadData];
        }];
    }
}

@end
