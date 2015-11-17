//
//  ViewController.m
//  SNRulerPickerDemo
//
//  Created by HuWenzhi on 15/8/19.
//  Copyright (c) 2015年 SinceNow. All rights reserved.
//

#import "ViewController.h"
#import "SNRulerPickerView.h"

@interface ViewController ()  <UIScrollViewDelegate>
@property (nonatomic, strong) SNRulerPickerView *rulerPicker;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    self.rulerPicker = [[SNRulerPickerView alloc] initWithFrame:CGRectMake(17, 300, [UIScreen mainScreen].bounds.size.width-34, 132)];
    [self.rulerPicker updateView:@"体重" unit:@"kg" minValue:25 maxValue:200 defaultValue:72.3];
    [self.view addSubview:self.rulerPicker];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
