//
//  NetWorkController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/11.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "NetWorkController.h"
#import "Reachability.h"
#import "NetWorkPopView.h"

@interface NetWorkController ()
@property (nonatomic,strong) Reachability *netConnect;
@property (nonatomic,strong)NetWorkPopView *popV;
@property (nonatomic,strong)NetWorkPopView *nonetpopV;
@end

@implementation NetWorkController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor whiteColor];
       [self setTitleStr:self.titleStr];
    //方法 1
    NSString *str = [self getNetWorkStates];
    NSLog(@"**************** %@",str);
    
    //方法二
    [self networkStatu];
  
    //方法二 全局监听
    //判断网络状态
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"isNotReachable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColor:) name:@"noNotReachable" object:nil];
  
    
}
-(void)networkStatu{
    /***************  方法1 : block块  ***************/
    
    /*
     *1.最好是本公司的网站;
     *2.国内能够访问的网站;
     */
    
    NSString *urlStr = @"写一个能连接的网址";
    
    //创建监听络的对象self.netConnect
    self.netConnect = [Reachability reachabilityWithHostname:urlStr];
    
    __weak typeof(self) weakSelf = self;
    
    //网络连接成功
    self.netConnect.reachableBlock = ^(Reachability * reachability)
    {
        
        //打印网络名称，是 2G 网络还是 wifi ;
        NSLog(@"connect success  :newName = %@",weakSelf.netConnect.currentReachabilityString);
        
        //主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"reload data");
        });
    };
    
    //网络连接失败
    self.netConnect.unreachableBlock = ^(Reachability * reachability)
    {
        
        NSLog(@"connect error");
        
        //主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"to do something");
        });
    };
    
    //不要忘记启动噢
    [self.netConnect startNotifier];
    
    
    /***************  方法2 : 通知  ***************/
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:self.netConnect];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)changeColor:(NSNotification *)notification{
    
    BOOL isNetWork;

    NSString *typeStr;
    NSString *str = @"0";
    if([str isEqualToString:notification.userInfo[@"status"]]) {
        self.view.backgroundColor = [UIColor redColor];
        isNetWork = NO;
        typeStr = @"无网络";
       
    }else{
        
        self.view.backgroundColor = [UIColor greenColor];
        isNetWork = YES;
       
        typeStr = notification.userInfo[@"type"];
    }
   
  
    if (isNetWork ) { //有网络
      
        [self.nonetpopV popCancel];
        self.nonetpopV = nil;
        
        if (!self.popV) {
           self.popV = [[NetWorkPopView alloc]initTitleStr:typeStr];
            self.popV.typeStr = typeStr;
            [self.popV popShow];
            
        }
        
    } else { //无网络
        [self.popV popCancel];
         self.popV = nil;
        
        if (!self.nonetpopV) {
            self.nonetpopV = [[NetWorkPopView alloc]initTitleStr:typeStr];
            self.nonetpopV.typeStr = typeStr;
            [self.nonetpopV popShow];

        }
       
        

    }

 

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.nonetpopV popCancel];
    [self.popV popCancel];
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    
    /*
     *currentReachabilityStatus
     *
     * NotReachable = 0,
     * ReachableViaWiFi = 2,
     * ReachableViaWWAN = 1
     */
    
    Reachability *reach = notification.object;
    
    switch (reach.currentReachabilityStatus)
    {
        case NotReachable:
            NSLog(@"connect error");
            break;
        case ReachableViaWiFi:
            NSLog(@"connect wifi");
            break;
        case ReachableViaWWAN:
            NSLog(@"connect wwan");
            break;
        default:
            break;
    }
}


- (NSString *)getNetWorkStates{
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSString *state = [[NSString alloc]init];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
       
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            
            switch (netType) {
                case 0:
                    state = @"无网络";
                    //无网模式
                    break;
                case 1:
                    state =  @"2G";
                    break;
                case 2:
                    state =  @"3G";
                    break;
                case 3:
                    state =   @"4G";
                    break;
                case 5:
                {
                    state =  @"wifi";
                    break;
                default:
                    break;
                }
            }
        }
    }
        
        NSLog(@"根据状态栏 判断网路状态---  %@",state);
        
        //根据状态选择
        return state;
    }

@end
