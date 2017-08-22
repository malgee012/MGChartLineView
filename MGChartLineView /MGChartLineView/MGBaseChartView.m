//
//  MGBaseChartView.m
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import "MGBaseChartView.h"
#import "MGChartLineView.h"
@interface MGBaseChartView ()
{
    NSMutableArray *_xMarkTitles;
    NSMutableArray *_valueArrays;
}

@property (nonatomic, strong) NSArray *xMarkTitlesAndValues;

@property (nonatomic, strong) MGChartLineView *chartLineView;

@end
@implementation MGBaseChartView


- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    _yMarkTitles = yMarkTitles;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    
}

- (void)setDataWithValues:(NSArray<NSDictionary *> *)values titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey
{
    _xMarkTitlesAndValues = values;
    
    _xMarkTitles = [NSMutableArray array];
    
    _valueArrays = [NSMutableArray array];
    
    if (values.count == 0) return;
    
    
    for (NSDictionary *dict in values) {
        
        [_xMarkTitles addObject:[dict objectForKey:titleKey]];
        
        [_valueArrays addObject:[dict objectForKey:valueKey]];
    }
}

- (void)setMapping
{
    if (self.xMarkTitlesAndValues.count == 0)
    {
        NSException *exception = [NSException exceptionWithName: @"数组为空"
                                                         reason: @"xMarkTitlesAndValues 心率数据数组不能为空"
                                                       userInfo: nil];
        @throw exception;
    }
    if (!self.yMarkTitles)
    {
        self.yMarkTitles = @[@0, @50, @100, @150, @200];
    }
    
    self.chartLineView = [[MGChartLineView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    

    self.chartLineView.yMarkTitles = self.yMarkTitles;
    
    self.chartLineView.xMarkTitles = _xMarkTitles;

    self.chartLineView.valueArray = _valueArrays;
    
    self.chartLineView.maxValue = 200;
    
    [self addSubview:self.chartLineView];
    
    [self.chartLineView setMapping];
    
}

@end
