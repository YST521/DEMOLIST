//
//  DrawController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/17.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "DrawController.h"
#import "DrawView.h"

@interface DrawController ()
//@property(nonatomic,strong)DrawView *drawV;
@end

@implementation DrawController
//-(DrawView *)drawV{
//    if (!_drawV) {
//        _drawV = [[DrawView alloc]init];
//    }
//    return _drawV;
//}
//-(void)loadView{
//    [super loadView];
//    self.drawV.frame = self.view.bounds;
//    self.view = self.drawV;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DrawView *drawV = [[DrawView alloc]init];
    drawV.frame = self.view.bounds;
    [self.view addSubview:drawV];
    
    self.view.backgroundColor =[UIColor whiteColor];
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
