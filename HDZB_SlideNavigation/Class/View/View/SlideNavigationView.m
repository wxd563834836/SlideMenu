//
//  SlideNavigationView.m
//  HDZB_SlideNavigation
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import "SlideNavigationView.h"

@interface SlideNavigationView()<UIScrollViewDelegate>
@property(strong,nonatomic) UIScrollView *topScrollView;
@property(strong,nonatomic) UIView *bottomSlideView;

@end

//文字字体大小
static const CGFloat textDefaultFontSize=15;
static const CGFloat textSelectedFontSize=18;
#define DefaultColor [UIColor blackColor]
#define SelectColor [UIColor greenColor]


@implementation SlideNavigationView

-(instancetype)initWithFrame:(CGRect)frame
                   ButtonNum:(NSInteger)btnNum
            ButtonTitleArray:(NSMutableArray*)btnArray
                 ButtonWidth:(CGFloat)btnWidth
                ButtonOffset:(CGFloat)btnOffset{
    if(self=[super initWithFrame:frame]){
        _buttonNum=btnNum;
        _btnTitleArray=btnArray;
        _btnWidth=btnWidth;
        _btnOffset=btnOffset;
        [self createUI];
    }
    return self;
}
-(void)createUI{
    self.topScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    // 一个屏幕宽的Scrollview Content 能放下多少个按钮
    int num=(self.frame.size.width-2*self.btnOffset)/self.btnWidth<self.buttonNum?(self.frame.size.width-2*self.btnOffset)/self.btnWidth:(int)self.buttonNum;
    //两个按钮之间的间隙
    CGFloat btnGap;
    btnGap = (self.frame.size.width-2*self.btnOffset-num*self.btnWidth)/(num-1);
    //需要多少个整屏宽
    int screenWidthNum=(int)(self.buttonNum/num)==0?1:(int)(self.buttonNum/num);
    //余下多少个按钮 不够一整宽
    int lastNum=(int)(self.buttonNum-num*screenWidthNum);
    if(self.btnWidth*self.buttonNum+2*self.btnOffset>self.frame.size.width){

        //余下的需要多少宽度
        CGFloat lastWidth=lastNum*self.btnWidth+2*self.btnOffset+(lastNum-1)*btnGap;
        [self.topScrollView setContentSize:CGSizeMake(screenWidthNum*self.frame.size.width+lastWidth, self.frame.size.height)];
        
    }else{
        [self.topScrollView setContentSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    }
    self.topScrollView.showsVerticalScrollIndicator=NO;
    self.topScrollView.showsHorizontalScrollIndicator=NO;
    self.topScrollView.scrollEnabled=YES;
    [self addSubview:self.topScrollView];

//    for(int i=1;i<=screenWidthNum+1;i++){
//
//        if(i<=screenWidthNum){
//            for(int j=0;j<num;j++){
//               UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(self.btnOffset+j*btnGap+j*self.btnWidth+(i-1)*self.frame.size.width, 0, self.btnWidth, self.frame.size.height-2)];
//                btn.tag=i*100+j;
//                [btn setTitle:@"hahhah" forState:UIControlStateNormal];
//                if(btn.tag==100){
//                    [btn setSelected:YES];
//                    [btn.titleLabel setFont:[UIFont systemFontOfSize:textSelectedFontSize]];
//                }else{
//                    [btn setSelected:NO];
//                    [btn.titleLabel setFont:[UIFont systemFontOfSize:textDefaultFontSize]];
//                }
//                [btn setTitleColor:DefaultColor forState:UIControlStateNormal];
//                [btn setTitleColor:SelectColor forState:UIControlStateSelected];
//                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [self.topScrollView addSubview:btn];
//            }
//        }else{
//            for(int z=0;z<lastNum;z++){
//                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(self.btnOffset+z*btnGap+z*self.btnWidth+(i-1)*self.frame.size.width, 0, self.btnWidth, self.frame.size.height-2)];
//                btn.tag=i*100+z;
//                [btn setTitle:@"hahhah" forState:UIControlStateNormal];
//                if(btn.tag==100){
//                    [btn setSelected:YES];
//                    [btn.titleLabel setFont:[UIFont systemFontOfSize:textSelectedFontSize]];
//                }else{
//                    [btn setSelected:NO];
//                    [btn.titleLabel setFont:[UIFont systemFontOfSize:textDefaultFontSize]];
//                }
//                [btn setTitleColor:DefaultColor forState:UIControlStateNormal];
//                [btn setTitleColor:SelectColor forState:UIControlStateSelected];
//                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//                [self.topScrollView addSubview:btn];
//            }
//        }
//
//    }
    for(int i=0;i<self.buttonNum;i++){
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(self.btnOffset+i*self.btnWidth+i*btnGap, 0, self.btnWidth, self.frame.size.height-2)];
        btn.tag=i+100;
        NSString *titleStr=self.btnTitleArray[i];
        [btn setTitle:titleStr forState:UIControlStateNormal];
        if(btn.tag==100){
            [btn setSelected:YES];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:textSelectedFontSize]];
        }else{
            [btn setSelected:NO];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:textDefaultFontSize]];
        }
        [btn setTitleColor:DefaultColor forState:UIControlStateNormal];
        [btn setTitleColor:SelectColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:btn];
    }
    self.bottomSlideView=[[UIView alloc] initWithFrame:CGRectMake(self.btnOffset+5, self.frame.size.height-2, self.btnWidth-10, 2)];
    [self.bottomSlideView setBackgroundColor:SelectColor];
    [self.topScrollView addSubview:self.bottomSlideView];
    __weak typeof(self) weakSelf = self;
    self.backBlock = ^(CGFloat scrollOffset,CGFloat scrollFrameWidth) {
        NSLog(@"滑动了%f",scrollOffset);
//        if(scrollOffset/(scrollContentWidth/2))
        int slideTag=scrollOffset/(scrollFrameWidth);
        UIButton *selectBtn=(UIButton*)[weakSelf viewWithTag:slideTag+100];
            for(int i=0;i<self.buttonNum;i++){
                UIButton *otherBtn=(UIButton*)[weakSelf viewWithTag:i+100];
                if(selectBtn.tag==otherBtn.tag){
                    selectBtn.selected=YES;
                    [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:textSelectedFontSize]];
                }else{
                    otherBtn.selected=NO;
                    [otherBtn.titleLabel setFont:[UIFont systemFontOfSize:textDefaultFontSize]];
                }
            }
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint centerPoint;
            centerPoint.x=selectBtn.center.x;
            centerPoint.y=self.frame.size.height-1;
            [weakSelf.bottomSlideView setCenter:centerPoint];
        }];
    };
    
    
}
-(void)btnClick:(UIButton*)btn{
    UIButton *selectBtn=btn;
    for(int i=0;i<self.buttonNum;i++){
        UIButton *otherBtn=(UIButton*)[self viewWithTag:i+100];
        if(selectBtn.tag==otherBtn.tag){
            selectBtn.selected=YES;
            [selectBtn.titleLabel setFont:[UIFont systemFontOfSize:textSelectedFontSize]];
        }else{
            otherBtn.selected=NO;
            [otherBtn.titleLabel setFont:[UIFont systemFontOfSize:textDefaultFontSize]];
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint centerPoint;
        centerPoint.x=selectBtn.center.x;
        centerPoint.y=self.frame.size.height-1;
        [self.bottomSlideView setCenter:centerPoint];
    }];
    if(self.delegate!=nil){
        [self.delegate didSelectButtonWithTag:btn.tag];
    }

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
