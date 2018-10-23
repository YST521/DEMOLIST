//
//  AliPayController.m
//  cellAnimation
//
//  Created by youxin on 2018/10/19.
//  Copyright © 2018年 yst. All rights reserved.
//

#import "AliPayController.h"
#import "UIView+Frame.h"
#import "UINavigationBar+Awesome.h"
#import "HeadBtnView.h"
#import "PayCollectionViewCell.h"
#import "NaView.h"
#import "MJRefresh.h"


#define NAVBAR_CHANGE_POINT 50


@interface AliPayController ()<UIScrollViewDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
     HeadBtnView *navV;
    NaView * navView;
}
@property(nonatomic,strong)UIScrollView *scrollV;
@property(nonatomic,strong)UIView       *customNav;
@property(nonatomic,strong)UIView       *headV;
@property(nonatomic,strong)UITableView      *tabView;
@property(nonatomic,strong)UISearchBar  *searchBar;
@property(nonatomic,strong)UICollectionView *collectionView;

@end
static  NSString *cellID = @"AliPayControllerCellID";
@implementation AliPayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.delegate = self;
    

    [self creatUI];
    
   __weak __typeof(self)weakSelf = self;
    self.tabView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
              [weakSelf.tabView setContentOffset:CGPointMake(0, 0)];
            [weakSelf.tabView.mj_header endRefreshing];
        });
    }];

    //这个demoz仅做了简单处理 高度适配和细节均未处理
    //结构 scrollView 上 + headView +tableVIew
    // headV 上 +4个btn + collectView
    //导航栏隐藏 用自定义View代替 通过滑动距离改变自定义View的透明度
    
  
}

-(void)creatUI{

//  self.scrollV.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);

    self.scrollV.delegate = self;
    [self.view addSubview:self.scrollV];
    [self.scrollV addSubview:self.headV];
    [self.scrollV addSubview:self.tabView];
//    self.tabView.tableHeaderView = self.headV;
    [self.view addSubview:self.customNav]; //此处最好自定义View
    self.tabView.scrollIndicatorInsets = self.tabView.contentInset;

    self.scrollV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HIGHT*2);
    
    self.scrollV.backgroundColor =[UIColor redColor];
    self.headV.backgroundColor = [UIColor greenColor];
    self.tabView.backgroundColor = [UIColor orangeColor];
//    self.customNav.backgroundColor = [UIColor cyanColor];
    
    self.tabView.scrollEnabled = NO;//禁止tabview上下滑动
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
//    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    
    if (@available(iOS 11.0, *)) {
        self.scrollV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    //导航栏处理
    navView = [[NaView alloc]init];
    navView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.customNav.height);
    [self.customNav addSubview:navView];
    navView.hidden = YES;
    
    //头部视图处理  头部视图可以作为collect的头视图进行封装
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 150);
    bgView.backgroundColor = PayColor;
    [self.headV addSubview:bgView];
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.backgroundImage = [[UIImage alloc]init];
    self.searchBar.barTintColor = PayColor;
     [_searchBar setBackgroundColor:[UIColor colorWithRed:0 green:0.5059 blue:0.9216 alpha:0.3]];
    self.searchBar.text = @"no money";
    self.searchBar.frame = CGRectMake(20, 30, SCREEN_WIDTH*0.75, 40);
    //设置透明背景搜索框
//     UIImage* searchBarBg = [self GetImageWithColor:[UIColor clearColor] andHeight:32.0f];
//    //设置背景图片
//    [_searchBar setBackgroundImage:[self GetImageWithColor:PayColor andHeight:32.0f]];
//    //设置背景色
//    [_searchBar setBackgroundColor:[UIColor clearColor]];
//    //设置文本框背景
//    [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
    
    [bgView addSubview:self.searchBar];
    
    //添加四个btn
    HeadBtnView *btnV = [[HeadBtnView alloc]init];
    btnV.frame = CGRectMake(0, self.searchBar.bottom, SCREEN_WIDTH, 100);
    [bgView addSubview:btnV];
    
 
    //下面的集合视图
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor =  [UIColor whiteColor];
    self.collectionView.frame = CGRectMake(0, bgView.bottom, SCREEN_WIDTH,250);
    [self.headV addSubview:self.collectionView];
