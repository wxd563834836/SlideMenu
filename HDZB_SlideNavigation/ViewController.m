//
//  ViewController.m
//  HDZB_SlideNavigation
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "ViewController.h"
#import "SlideNavigationView.h"
@interface ViewController ()<SlideNavigationViewDelegate,UIScrollViewDelegate>
@property(strong,nonatomic) SlideNavigationView *slideView;
@property(strong,nonatomic) UIScrollView *myScrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *array=[[NSMutableArray alloc] initWithObjects:@"按钮1",@"按钮2",@"按钮3",@"按钮4",nil];
     self.slideView=[[SlideNavigationView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 60) ButtonNum:4 ButtonTitleArray:array ButtonWidth:50 ButtonOffset:50];
    self.slideView.delegate=self;
    
    [self.view addSubview:self.slideView];
    self.myScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height)];
    self.myScrollView.delegate=self;
//    myScrollView.backgroundColor=[UIColor blackColor];
    [self.myScrollView setContentSize:CGSizeMake(self.view.frame.size.width*4, self.view.frame.size.height)];
    self.myScrollView.pagingEnabled=YES;
    [self.view addSubview:self.myScrollView];
    UIView *view1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view1.backgroundColor=[UIColor redColor];
    
    [self.myScrollView addSubview:view1];
    
    UIView *view2=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view2.backgroundColor=[UIColor greenColor];
    [self.myScrollView addSubview:view2];
    
    UIView *view3=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*2, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view3.backgroundColor=[UIColor orangeColor];
    [self.myScrollView addSubview:view3];
    
    UIView *view4=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*3, 0, self.view.frame.size.width, self.view.frame.size.height)];
    view4.backgroundColor=[UIColor grayColor];
    [self.myScrollView addSubview:view4];
}
-(void)didSelectButtonWithTag:(NSInteger)btnTag{
    
    switch (btnTag) {
        case 100:
            [self.myScrollView setContentOffset:CGPointMake(0, 0)];
            break;
            
        case 101:
            [self.myScrollView setContentOffset:CGPointMake(self.view.frame.size.width, 0)];
            break;
            
        case 102:
            [self.myScrollView setContentOffset:CGPointMake(self.view.frame.size.width*2, 0)];
            break;
            
        case 103:
            [self.myScrollView setContentOffset:CGPointMake(self.view.frame.size.width*3, 0)];
            break;
            
        default:
            break;
    }
    NSLog(@"点击了按钮%ld",(long)btnTag);
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    self.slideView.backBlock(targetContentOffset->x,scrollView.frame.size.width);
}


//- (void)scrollViewDidEndDecelerating:(UIScrollView *)ascrollView{
//    self.slideView.backBlock(ascrollView.contentOffset.x,ascrollView.frame.size.width);
//}
@end
