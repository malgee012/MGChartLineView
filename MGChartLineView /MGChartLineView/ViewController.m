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

    
    NSArray *values = @[@{@"key":@"00:00",@"value":@""},
                        @{@"key":@"",@"value":@""},
                        @{@"key":@"",@"value":@""},
                        @{@"key":@"",@"value":@100},
                        @{@"key":@"",@"value":@120},
                        @{@"key":@"",@"value":@130},
                        @{@"key":@"06:00",@"value":@110},
                        @{@"key":@"",@"value":@0},
                        @{@"key":@"",@"value":@0},
                        @{@"key":@"",@"value":@"0"},
                        @{@"key":@"",@"value":@160},
                        @{@"key":@"",@"value":@170},
                        @{@"key":@"12:00",@"value":@180},
                        @{@"key":@"",@"value":@100},
                        @{@"key":@"",@"value":@""},
                        @{@"key":@"",@"value":@""},
                        @{@"key":@"",@"value":@""},
                        @{@"key":@"",@"value":@80},
                        @{@"key":@"18:00",@"value":@100},
                        @{@"key":@"",@"value":@90},
                        @{@"key":@"",@"value":@60},
                        @{@"key":@"",@"value":@30},
                        @{@"key":@"",@"value":@90},
                        @{@"key":@"",@"value":@100},
                        @{@"key":@"24:00",@"value":@60}];
    
    [lineChart setDataWithValues: values titleKey:@"key" valueKey:@"value"];
    
    [lineChart setMapping];
    
    [self.view addSubview:lineChart];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
