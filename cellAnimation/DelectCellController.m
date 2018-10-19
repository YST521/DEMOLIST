//
//  DelectCellController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/12.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "DelectCellController.h"

@interface DelectCellController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tabView;
    
}


@property(nonatomic,strong)NSMutableArray *titleArr;
@end

@implementation DelectCellController


-(NSMutableArray *)titleArr{
    
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.titleArr = @[@"cell动画",@"单行cell",@"网络监听",@"侧滑删除"];
    self.view.backgroundColor = [UIColor whiteColor];
       [self setTitleStr:self.titleStr];
    for(int i = 0;i<20;i++){
        
        [self.titleArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    tabView.tableFooterView = [[UIView alloc]init];
    
}

//设置cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;

}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {

    return NO;

}
// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (editingStyle ==UITableViewCellEditingStyleDelete) {

        // 1.调用接口，从服务器删除此条数据

        // 2.服务器删除成功，调用下面几行代码

        // 将此条数据从数组中移除，seld.array为存放列表数据的可变数组
        [self.titleArr removeObjectAtIndex:indexPath.row];
        NSLog(@"-----%ld---%lu",(long)indexPath.row,(unsigned long)self.titleArr.count);

        //再将此条cell从列表删除,_tableView为列表
        [tabView deleteRowsAtIndexPaths:              [NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

    }
    //记得刷新列表
    [tabView reloadData];

}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"cells"];
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}


@end