//    self.collectionView.backgroundColor =[UIColor redColor];
    
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark - 显示隐藏头部VIew 根据下拉距离

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
     self.customNav.backgroundColor = [UIColor cyanColor];
    if (self.scrollV) {
        //64 此处64 在X上需要适配
        CGFloat offsetY = self.scrollV.contentOffset.y;
        if (offsetY > NAVBAR_CHANGE_POINT) {
            CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
            navView.hidden = NO;
            self.customNav.alpha = alpha;
            navView.alpha = alpha;
           
       
        } else {
            
            navView.hidden = YES;
            self.customNav.alpha = 0;
            navView.alpha = 0;
        }
    }
    
//    [self.scrollV setContentOffset:CGPointMake(0, 0)];
//      self.scrollV.bounces = NO;
   
    
    if(self.scrollV.contentOffset.y < 0){
       self.scrollV.scrollEnabled = NO;


     }else if(self.scrollV.contentOffset.y == 0){
      self.scrollV.scrollEnabled = YES;
  
     }else{
         self.scrollV.scrollEnabled = YES;

     }

    self.tabView.scrollEnabled = YES;
    
    NSLog(@"-- %f=== %f",self.scrollV.contentOffset.y,self.tabView.contentOffset.y);

    
    //防止手势干扰
    self.tabView.showsVerticalScrollIndicator = self.scrollV?YES:NO;
    
   
}



#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   
   PayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collect" forIndexPath:indexPath];
    cell.title.text = @"余额宝";
    cell.imgV.image = [UIImage imageNamed:@"transferMoney"];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        [self.navigationController popViewControllerAnimated:YES];
}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:collectionViewHeaderIdentify forIndexPath:indexPath];
//    [header addSubview:self.headerView];
//    return header;
//}


#pragma mark -UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    //高度 需要计算 不滚动
    CGFloat hh = SCREEN_HIGHT *2 - (self.headV.bottom+5);
    return hh/10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [self.tabView dequeueReusableCellWithIdentifier:cellID];
 UITableViewCell *cell = [self.tabView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    
    if(indexPath.row == 0){
        
         cell.textLabel.text = [NSString stringWithFormat:@"%@", @"==== 返回上一页面"];
    }else{
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }
    return cell; //一般项目首页会做 cell嵌套 collect tableVIew等处理
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

}

#pragma mark -layzUI
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]init];
        _scrollV.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HIGHT);
    }
    return _scrollV;
}
-(UIView *)headV{
    if (!_headV) {
        _headV = [[UIView alloc]init];
        _headV.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
    }
    return _headV;
}
-(UITableView *)tabView{
    if (!_tabView) {
        _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headV.bottom+5, SCREEN_WIDTH, SCREEN_HIGHT*2-(self.headV.bottom+5)) style:(UITableViewStylePlain)];
        
    }
    return _tabView;
}

-(UIView *)customNav{
    if (!_customNav) {
        _customNav = [[UIView alloc]init];
        _customNav.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64); //高度一般是导航栏高度 此处未适配
    }
    return _customNav;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        double width = (SCREEN_WIDTH - 180) / 4.0;
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumLineSpacing = 20;
        layout.minimumInteritemSpacing = 20;
        layout.sectionInset = UIEdgeInsetsMake(5, 30, 5, 30);
//        layout.headerReferenceSize =CGSizeMake(SCREEN_WIDTH, 80); //头部视图
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,100, 250) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[PayCollectionViewCell class] forCellWithReuseIdentifier:@"collect"];
//        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collect"];
    }
    return _collectionView;
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
        // 判断要显示的控制器是否是自己
        BOOL isShowHomePage = [viewController isKindOfClass:[self class]];

        [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
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
