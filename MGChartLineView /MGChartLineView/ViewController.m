//
//  ViewController.m
//  MGChartLineView
//
//  Created by acmeway on 2017/5/24.
//  Copyright © 2017年 acmeway. All rights reserved.
//

#import "ViewController.h"
#import "MGBaseChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    MGBaseChartView *lineChart = [[MGBaseChartView alloc] initWithFrame:CGRectMake(10, 100, MGScreenWidth - 20, 200)];

    
    [lineChart setDataWithValues:@[@{@"item":@"00:00",@"count":@""},
                                   @{@"item":@"",@"count":@""},
                                   @{@"item":@"",@"count":@""},
                                   @{@"item":@"",@"count":@100},
                                   @{@"item":@"",@"count":@120},
                                   @{@"item":@"",@"count":@130},
                                   @{@"item":@"06:00",@"count":@110},
                                   @{@"item":@"",@"count":@0},
                                   @{@"item":@"",@"count":@0},
                                   @{@"item":@"",@"count":@"0"},
                                   @{@"item":@"",@"count":@160},
                                   @{@"item":@"",@"count":@170},
                                   @{@"item":@"12:00",@"count":@180},
                                   @{@"item":@"",@"count":@100},
                                   @{@"item":@"",@"count":@""},
                                   @{@"item":@"",@"count":@""},
                                   @{@"item":@"",@"count":@""},
                                   @{@"item":@"",@"count":@80},
                                   @{@"item":@"18:00",@"count":@100},
                                   @{@"item":@"",@"count":@90},
                                   @{@"item":@"",@"count":@60},
                                   @{@"item":@"",@"count":@30},
                                   @{@"item":@"",@"count":@90},
                                   @{@"item":@"",@"count":@100},
                                   @{@"item":@"24:00",@"count":@60}]
                        titleKey:@"item"
                        valueKey:@"count"];
    
    
    [lineChart setMapping];
    
//    lineChart.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.1];
    [self.view addSubview:lineChart];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
