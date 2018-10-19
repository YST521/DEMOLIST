//
//  NetWorkPopView.m
//  cellAnimation
//
//  Created by youxin on 2018/10/11.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "NetWorkPopView.h"

@implementation NetWorkPopView


-(instancetype)initTitleStr:(NSString *)networkTypeStr{
    
    if (self = [super init]) {
        
        [self removeFromSuperview];
        
        self.bgV = [[UIView alloc]init];
        self.bgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
        [self add];
   
        self.alreLa = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,  [UIScreen mainScreen].bounds.size.width, 60)];
        [self.bgV addSubview:self.alreLa];
        self.alreLa.textAlignment = NSTextAlignmentCenter;
        self.alreLa.text = self.typeStr;
        self.alreLa.textColor = [UIColor redColor];
        self.alreLa.font = [UIFont boldSystemFontOfSize:20];
        self.alreLa.backgroundColor =[UIColor blackColor];
        self.alreLa.hidden = NO;
    }
    return self;
}

-(void)popShow{
 
    
    self.alreLa.text = self.typeStr;
    [UIView animateWithDuration:1.5 animations:^{
          self.bgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60);
          self.bgV.backgroundColor =[UIColor blackColor];
    }];
    //当没有网络 转换到有网络1.5秒后隐藏
    if( ![self.typeStr isEqualToString:@"无网络"] ){
        
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeView];
    });
        
    }
    
}

-(void)popCancel{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        [UIView animateWithDuration:0.3 animations:^{
//            self.bgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
//        }];
////
//    });
   [self removeView];
}
-(void)add{
    
         [[UIApplication sharedApplication].keyWindow addSubview:self.bgV];
//    [self popShow];
//    [self addSubview:self.bgV];
}
-(void)removeView{
     [self endEditing:YES];
    

        self.bgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
        [self.bgV removeFromSuperview];
        self.alpha = 0.0;
        self.bgV.alpha = 0;
        self.alreLa.alpha = 0;
        self.alreLa.hidden = YES;
        [self removeFromSuperview];


//    [UIView animateWithDuration:0.5 animations:^{
//
////        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
//        self.bgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
//        self.alpha = 0.0;
//        self.bgV.alpha = 0;
//        self.alreLa.alpha = 0;
//
//    } completion:^(BOOL finished) {
//        self.bgV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
//        [self.bgV removeFromSuperview];
//        self.alpha = 0.0;
//        self.bgV.alpha = 0;
//          self.alreLa.alpha = 0;
//        self.alreLa.hidden = YES;
//        [self removeFromSuperview];
//
//    }];
}

@end
