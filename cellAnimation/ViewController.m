//
//  ViewController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/10.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "ViewController.h"
#import "CellDelectController.h"
#import "CellAnimationController.h"
#import "NetWorkController.h"
#import "DelectCellController.h"
#import "MJExtensionYController.h"
#import "DrawController.h"
#import "MOdalPopController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tabView;
    
    
}
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSString *selectStr;
@end

@implementation ViewController

-(NSArray *)titleArr{
    
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleArr = @[@"cell动画",@"单行cell的动画",@"网络监听",@"侧滑删除",@"mjextension",@"draw",@"模态弹框"];
    self.navigationItem.title = @"cell的常见使用方法";
    
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    tabView.tableFooterView = [[UIView alloc]init];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"cells"];
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        CellAnimationController *VC = [[CellAnimationController alloc]init];
        VC.titleStr = self.titleArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 1) {
        CellDelectController *VC = [[CellDelectController alloc]init];
           VC.titleStr = self.titleArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.row == 2) {
        NetWorkController *VC = [[NetWorkController alloc]init];
           VC.titleStr = self.titleArr[indexPath.row];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.row == 3) {
        DelectCellController *VC = [[ DelectCellController alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.row == 4) {
       MJExtensionYController *VC = [[MJExtensionYController  alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
    if (indexPath.row == 5) {
        DrawController *VC = [[DrawController  alloc]init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    if (indexPath.row == 6) {
  
            MOdalPopController * popVC = [MOdalPopController new];
            popVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
            popVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            self.modalPresentationStyle = UIModalPresentationCurrentContext;
        NSMutableArray *arr = [NSMutableArray array];
        for(int i = 0;i<100;i++){
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        popVC.titleArr = (NSArray*)arr;
        popVC.selectRow = 2;
        
        popVC.passBlock = ^(NSString * _Nonnull str) {
            NSLog(@"-----%@",str);
            self.selectStr = str;
        };
        
        NSLog( @"====== %@", self.selectStr);
        
            [self presentAnimal]; //跳转动画
            [self.navigationController presentViewController:popVC animated:NO completion:nil];
       
     
    }
    
}
-(void)presentAnimal{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:0];
}
@end
