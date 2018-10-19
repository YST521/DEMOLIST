//
//  CellDelectController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/10.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "CellDelectController.h"

@interface CellDelectController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tabView;
    NSMutableArray *dataArr;
    
}
@property(nonatomic,strong)NSMutableArray*titleArr;
@property(nonatomic,strong)NSMutableArray*titleArr2;
@property(nonatomic,strong)NSMutableArray*titleArr3;

@end

@implementation CellDelectController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitleStr:self.titleStr];
    [self creatData];
    [self creatUI];
    
}
-(void)creatUI{
    
    CGFloat hh = [UIScreen mainScreen].bounds.size.height;
    CGFloat ww = [UIScreen mainScreen].bounds.size.width;
    
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, ww, hh-80) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"celldelect"];
    tabView.tableFooterView = [[UIView alloc]init];
}

-(void)creatData{
    
    dataArr =[NSMutableArray array];
    self.titleArr = [NSMutableArray array];
    self.titleArr2 = [NSMutableArray array];
    self.titleArr3 = [NSMutableArray array];
    
    //测试数据不要 使用下面这种方式 会闪退
    //    self.titleArr = (NSMutableArray*)@[@"1",@"2",@"3",@"4",@"5"];
    
    for(int i = 0;i < 10 ;i++ ){
        [self.titleArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for(int i = 10;i < 20 ;i++ ){
        [self.titleArr2 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    for(int i = 20;i < 30 ;i++ ){
        [self.titleArr3 addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [dataArr addObject:self.titleArr];
    [dataArr addObject:self.titleArr2];
    [dataArr addObject:self.titleArr3];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
   
    UILabel *la = [[UILabel alloc]init];
    la.frame = CGRectMake(0, 0, self.view.frame.size.width, 40);
    la.backgroundColor =[UIColor lightGrayColor];
    if (section == 0) {
        la.text = @"  删除一行cell";
    } else if(section == 1) {
        la.text = @"  插入一行cell";
    }else{
        la.text = @"  移动一行cell一行cell";
    }
    
    return la;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
        NSArray *arr = dataArr[section];
        return arr.count;
    
   
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"celldelect"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"celldelect"];
//    }
      NSArray *arr = dataArr[indexPath.section];
 
     cell.textLabel.text = arr[indexPath.row];
 
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 //几种动画简介
//    typedef NS_ENUM(NSInteger, UITableViewRowAnimation) {
//        UITableViewRowAnimationFade,   //淡入淡出
//        UITableViewRowAnimationRight,  //从右滑入  // slide in from right (or out to right)
//        UITableViewRowAnimationLeft,   //从左滑入
//        UITableViewRowAnimationTop,        //从上滑入
//        UITableViewRowAnimationBottom,    //从下滑入
//        UITableViewRowAnimationNone,      // available in iOS 3.0
//        UITableViewRowAnimationMiddle,    // available in iOS 3.2.  attempts to keep cell centered in the space it will/did occupy
//        UITableViewRowAnimationAutomatic = 100  // available in iOS 5.0.  chooses an appropriate animation style for you
//    };
    
// 在真实项目中 需要进行数据的处理 然后处理UI 再刷新
  
     NSMutableArray *arr = dataArr[indexPath.section];
    if (indexPath.section == 0) {
    
       [arr removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
       [tableView endUpdates];
   

    }else if(indexPath.section == 1){

        [arr insertObject:@"666" atIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [tableView endUpdates];
       [arr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:2];
   
    }else{
//         NSMutableArray *arr = dataArr[2];
        //移动某行cell 到某个位置  这个地方真实场景在UI变化时 数据也需要变化并保存
        NSIndexPath *indexP =
        [NSIndexPath indexPathForRow:0 inSection:2]; //注意分区 此处不垮分区 跨分区 数据源用二维数组
        [tabView moveRowAtIndexPath:indexPath toIndexPath: indexP];
    }
}

@end
