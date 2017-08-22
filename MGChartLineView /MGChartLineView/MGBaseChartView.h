//
//  MGBaseChartView.h
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGBaseChartView : UIView

/**
 *  Y轴刻度标签title
 */
@property (nonatomic, strong) NSArray *yMarkTitles;

/**
 *  Y轴最大值
 */
@property (nonatomic, assign) CGFloat maxValue;

/**
 设置折线图数据

 @param values 存放数据的数组
 @param titleKey 横坐标 value 对应的 key
 @param valueKey 纵坐标 key 对应的 value
 */
- (void)setDataWithValues:(NSArray<NSDictionary *> *)values titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey;

/// 开始绘图
- (void)setMapping;


@end
