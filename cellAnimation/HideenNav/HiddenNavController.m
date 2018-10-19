//
//  HiddenNavController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/19.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "HiddenNavController.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50

@interface HiddenNavController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tabView;
}

@end

@implementation HiddenNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self creatUI];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    tabView.delegate = self;
    [self scrollViewDidScroll:tabView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    tabView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
}

-(void)creatUI{
    
  
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    imageV.image =[UIImage imageNamed:@"bg.jpg"];
    
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-0) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    tabView.tableFooterView = [[UIView alloc]init];
    tabView.tableHeaderView = imageV;
    if (@available(iOS 11.0, *)) {
        tabView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
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


@end
