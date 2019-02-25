//
//  ViewController.m
//  stretchableHeadDemo
//
//  Created by Mr.xiong on 2019/2/25.
//  Copyright © 2019 xianhui. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "XHCustomNavBar.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *identifier = @"cellIdentifier";
static CGFloat headHeight = 275.f;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)XHCustomNavBar *navBar;
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //背景图片
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headHeight)];
    _topImageView.image = [UIImage imageNamed:@"风景"];
    [self.view addSubview:_topImageView];
    
    //导航栏
    _navBar = [[XHCustomNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _navBar.title = @"可拉伸界面";
    _navBar.titleColor = [UIColor whiteColor];
    _navBar.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navBar];
    
    //tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    
    //headView
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headHeight - 64)];
    headView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = headView;
    
    [self.view addSubview:tableView];
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate,
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
    return  cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //图片原始尺寸
    CGRect originRect = CGRectMake(0, 0, kScreenWidth, 275);
    
    CGFloat yOffSet = scrollView.contentOffset.y;

    //当滑动到导航栏之前
    if (yOffSet < headHeight) {
        
        CGFloat colorAlpha = yOffSet/headHeight;
        _navBar.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:colorAlpha];
        _navBar.titleColor = [UIColor whiteColor];
        
    }else{  //超过导航栏底部
        
        _navBar.backgroundColor = [UIColor whiteColor];
        _navBar.titleColor = [UIColor blackColor];
    }
    
    //手指向上滑动,图片上移
    if (yOffSet > 0) {
        
            CGRect frame = originRect;
            frame.origin.y = originRect.origin.y - yOffSet;
            _topImageView.frame =  frame;
    
    }else{  //手指向下滑动,图片放大
        
            CGRect frame = originRect;
            frame.size.height = originRect.size.height - yOffSet;
            frame.size.width =  frame.size.height * kScreenWidth/275;
            frame.origin.x =  originRect.origin.x - (frame.size.width - originRect.size.width)/2;
              _topImageView.frame = frame;
    }
}
@end
