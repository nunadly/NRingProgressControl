//
//  NRingProgressControl.h
//  NRingProgressControl
//
//  Created by nunadly on 03/06/2017.
//  Copyright (c) 2017 nunadly. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface NRingProgressControl : UIView

@property (nonatomic) IBInspectable CGFloat radiusBall;
@property (nonatomic) IBInspectable CGFloat radius;
@property (nonatomic) IBInspectable CGFloat strokeWidth;
@property (nonatomic) IBInspectable CGFloat duration;

@property (nonatomic) IBInspectable CGFloat progress;

@property (nonatomic, strong) IBInspectable UIColor* colorStroke;
@property (nonatomic, strong) IBInspectable UIColor* colorUnderStroke;


- (void) animateProgress:(CGFloat) progress;

@end
