//
//  SNRulerPickerView.m
//  SNRulerPicker
//
//  Created by HuWenzhi on 15/8/18.
//  Copyright (c) 2015年 SinceNow. All rights reserved.
//

#import "SNRulerPickerView.h"


@interface SNRulerPickerView() <UIScrollViewDelegate> {

}
@property (nonatomic, strong) SNRulerPickerRulerView *rulerView;
@property (nonatomic, strong) UILabel *lblValue;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *unit;


@end

@implementation SNRulerPickerView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.rulerView = [[SNRulerPickerRulerView alloc] initWithFrame:CGRectMake(0, 56, self.frame.size.width, self.frame.size.height-56)];
        self.rulerView.delegate = self;
        [self addSubview:self.rulerView];
        



    }
    return self;
}
-(void) updateView:(NSString*)title unit:(NSString*)unit minValue:(CGFloat)minValue maxValue:(CGFloat) maxValue defaultValue:(CGFloat) defaultValue
{
    [self.rulerView updateView:minValue maxValue:maxValue defaultValue:defaultValue];
    
    self.lblValue.text = [NSString stringWithFormat:@"%.1f",(float)defaultValue];
    [self.lblValue sizeToFit];
    self.lblValue.frame = CGRectMake((self.frame.size.width - self.lblValue.frame.size.width)/2, 0, self.lblValue.frame.size.width, self.lblValue.frame.size.height);
    
    [self addSubview:self.lblValue];
    
    
    
    self.unit.text = unit;
    [self.unit sizeToFit];
    self.unit.frame = CGRectMake((self.frame.size.width/2 +56), 3, self.unit.frame.size.width, self.unit.frame.size.height);
    
    [self addSubview:self.unit];
    
    
    self.title.text = title;
    [self.title sizeToFit];
    self.title.frame = CGRectMake(0, 30, self.title.frame.size.width, self.title.frame.size.height);
    
    [self addSubview:self.title];


}

-(UILabel*) lblValue
{
    if(!_lblValue){
        _lblValue = [[UILabel alloc] init];
        _lblValue.textColor = [UIColor colorWithRed:(231)/255.0f green:(40)/255.0f blue:(3)/255.0f alpha:1];
        _lblValue.font = [UIFont systemFontOfSize:36];
    }
    return _lblValue;
}
-(UILabel*) title
{
    if(!_title){
        _title = [[UILabel alloc] init];
        _title.textColor = [UIColor colorWithRed:(78)/255.0f green:(74)/255.0f blue:(74)/255.0f alpha:1];
        _title.font = [UIFont systemFontOfSize:15];
    }
    return _title;
}
-(UILabel*) unit
{
    if(!_unit){
        _unit = [[UILabel alloc] init];
        _unit.textColor = [UIColor colorWithRed:(78)/255.0f green:(74)/255.0f blue:(74)/255.0f alpha:1];
        _unit.font = [UIFont systemFontOfSize:18];
    }
    return _unit;
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   // NSLog(@"scrollViewDidEndDecelerating: %.1f", (float)self.rulerView.currentValue);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   // NSLog(@"scrollViewWillBeginDragging: %.1f", (float)self.rulerView.currentValue);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static NSInteger last_value = 0;
    
    // Calculate the value based on the content offset
    CGFloat value = self.rulerView.currentValue;
    
    if (value != last_value) {
        self.lblValue.text = [NSString stringWithFormat:@"%.1f",(float)value];
    }
    
    last_value = value;
}
- (CGFloat)currentValue
{
    return self.rulerView.currentValue;
}
@end
