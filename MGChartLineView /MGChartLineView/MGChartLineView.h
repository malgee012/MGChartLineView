//
//  MGChartLineView.h
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import "MGAxisView.h"

@interface MGChartLineView : MGAxisView

@property (nonatomic, strong) NSArray *valueArray;

@property (nonatomic, assign) CGFloat maxValue;

/**
 *  绘图
 */
- (void)setMapping;


@end
