//
//  NRingProgressControl.m
//  NRingProgressControl
//
//  Created by nunadly on 03/06/2017.
//  Copyright (c) 2017 nunadly. All rights reserved.
//

#import "NRingProgressControl.h"

#define ToRad(deg) 		( (M_PI * (deg)) / 180.0 )
#define ToDeg(rad)		( (180.0 * (rad)) / M_PI )
#define SQR(x)			( (x) * (x) )

@interface NRingProgressControl ()

@property (strong, nonatomic) CAShapeLayer *circle;
@property (strong, nonatomic) CAShapeLayer *underCircle;
@property (strong, nonatomic) CALayer *handleHostLayer;
@property (strong, nonatomic) CALayer *handle;
@end


@implementation NRingProgressControl

- (instancetype) initWithFrame : (CGRect) frame
{
    if ((self = [super initWithFrame : frame])) {
        
        [self setUp];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        [self setUp];
    }
    return self;
}


- (void) setUp
{
    self.backgroundColor = [UIColor whiteColor];
    
    _radius = 0.f;
    _radiusBall = 10.f;
    _strokeWidth = 5.f;
    _colorStroke = [UIColor grayColor];
    _colorUnderStroke = [UIColor lightGrayColor];
    _progress = 0.f;
    
    _duration = 2.f;
    
}

- (void) setRadius:(CGFloat)radius
{
    _radius = radius;
}

- (void) setDuration:(CGFloat)duration
{
    _duration = duration;
}

- (void) setProgress:(CGFloat)progress
{
    _progress = progress;
}

- (void) setRadiusBall:(CGFloat)radiusBall
{
    _radiusBall = radiusBall;
}

- (void) setColorStroke:(UIColor *)colorStroke
{
    _colorStroke = colorStroke;
}

- (void) setStrokeWidth:(CGFloat)strokeWidth
{
    _strokeWidth = strokeWidth;
}

- (void) setColorUnderStroke:(UIColor *)colorUnderStroke
{
    _colorUnderStroke = colorUnderStroke;
}


- (void) drawRect:(CGRect)rect
{
    if (!_radius)
        _radius = MIN( CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))/2.f;
    
    CGFloat width = _radius*2.0f;

    CGPoint pt = CGPointMake((CGRectGetWidth(self.bounds)-width)/2,
                             (CGRectGetHeight(self.bounds)-width)/2);

    _underCircle = [CAShapeLayer layer];
    _underCircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(pt.x, pt.y, width, width) cornerRadius:_radius].CGPath;
    
    _underCircle.fillColor = [UIColor clearColor].CGColor;
    _underCircle.strokeColor = _colorUnderStroke.CGColor;
    _underCircle.lineWidth = _strokeWidth;
    _underCircle.strokeStart = 0;
    
    [self.layer addSublayer:_underCircle];
    
    _circle = [CAShapeLayer layer];
    _circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(pt.x, pt.y, width, width) cornerRadius:_radius].CGPath;
    _circle.fillColor = [UIColor clearColor].CGColor;
    _circle.strokeColor = _colorStroke.CGColor;
    _circle.lineWidth = _strokeWidth;
    _circle.strokeStart = 0;
    _circle.strokeEnd = _progress;
    

    [self.layer addSublayer:_circle];
    
    
    CALayer *aLayer = [CALayer layer];
    aLayer.bounds = CGRectMake(0, 0,
                               width+_strokeWidth, width+_strokeWidth);
    aLayer.position = CGPointMake(pt.x+width/2, pt.y+width/2);
    aLayer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    
    CGFloat innerRadius = sqrt(SQR(_radius) + SQR(_radius));
    _handleHostLayer = [CALayer layer];
    _handleHostLayer.bounds = CGRectMake(0, 0,
                                         innerRadius, innerRadius);
    _handleHostLayer.position = CGPointMake(CGRectGetMaxX(aLayer.bounds) - (width+_strokeWidth)/2.0, CGRectGetMaxY(aLayer.bounds) - (width+_strokeWidth)/2.0);
    
    [aLayer addSublayer:_handleHostLayer];
    [self.layer addSublayer:aLayer];
    
    _handle = [CALayer layer];
    _handle.bounds = CGRectMake(0, 0, _radiusBall*2, _radiusBall*2);
    _handle.cornerRadius = _radiusBall;
    _handle.borderWidth = _strokeWidth;
    _handle.borderColor = _colorStroke.CGColor;
    _handle.backgroundColor = self.backgroundColor.CGColor;
    _handle.masksToBounds = NO;
    _handle.rasterizationScale = [UIScreen mainScreen].scale;
    _handle.shouldRasterize = YES;
    
    [_handleHostLayer addSublayer:_handle];
    
    if (_progress) {
        _handleHostLayer.transform = CATransform3DMakeRotation(MIN( MAX(ToRad(360.f*_progress), 0.0), 2.0*M_PI), 0, 0, 1);
        _circle.strokeEnd = _progress;
    }
    
}

- (void) animateProgress:(CGFloat) progress
{
    
    _progress = progress;
    
    CGFloat handleTarget = ToRad(360.f*_progress);
    _circle.strokeEnd = _progress;
    
    CABasicAnimation *basciAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basciAnimation.fromValue = @(_circle.strokeStart);
    basciAnimation.toValue = @(_progress);
    basciAnimation.duration = _duration;
    basciAnimation.fillMode = kCAFillModeForwards;
    basciAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_circle addAnimation:basciAnimation forKey:@"strokeEnd"];
    
    
    _handleHostLayer.transform = CATransform3DMakeRotation(MIN( MAX(handleTarget, 0.0), 2.0*M_PI), 0, 0, 1);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.fromValue = @(0.0);
    rotationAnimation.toValue = @( MIN( MAX(handleTarget, 0.0), 2.0*M_PI) );
    rotationAnimation.duration = _duration;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_handleHostLayer addAnimation:rotationAnimation forKey:@"transform.rotation"];
}


@end
