//
//  SNRulerPickerRulerView.m
//  SNRulerPickerDemo
//
//  Created by HuWenzhi on 15/8/20.
//  Copyright (c) 2015年 SinceNow. All rights reserved.
//

#import "SNRulerPickerRulerView.h"


@interface SNRulerPickerRulerView() <UIScrollViewDelegate> {
    
}

@property (assign) CGFloat minValue;
@property (assign) CGFloat maxValue;
@property (assign) CGFloat defaultValue;

@property (assign) CGFloat scaleTimes;
@property (assign) CGFloat scaleImageWidth;



@property (nonatomic, strong) UIView *rulerView;
@property (nonatomic, strong) UIScrollView *rulerScrollView;

@end

@implementation SNRulerPickerRulerView

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scaleTimes = 10.0f;
        //self.scaleImageWidth = 200;
        
        
        self.backgroundColor = [UIColor clearColor];
        self.rulerView.frame = self.bounds;
        [self addSubview:self.rulerView];
        
        
        
    }
    return self;
}
-(void) updateView:(CGFloat)minValue maxValue:(CGFloat) maxValue defaultValue:(CGFloat) defaultValue
{
    self.minValue = minValue;
    self.maxValue = maxValue;
    self.defaultValue = defaultValue;
    
    
    
    UIImageView *maskImageView = [[UIImageView alloc] init];
    maskImageView.image = [UIImage imageNamed:@"ruler_mask"];
    maskImageView.frame = self.rulerView.bounds;
    [self.rulerView setMaskView:maskImageView];
    
    
    self.rulerScrollView.frame = self.rulerView.bounds;
    //self.rulerScrollView.frame = CGRectMake(self.rulerView.bounds.size.width/2, self.rulerView.bounds.origin.y, self.rulerView.bounds.size.width/2, self.rulerView.bounds.size.height);
    [self.rulerView addSubview:self.rulerScrollView];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.image = [UIImage imageNamed:@"ruler_bg"];
    backgroundImageView.frame = self.rulerView.bounds;
    [self insertSubview:backgroundImageView belowSubview:self.rulerView];
    
    UIImageView *indicatorImageView = [[UIImageView alloc] init];
    indicatorImageView.image = [UIImage imageNamed:@"ruler_indicator"];
    indicatorImageView.frame = self.rulerView.bounds;
    [self insertSubview:indicatorImageView aboveSubview:self.rulerView];
    
    UIView *scaleMarkView = [[UIView alloc] init];
    UIImageView  *scaleMark = [[UIImageView alloc] init];
    scaleMark.backgroundColor = [UIColor clearColor];
    UIImage *img = [UIImage imageNamed:@"scale_mark"];
    self.scaleImageWidth = img.size.width;
    [scaleMark setImage:[img resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, self.scaleImageWidth, 0) resizingMode:UIImageResizingModeTile]];
    
    CGFloat total = self.maxValue - self.minValue;
    
    for(NSInteger i=0;i<=total;i++)
    {
        
        UILabel *lblNumber = [[UILabel alloc] init];
        lblNumber.text = [NSString stringWithFormat:@"%ld",(long)(i+self.minValue)];
        lblNumber.textColor = [UIColor colorWithRed:(78)/255.0f green:(78)/255.0f blue:(78)/255.0f alpha:1];
        lblNumber.font = [UIFont systemFontOfSize:15];
        [lblNumber sizeToFit];
        lblNumber.frame = CGRectMake(self.rulerView.frame.size.width/2 + i * self.scaleImageWidth - lblNumber.frame.size.width/2, self.rulerView.frame.size.height - 11 - lblNumber.frame.size.height, lblNumber.frame.size.width, lblNumber.frame.size.height);
        [self.rulerScrollView addSubview:lblNumber];
    }
    
    scaleMarkView.frame = CGRectMake(0, 0, self.scaleImageWidth * total + self.rulerView.frame.size.width, 25);
    scaleMark.frame = CGRectMake(self.rulerView.frame.size.width/2-self.scaleImageWidth*5, 0, self.scaleImageWidth * total + self.rulerView.frame.size.width + self.scaleImageWidth*5, 25);
    self.rulerScrollView.contentSize = CGSizeMake(self.scaleImageWidth * total+self.rulerView.frame.size.width, self.rulerView.bounds.size.height);
    //self.rulerScrollView.contentInset = UIEdgeInsetsMake(0, -self.rulerView.frame.size.width/3, 0, 0);
    
    CGFloat contentX = -self.rulerView.frame.size.width/2+(defaultValue-self.minValue)*self.scaleImageWidth;
    [self.rulerScrollView setContentOffset:CGPointMake(roundf(contentX), 0) animated:YES];
    [self.rulerScrollView addSubview:scaleMark];
    
}

- (CGPoint)scrollToOffset:(CGPoint)contentX {
    
    CGPoint contentNew = contentX;
    contentNew.x = roundf(contentX.x / (self.scaleImageWidth / 10)) * (self.scaleImageWidth/10) ;
    //NSLog(@"contentX=%f, contentNew=%f", contentX.x, contentNew.x);
    return contentNew;
}


-(UIView *) rulerView
{
    if (!_rulerView) {
        _rulerView = [[UIView alloc] init];
        
    }
    return _rulerView;
}

-(UIScrollView *) rulerScrollView
{
    if (!_rulerScrollView) {
        _rulerScrollView = [[UIScrollView alloc] init];
        _rulerScrollView.showsHorizontalScrollIndicator = NO;
        _rulerScrollView.showsVerticalScrollIndicator = NO;
        [_rulerScrollView setClipsToBounds:YES];
        _rulerScrollView.delegate = self;
        [_rulerScrollView setBounces:YES];
        [_rulerScrollView setBouncesZoom:YES];
        
    }
    return _rulerScrollView;
}

#pragma mark - UIScrollViewDelegate

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([super respondsToSelector:aSelector])
        return YES;
    
    if ([self.delegate respondsToSelector:aSelector])
        return YES;
    
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.delegate respondsToSelector:aSelector])
        return self.delegate;
    
    // Always call parent object for default
    return [super forwardingTargetForSelector:aSelector];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // Make sure that we scroll to the nearest tick mark on the dial.
    *targetContentOffset = [self scrollToOffset:(*targetContentOffset)];
    
    if ([self.delegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
        
        [self.delegate scrollViewWillEndDragging:scrollView
                                    withVelocity:velocity
                             targetContentOffset:targetContentOffset];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if ([self.delegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.delegate scrollViewDidScroll:scrollView];
}
- (CGFloat)currentValue
{
    NSString *value = [NSString stringWithFormat:@"%.1f", (self.rulerScrollView.contentOffset.x / self.scaleImageWidth + self.minValue)];
    return [value doubleValue];
}

@end

