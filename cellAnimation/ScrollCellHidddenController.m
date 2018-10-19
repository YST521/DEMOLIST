//
//  ScrollCellHidddenController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/19.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "ScrollCellHidddenController.h"
#import "UINavigationBar+ChangeColor.h"

@interface ScrollCellHidddenController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tabView;
}

@end

@implementation ScrollCellHidddenController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
   
    
    [self.navigationController.navigationBar start];
    
    //该页面呈现时手动调用计算导航栏此时应当显示的颜色
    
  [self scrollViewDidScroll:tabView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        tabView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self creatUI];
}

/* 页面即将消失 */

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
 
[self.navigationController.navigationBar reset];
    
}

/* 滑动过程中做处理 */

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
  [self.navigationController.navigationBar changeColor:[UIColor redColor] withOffsetY:scrollView.contentOffset.y];
    
}



 -(void)creatUI{
     
     tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:(UITableViewStylePlain)];
     [self.view addSubview:tabView];
     tabView.delegate = self;
     tabView.dataSource = self;
     [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
     tabView.tableFooterView = [[UIView alloc]init];
   
    
 }

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"cells"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
