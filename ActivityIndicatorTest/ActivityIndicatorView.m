//
//  ActivityIndicatorView.m
//  HubTest
//
//  Created by caoZhenWei on 15/5/5.
//  Copyright (c) 2015年 caoZhenWei. All rights reserved.
//

#import "ActivityIndicatorView.h"

float Degrees2Radians(float degrees) { return degrees * M_PI / 180; }

@interface ActivityIndicatorView ()

@property (nonatomic, strong) UIView *hudView;
@property (nonatomic, strong) UIImageView *imageView;
@property (readwrite, nonatomic) CGFloat radius;
@property (readwrite, nonatomic) CGFloat delay;
@property (readwrite, nonatomic) CGFloat duration;
@property (readwrite, nonatomic) BOOL isAnimating;

@end

@implementation ActivityIndicatorView

#pragma mark -
#pragma mark - Initializations

- (id)initWithView:(UIView *)view {
    return [self initWithFrame:view.bounds];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
        [self initSubviews];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initSubviews {
    
}

- (void)setupDefaults {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.radius = 10;
    self.delay = 0.2;
    self.duration = 0.8;
}

- (NSArray *)createCircles {
    NSMutableArray *shapesArray = [NSMutableArray array];
    CGFloat centerX = CGRectGetWidth(_hudView.bounds)*0.5 * 0.5;
    CGFloat centerY = CGRectGetHeight(_hudView.bounds)*0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    
    for (int i = 0; i < 8; i++) {
        CGFloat x = center.x + self.radius*2*sin(Degrees2Radians((2-i)*45));
        CGFloat y = center.y + self.radius*2*cos(Degrees2Radians((2-i)*45));
        CGRect rect = CGRectMake(x, y, self.radius * 2, self.radius * 2);
        
        UIView *view = [[UIView alloc] initWithFrame:rect];
        [view setTransform:CGAffineTransformMakeScale(0, 0)];
        view.layer.cornerRadius = self.radius;
        view.backgroundColor = [UIColor redColor];
        view.center = CGPointMake(x, y);
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [view.layer addAnimation:[self createAnimationWithDuration:self.duration delay:(i * self.delay)] forKey:@"scale"];
        [shapesArray addObject:view.layer];
    }
    
    return shapesArray;
}

- (CABasicAnimation *)createAnimationWithDuration:(CGFloat)duration delay:(CGFloat)delay {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.delegate = self;
    anim.fromValue = [NSNumber numberWithFloat:0.0f];
    anim.toValue = [NSNumber numberWithFloat:0.5f];
    anim.autoreverses = YES;
    anim.duration = duration;
    anim.removedOnCompletion = NO;
    anim.beginTime = CACurrentMediaTime()+delay;
    anim.repeatCount = MAXFLOAT;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return anim;
}

- (void)addCircles {
    NSArray *array = [self createCircles];
    for (CAShapeLayer *layer in array) {
        [_hudView.layer addSublayer:layer];
    }
}

- (void)removeCircles {
    [self.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
}

- (void)addIconImageView {
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectZero];
    _hudView = hudView;
    _hudView.backgroundColor = [UIColor yellowColor];
    [self addSubview:_hudView];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.image = [UIImage imageNamed:@"ico_logo.jpg"];
    [_hudView addSubview:_imageView];
}

- (void)layout {
    CGFloat hudWidth = 200;
    CGFloat hudHeight = 80;
    self.hudView.frame = CGRectMake((CGRectGetWidth(self.bounds)-hudWidth)*0.5, (CGRectGetHeight(self.bounds)-hudHeight)*0.5, hudWidth, hudHeight);
    _imageView.frame = CGRectMake(self.hudView.frame.size.width/2, 0, 100, self.hudView.frame.size.height);
}

#pragma mark -
#pragma mark - Public Methods

- (void)startAnimating {
    if (!self.isAnimating) {
        [self addIconImageView];
        [self layout];
        [self addCircles];
        self.hidden = NO;
        self.isAnimating = YES;
    }
}

- (void)stopAnimating {
    if (self.isAnimating) {
        [self removeCircles];
        self.hidden = YES;
        self.isAnimating = NO;
    }
}

@end
