//
//  SNRulerPickerRulerView.h
//  SNRulerPickerDemo
//
//  Created by HuWenzhi on 15/8/20.
//  Copyright (c) 2015年 SinceNow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNRulerPickerRulerView : UIView

-(void) updateView:(CGFloat)minValue maxValue:(CGFloat) maxValue defaultValue:(CGFloat) defaultValue;
@property (weak, nonatomic) id<UIScrollViewDelegate> delegate;
@property (assign, nonatomic) CGFloat currentValue;

@end
