//
//  MGChartLineView.m
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import "MGChartLineView.h"

#define BASE_TAG_COVERVIEW 100
#define BASE_TAG_CIRCLEVIEW 200
#define BASE_TAG_POPBTN 300
@interface MGChartLineView ()
{
    NSMutableArray *pointArray;
    NSInteger lastSelectedIndex;
    NSInteger   _tempVariableValue;
    
}

@property (nonatomic, strong) NSMutableArray  *valueArrays;

@end
@implementation MGChartLineView

- (void)setValueArray:(NSArray *)valueArray
{
    _valueArray = valueArray;
    
    // 过滤不需要的值
    if (valueArray.count > 0) {
        
        [self.valueArrays removeAllObjects];
        
        for (int i = 0; i < valueArray.count; i++) {
            
            if (![valueArray[i] isEqual:@""] &&
                ![valueArray[i] isEqual:@"0"] &&
                ![valueArray[i] isEqual:@0] &&
                ![valueArray[i] isEqual:[NSNull null]])
            {
                [self.valueArrays addObject:valueArray[i]];
            }
            
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        lastSelectedIndex = - 1;
        
        pointArray = [NSMutableArray array];
        
        self.yAxis_L = frame.size.height;
        self.xAxis_L = frame.size.width;
        
    }
    return  self;
}
- (void)setMapping
{
    [super setMapping];
    
    [self drawChartLine];
    
    [self setupCircleViews];
    
    [self setupCoverViews];
}


/**
 * 绘制折线路径
 */
- (void)drawChartLine
{
    UIBezierPath *pointAxisPath = [[UIBezierPath alloc] init];
    
    CGFloat lastValue = 0;
    
    CGFloat nextValue = 0;
    
    for (int i = 0; i < self.valueArray.count; i ++) {
        
        CGFloat point_X = self.xScaleMarkLEN * i + self.startPoint.x;
        
        if (i >= 1)  lastValue = [self.valueArray[i - 1] floatValue];
        
        CGFloat value = [self.valueArray[i] floatValue];
        
        if (i <= _valueArray.count - 2) nextValue =  [self.valueArray[i + 1] floatValue];

        CGFloat percent = value / self.maxValue;
        
        CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
        
        CGPoint point = CGPointMake(point_X, point_Y);
        
        if (value > 0) [pointArray addObject:[NSValue valueWithCGPoint:point]];
        
        if (value > 0 && lastValue == 0)
        {
            [pointAxisPath moveToPoint:point];
        }
        
        if (value != 0 )
        {
            [pointAxisPath addLineToPoint:point];
        }
        
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    
    pAxisLayer.lineWidth = 1;
    
    pAxisLayer.strokeColor = [UIColor colorWithRed:0.25f green:0.67f blue:0.96f alpha:1.00f].CGColor;
    
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    
    pAxisLayer.path = pointAxisPath.CGPath;
    
    pAxisLayer.lineCap = kCALineJoinRound;
    
    pAxisLayer.lineJoin = kCALineJoinRound;
    
    [self.layer addSublayer:pAxisLayer];
    
}

- (void)setupCircleViews
{
    for (int i = 0; i < pointArray.count; i ++)
    {
        
        // 添加小圆点
        CGPoint center = [pointArray[i] CGPointValue];
        
        CGFloat radius = 2.0f;
        
        UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(center.x - radius,
                                                                      center.y - radius,
                                                                      radius * 2.0,
                                                                      radius * 2.0)];
        circleView.tag = i + BASE_TAG_CIRCLEVIEW;
        
        circleView.backgroundColor = [UIColor blueColor];
        
        circleView.layer.cornerRadius = 2;
        
        circleView.layer.masksToBounds = YES;
        
        
        [self addSubview:circleView];
        
        // 竖直指示线
        UIView *markLine = [[UIView alloc] initWithFrame:CGRectMake(center.x - 0.5,
                                                                    center.y - 0.5,
                                                                    1,
                                                                    (1-center.y / self.yAxis_L) * self.yAxis_L + self.startPoint.y)];
        
        markLine.tag = i + BASE_TAG_CIRCLEVIEW*2 ;
        
        [self addSubview:markLine];
        
    }
}

// 添加覆盖
- (void)setupCoverViews
{
    
    for (int i = 0; i < pointArray.count; i ++)
    {
        
        UIView *coverView = [[UIView alloc] init];
        
        coverView.tag = BASE_TAG_COVERVIEW + i;
        
        CGPoint point = [pointArray[i] CGPointValue];
        
        coverView.frame = CGRectMake(point.x - self.xScaleMarkLEN / 2,
                                     self.startPoint.y,
                                     self.xScaleMarkLEN,
                                     self.yAxis_L);
        
        
        
        [self addSubview:coverView];
        
        // 添加点击手势
        UITapGestureRecognizer *gesutre = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(gesutreAction:)];
        [coverView addGestureRecognizer:gesutre];
    }
    
}


/**
 点击手势操作

 @param sender sender
 */
- (void)gesutreAction:(UITapGestureRecognizer *)sender {
    
    NSInteger index = sender.view.tag - BASE_TAG_COVERVIEW;
    
    // 上一次的点击处理
    if (lastSelectedIndex != -1) {
        
        UIView *lastCircleView = [self viewWithTag:lastSelectedIndex + BASE_TAG_CIRCLEVIEW];
        
        lastCircleView.backgroundColor = [UIColor blueColor];
        
        UIView *line = [self viewWithTag:lastSelectedIndex + BASE_TAG_CIRCLEVIEW*2 ];
        
        line.backgroundColor = [UIColor clearColor];
        
        UIButton *lastPopBtn = (UIButton *)[self viewWithTag:lastSelectedIndex + BASE_TAG_POPBTN];
        
        [lastPopBtn removeFromSuperview];
        
    }
    
    // 本次点击处理
    UIView *circleView = [self viewWithTag:index + BASE_TAG_CIRCLEVIEW];
    
    circleView.backgroundColor = [UIColor colorWithRed:0.25f green:0.67f blue:0.96f alpha:1.00f];

    UIView *line = [self viewWithTag:index + BASE_TAG_CIRCLEVIEW*2 ];
    
    line.backgroundColor = [UIColor colorWithRed:0.05f green:0.80f blue:0.42f alpha:1.00f];
    
    CGPoint point = [pointArray[index] CGPointValue];
    
    UIButton *popBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    popBtn.tag = index + BASE_TAG_POPBTN;
    
    popBtn.frame = CGRectMake(point.x - 17, point.y - 24, 34, 22);
    
    [popBtn setBackgroundImage:[UIImage imageNamed:@"home_plan_mark_icon.png"] forState:UIControlStateNormal];
    
    [popBtn setTitleEdgeInsets:UIEdgeInsetsMake(- 3, 0, 0, 0)];
    
    popBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    popBtn.adjustsImageWhenHighlighted = NO;
    
    [popBtn setTitle:[NSString stringWithFormat:@"%@",self.valueArrays[index]] forState:(UIControlStateNormal)];
    
    [self addSubview:popBtn];
    
    // 记录上一次点击索引
    lastSelectedIndex = index;
}


- (NSMutableArray *)valueArrays
{
    if (!_valueArrays) {
        _valueArrays = [[NSMutableArray alloc] init];
    }
    return _valueArrays;
}



@end
