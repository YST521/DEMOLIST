//
//  MOdalPopController.h
//  cellAnimation
//
//  Created by youxin on 2018/10/17.
//  Copyright © 2018年 yst. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^PassValueBlock)(NSString*str);

@interface MOdalPopController : UIViewController

@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)NSInteger selectRow;

@property(nonatomic,copy)PassValueBlock passBlock;

@end

NS_ASSUME_NONNULL_END
