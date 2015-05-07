//
//  ViewController.m
//  ActivityIndicatorTest
//
//  Created by caoZhenWei on 15/5/6.
//  Copyright (c) 2015年 caoZhenWei. All rights reserved.
//

#import "ViewController.h"
#import "ActivityIndicatorView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ActivityIndicatorView *indicatorView = [[ActivityIndicatorView alloc] initWithView:self.view];
    [indicatorView startAnimating];
    indicatorView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:indicatorView];
    [NSTimer scheduledTimerWithTimeInterval:3 target:indicatorView selector:@selector(stopAnimating) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:5 target:indicatorView selector:@selector(startAnimating) userInfo:nil repeats:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
