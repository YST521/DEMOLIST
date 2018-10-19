//
//  MOdalPopController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/17.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "MOdalPopController.h"

@interface MOdalPopController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *tabView;
}

@end

@implementation MOdalPopController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //默认选中某一行
//    [tabView reloadData];
//    NSIndexPath *ip=[NSIndexPath  indexPathWithIndex:self.selectRow];
//    [tabView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
//    NSIndexPath * selIndex = [NSIndexPath indexPathForRow:1 inSection:0];
//    [tabView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
//    NSIndexPath * path = [NSIndexPath indexPathForItem:1 inSection:0];
//    [self tableView:tabView didSelectRowAtIndexPath:path];
    
    // 默认选中某一行
// NSIndexPath * selIndex = [NSIndexPath indexPathForRow:self.selectRow inSection:0];
// [tabView selectRowAtIndexPath:selIndex animated:YES scrollPosition:UITableViewScrollPositionTop];
//
// NSIndexPath * path = [NSIndexPath indexPathForItem:1 inSection:0];
//    [self tableView:tabView didSelectRowAtIndexPath:path];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    

    
}
-(void)select{
    
    // 方法一
    // 默认选中行，放在 reloadData 后
//
//    NSIndexPath *ip=[NSIndexPath indexPathForRow:0 inSection:0];
//    [tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionBottom];

//
//    // 方法二:
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    if ([myTableView.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
//        [myTableView.delegate tableView:self.tableView willSelectRowAtIndexPath:indexPath];
//    }
//
//    [myTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition: UITableViewScrollPositionNone];
//    if ([myTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//        [myTableView.delegate tableView:self.tableView didSelectRowAtIndexPath:indexPath];
//    }
  
}

-(void)creatUI{
   tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HIGHT-300, SCREEN_WIDTH, 300) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
 
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   NSString *selStr =   [NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    self.passBlock(selStr);
    
    [self cancelDismiss];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
    [self cancelDismiss];
    
}
-(void)cancelDismiss{
    CATransition *animation = [CATransition animation];
    animation.duration = 0.3;
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromTop;
    [self.view.window.layer addAnimation:animation forKey:nil];
    [self dismissViewControllerAnimated:NO completion:0];
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
