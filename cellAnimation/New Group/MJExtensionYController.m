//
//  MJExtensionYController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/15.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "MJExtensionYController.h"
#import "MJExtension.h"
#import "MJStatus.h"
#import "MJUser.h"
#import "MJStatusResult.h"
#import "MJAd.h"
#import "MJStudent.h"
#import "MJBag.h"

@interface MJExtensionYController (){
    MJStatusResult *result;
    MJStudent *stu;
    NSMutableArray *arr;
}

@end

@implementation MJExtensionYController

//MJ字典转模型
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    arr = [NSMutableArray array];
    [self test];
    [self test2];
    [self test3];
    
    MJStatus *statu =  [result.statuses firstObject];
    NSLog(@"%@ ==== %@=== %@",statu.text,statu.user.name,statu.user.icon );
    
    MJStudent * stu = [arr firstObject];
    NSLog(@"YYYYYY   ID=%@, desc=%@, otherName=%@, oldName=%@, nowName=%@, nameChangedTime=%@", stu.ID, stu.desc, stu.otherName, stu.oldName, stu.nowName, stu.nameChangedTime);
    NSLog(@"AA  bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
}

-(void)test3{
    // 1.定义一个字典数组
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png",
                               },
                           
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png",
                               }
                           ];
    
    // 2.将字典数组转为MJUser模型数组
    NSArray *userArray = [MJUser mj_objectArrayWithKeyValuesArray:dictArray];
    
    // 3.打印userArray数组中的MJUser模型属性
    for (MJUser *user in userArray) {
        MJExtensionLog(@"name=%@, icon=%@", user.name, user.icon);
    }
}


//多级嵌套 字典转模型
-(void)test2{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"id" : @"20",
                           @"desciption" : @"好孩子",
                           @"name" : @{
                                   @"newName" : @"lufy",
                                   @"oldName" : @"kitty",
                                   @"info" : @[
                                           @"test-data",
                                           @{@"nameChangedTime" : @"2013-08-07"}
                                           ]
                                   },
                           @"other" : @{
                                   @"bag" : @{
                                           @"name" : @"小书包",
                                           @"price" : @100.7
                                           }
                                   }
                           };
    
    //当有于系统关键字冲突 需要替换
    [MJStudent mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"ID" : @"id",
                 @"desc" : @"desciption",
                 @"oldName" : @"name.oldName",
                 @"nowName" : @"name.newName",
                 @"otherName" : @[@"otherName", @"name.newName", @"name.oldName"],
                 @"nameChangedTime" : @"name.info[1].nameChangedTime",
                 @"bag" : @"other.bag"
                 };
    }];
    
    // 2.将字典转为MJStudent模型
    MJStudent* stu = [MJStudent mj_objectWithKeyValues:dict];
    [arr addObject:stu];
    
  
    // 相当于在MJStudent.m中实现了+(NSDictionary *)mj_replacedKeyFromPropertyName方法
    
    // 3.打印MJStudent模型的属性
    NSLog(@"YYYYYY2   ID=%@, desc=%@, otherName=%@, oldName=%@, nowName=%@, nameChangedTime=%@", stu.ID, stu.desc, stu.otherName, stu.oldName, stu.nowName, stu.nameChangedTime);
    
    NSLog(@"AA  bagName=%@, bagPrice=%f", stu.bag.name, stu.bag.price);
    
    //    CFTimeInterval begin = CFAbsoluteTimeGetCurrent();
    //    for (int i = 0; i< 10000; i++) {
    //        [MJStudent mj_objectWithKeyValues:dict];
    //    }
    //    CFTimeInterval end = CFAbsoluteTimeGetCurrent();
    //    MJExtensionLog(@"%f", end - begin);
    
    
 }


//字典嵌套数组
-(void)test{
    // 1.定义一个字典
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.小码哥ad01.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.小码哥ad02.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    // 2.将字典转为MJStatusResult模型
  result = [MJStatusResult mj_objectWithKeyValues:dict];
    
    // 3.打印MJStatusResult模型的简单属性
    MJExtensionLog(@"totalNumber=%@, previousCursor=%lld, nextCursor=%lld", result.totalNumber, result.previousCursor, result.nextCursor);
    
    // 4.打印statuses数组中的模型属性
    for (MJStatus *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
        MJExtensionLog(@"text=%@, name=%@, icon=%@", text, name, icon);
    }
    
    // 5.打印ads数组中的模型属性
    for (MJAd *ad in result.ads) {
        MJExtensionLog(@"image=%@, url=%@", ad.image, ad.url);
    }
    
  
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
