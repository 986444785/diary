//
//  CircleTools.m
//  YUNSJ
//
//  Created by 配得好家居 on 2017/6/22.
//  Copyright © 2017年 Cloud. All rights reserved.
//

#import "CircleTools.h"

@implementation CircleTools

- (void)drawRect:(CGRect)rect
{
    CGAffineTransform transform = CGAffineTransformIdentity;
    self.transform = CGAffineTransformRotate(transform, -M_PI / 2);
    //创建path
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加圆到path 
    //圆描线宽度
    CGPoint center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    [path addArcWithCenter:center radius:_radius - _lineWidth startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    
    [path setLineWidth:_lineWidth];
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    [_beginColor setStroke];
    [_endColor setFill];
    // 描边和填充 
    [path stroke];
    [path fill];
      
     
    
    //创建第二个path
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    // 添加圆到path
    [path2 addArcWithCenter:center radius:_radius - _lineWidth startAngle:0.0 endAngle:_endAngle clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    [path2 setLineWidth:_lineWidth];

    if (_needRound == YES) {
        // 设置线段的顶角样式
        path2.lineCapStyle = kCGLineCapRound;
        path2.lineJoinStyle = kCGLineJoinRound;
    }
    
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    [_endColor setStroke];
    
     
    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = rect;
//    gradientLayer.colors = @[(__bridge id)[UIColor yellowColor].CGColor,(__bridge id)[UIColor blueColor].CGColor ];
//    gradientLayer.startPoint = CGPointMake(0,0.5);
//    gradientLayer.endPoint = CGPointMake(1,0.5);
//    [self.layer addSublayer:gradientLayer];
    
    
//    [ClearColor setFill];
    
    // 描边和填充
    [path2 stroke];
    [path2 fill];
    
}

- (void)setRadius:(CGFloat)radius
{
    _radius = radius;
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
}

- (void)setEndAngle:(CGFloat)endAngle
{
    _endAngle = endAngle;
}

- (void)setBeginColor:(UIColor *)beginColor
{
    _beginColor = beginColor;
}

-(void)setEndColor:(UIColor *)endColor
{
    _endColor = endColor;
}
@end
