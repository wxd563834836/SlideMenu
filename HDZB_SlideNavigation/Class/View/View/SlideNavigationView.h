//
//  SlideNavigationView.h
//  HDZB_SlideNavigation
//
//  Created by 王晓东 on 2018/10/31.
//  Copyright © 2018年 王晓东. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SlideNavigationViewDelegate<NSObject>
@optional
-(void)didSelectButtonWithTag:(NSInteger)btnTag;
@end


NS_ASSUME_NONNULL_BEGIN
typedef void(^ScrollBack)(CGFloat scrollOffset,CGFloat scrollFrameWidth);
@interface SlideNavigationView : UIView
@property(assign,nonatomic) NSInteger buttonNum;
@property(strong,nonatomic) NSMutableArray *btnTitleArray;
@property(assign,nonatomic) CGFloat btnWidth;
@property(assign,nonatomic) CGFloat btnOffset;
@property(assign,nonatomic) id<SlideNavigationViewDelegate> delegate;
@property(strong,nonatomic) ScrollBack backBlock;

-(instancetype)initWithFrame:(CGRect)frame
                   ButtonNum:(NSInteger)btnNum
            ButtonTitleArray:(NSMutableArray*)btnArray
                 ButtonWidth:(CGFloat)btnWidth
                ButtonOffset:(CGFloat)btnOffset;
@end

NS_ASSUME_NONNULL_END
