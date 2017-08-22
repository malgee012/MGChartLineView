//
//  MGAxisView.m
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import "MGAxisView.h"

/**
 *  Y轴刻度标签 与 Y轴 之间 空隙
 */
#define HORIZON_YMARKLAB_YAXISLINE 10.0f
/**
 *  Y轴刻度标签  宽度
 */
#define YMARKLAB_WIDTH 25.0f

/**
 *  Y轴刻度标签  高度
 */
#define YMARKLAB_HEIGHT 16.0f
/**
 *  X轴刻度标签  宽度
 */

#define XMARKLAB_WIDTH 40.0f

/**
 *  X轴刻度标签  高度
 */
#define XMARKLAB_HEIGHT 16.0f
/**
 *  最上边的Y轴刻度标签距离顶部的 距离
 */
#define YMARKLAB_TO_TOP 12.0f

@interface MGAxisView ()
{
    /**
     *  视图的宽度
     */
    CGFloat axisViewWidth;
    /**
     *  视图的高度
     */
    CGFloat axisViewHeight;

}
/**
 *  与x轴平行的网格线的间距(与坐标系视图的高度和y轴刻度标签的个数相关)
 */
@property (nonatomic, assign) CGFloat yScaleMarkLEN;


@end
@implementation MGAxisView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        axisViewHeight = frame.size.height;
        
        axisViewWidth = frame.size.width;
        
        CGFloat  start_X = HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH;
        
        CGFloat  start_Y = YMARKLAB_HEIGHT / 2.0 + YMARKLAB_TO_TOP;
        
        self.startPoint = CGPointMake(start_X, start_Y);
    }
    return self;
}
- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    
    _yMarkTitles = yMarkTitles;
}

- (void)setXMarkTitles:(NSArray *)xMarkTitles {
    
    _xMarkTitles = xMarkTitles;
}

- (void)setMapping
{
    self.yScaleMarkLEN = (axisViewHeight - YMARKLAB_HEIGHT - XMARKLAB_HEIGHT - YMARKLAB_TO_TOP) / (self.yMarkTitles.count - 1);
    
    self.yAxis_L = self.yScaleMarkLEN * (self.yMarkTitles.count - 1);
    
    self.xScaleMarkLEN = (axisViewWidth - HORIZON_YMARKLAB_YAXISLINE - YMARKLAB_WIDTH - XMARKLAB_WIDTH / 2.0) / (self.xMarkTitles.count - 1);
    
    self.xAxis_L = self.xScaleMarkLEN * (self.xMarkTitles.count - 1);
    
    [self setupYMarkLabs];
    
    [self setupXMarkLabs];
    
    [self drawXAxsiLine];
    
    [self drawXGridline];
}

- (void)setupYMarkLabs
{
    for (int i = 0; i < self.yMarkTitles.count; i ++) {
        
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.startPoint.y - YMARKLAB_HEIGHT / 2 + i * self.yScaleMarkLEN,
                                                                     YMARKLAB_WIDTH,
                                                                     YMARKLAB_HEIGHT)];
        markLab.textAlignment = NSTextAlignmentRight;
        
        markLab.font = [UIFont systemFontOfSize:10];
        
        markLab.text = [NSString stringWithFormat:@"%@", self.yMarkTitles[self.yMarkTitles.count - 1 - i]];
        
        markLab.textColor = [UIColor colorWithRed:0.58f green:0.58f blue:0.58f alpha:1.00f];
        [self addSubview:markLab];
    }

}
- (void)setupXMarkLabs
{
    for (int i = 0;i < self.xMarkTitles.count; i ++) {
        
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x - XMARKLAB_WIDTH / 2 + i * self.xScaleMarkLEN,
                                                                     self.yAxis_L + self.startPoint.y + YMARKLAB_HEIGHT / 2,
                                                                     XMARKLAB_WIDTH,
                                                                     XMARKLAB_HEIGHT)];
        markLab.textAlignment = NSTextAlignmentCenter;
        
        markLab.font = [UIFont systemFontOfSize:10];
        
        markLab.text = self.xMarkTitles[i];
        
        markLab.textColor = [UIColor colorWithRed:0.58f green:0.58f blue:0.58f alpha:1.00f];
        
        [self addSubview:markLab];
    }
}

- (void)drawXAxsiLine
{
    UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
    
    [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    
    [xAxisPath addLineToPoint:CGPointMake(self.xAxis_L + self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
//    [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    xAxisLayer.lineWidth = 2;
    
    xAxisLayer.strokeColor = [UIColor colorWithRed:0.92f green:0.95f blue:0.95f alpha:0.7f].CGColor;
    
    xAxisLayer.path = xAxisPath.CGPath;
    
    [self.layer addSublayer:xAxisLayer];

}

- (void)drawXGridline
{
    for (int i = 0; i < self.yMarkTitles.count - 1; i ++) {
        
        CGFloat curMark_Y = self.yScaleMarkLEN * i;
        
        UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
        
        [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, curMark_Y + self.startPoint.y)];
        
        [xAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, curMark_Y + self.startPoint.y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
        
        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3], [NSNumber numberWithInt:5], nil]];
        
        xAxisLayer.lineWidth = 0.3;
        
        xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        
        xAxisLayer.path = xAxisPath.CGPath;
        
        [self.layer addSublayer:xAxisLayer];
    }

}

@end
