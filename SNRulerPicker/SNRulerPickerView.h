//
//  SNRulerPickerView.h
//  SNRulerPicker
//
//  Created by HuWenzhi on 15/8/18.
//  Copyright (c) 2015年 SinceNow. All rights reserved.
//

#import "SNRulerPickerRulerView.h"

@interface SNRulerPickerView : UIView

-(void) updateView:(NSString*)title unit:(NSString*)unit minValue:(CGFloat)minValue maxValue:(CGFloat) maxValue defaultValue:(CGFloat) defaultValue;
@property (weak, nonatomic) id<UIScrollViewDelegate> delegate;
@property (assign, nonatomic) CGFloat currentValue;

@end
