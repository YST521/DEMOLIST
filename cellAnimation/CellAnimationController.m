//
//  CellAnimationController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/11.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "CellAnimationController.h"

@interface CellAnimationController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *tabView;
    
}
@property(nonatomic,strong)NSMutableArray *titleArr;
@end

@implementation CellAnimationController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =[UIColor whiteColor];
       [self setTitleStr:self.titleStr];
    self.titleArr =  [NSMutableArray array];
    for(int i = 0;i<20;i++){
        
        [self.titleArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80) style:(UITableViewStylePlain)];
    [self.view addSubview:tabView];
    tabView.delegate = self;
    tabView.dataSource = self;
    [tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"animationCell"];
    tabView.tableFooterView = [[UIView alloc]init];
    
}

 //cell创建时 cell动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( (90.0*M_PI)/180, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/-600;
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    //3. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tabView dequeueReusableCellWithIdentifier:@"animationCell"];
    cell.textLabel.text = self.titleArr[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}

@end
