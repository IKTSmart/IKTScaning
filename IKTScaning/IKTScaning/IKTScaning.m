//
//  IKTScaning.m
//  IKTScaning
//
//  Created by bcikt on 2018/10/17.
//  Copyright © 2018 bcikt. All rights reserved.
//

#import "IKTScaning.h"

@interface IKTScaning ()
{
    BOOL _startAnimation;
}

@property (nonatomic, assign) CGFloat angle;
@property (nonatomic, assign) BOOL clockwise;

@end

@implementation IKTScaning


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.angle = 360;
    self.clockwise = YES;
    CGFloat radius = self.frame.size.width/2.0;
    CGPoint center = CGPointMake(radius, radius);
    UIColor *startColor = [UIColor colorWithRed:0x90/255.0 green:0xc9/255.0 blue:0xfa/255.0 alpha:1];
    UIColor *endColor = [UIColor colorWithRed:0x21/255.0 green:0x93/255.0 blue:0xf4/255.0 alpha:1.0];
    const CGFloat *startColorComponents = CGColorGetComponents(startColor.CGColor);
    const CGFloat *endColorComponents = CGColorGetComponents(endColor.CGColor);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat R, G, B, A;
    for (int i = 0; i <= self.angle; i++)
    {
        CGFloat ratio = (self.clockwise?(self.angle - i):i)/self.angle;
        R = startColorComponents[0] - (startColorComponents[0] - endColorComponents[0]) * ratio;
        G = startColorComponents[1] - (startColorComponents[1] - endColorComponents[1]) * ratio;
        B = startColorComponents[2] - (startColorComponents[2] - endColorComponents[2]) * ratio;
        A = startColorComponents[3] - (startColorComponents[3] - endColorComponents[3]) * ratio;

        UIColor *startColor = [UIColor colorWithRed:R green:G blue:B alpha:A];

        CGContextSetFillColorWithColor(context, startColor.CGColor);
        CGContextSetLineWidth(context, 0);
        CGContextMoveToPoint(context, center.x, center.y);
        CGContextAddArc(context, center.x, center.y, radius, i * M_PI / 180, (i + (self.clockwise?-1:1)) * M_PI / 180, self.clockwise);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

- (void)start{
    
    _startAnimation = YES;
    [self spinWithOptions:UIViewAnimationOptionCurveEaseIn];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:1.0 animations:^{
        
        [weakSelf setAlpha:1];
        [weakSelf setHidden:NO];
    }];
}

- (void)end{
    
    _startAnimation = NO;
}

- (void)spinWithOptions:(UIViewAnimationOptions)options {
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration: 0.3f
                          delay: 0.0f
                        options: options
                     animations: ^{
                         weakSelf.transform = CGAffineTransformRotate(weakSelf.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished) {
                             if (self->_startAnimation) {
                                 [weakSelf spinWithOptions: UIViewAnimationOptionCurveLinear];
                             } else if (options != UIViewAnimationOptionCurveEaseOut) {
                                 [weakSelf spinWithOptions: UIViewAnimationOptionCurveEaseOut];
                             } else{
                                 [UIView animateWithDuration:.3 animations:^{
                                     [weakSelf setAlpha:0];
                                 } completion:^(BOOL finished) {
                                     [weakSelf setHidden:YES];
                                 }];
                             }
                         }
                     }];
}

@end
