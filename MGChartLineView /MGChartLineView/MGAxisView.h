//
//  MGAxisView.h
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGAxisView : UIView

/**
 *  Y轴刻度标签
 */
@property (nonatomic, strong) NSArray *yMarkTitles;
/**
 *  X轴刻度标签
 */
@property (nonatomic, strong) NSArray *xMarkTitles;

/**
 *  与Y轴平行的网格线的间距
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;

/**
 *  网格线的起始点
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 *  x 轴长度
 */
@property (nonatomic, assign) CGFloat yAxis_L;
/**
 *  y 轴长度
 */
@property (nonatomic, assign) CGFloat xAxis_L;

/**
 *  绘图
 */
- (void)setMapping;


@end
