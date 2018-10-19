//
//  NetWorkPopView.h
//  cellAnimation
//
//  Created by youxin on 2018/10/11.
//  Copyright © 2018年 yst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkPopView : UIView

@property(nonatomic,strong)UIView *bgV;
@property(nonatomic,strong)UILabel *alreLa;

-(instancetype)initTitleStr:(NSString*)networkTypeStr;

@property(nonatomic,strong)NSString  *typeStr;//网络状态

-(void)popShow;
-(void)popCancel;
-(void)removeView;

@end

NS_ASSUME_NONNULL_END
