//
//  GSBBubbleCell.m
//  Xiph
//
//  Created by Gareth Bestor on 2/17/16.
//  Copyright (c) 2016 tiritea. All rights reserved.
//

#import "GSBBubbleCell.h"

@implementation GSBBubbleCell

static const float RADIUS = 15.; // bubble corner radius
static const float MARGIN = 5.; // gap above and below bubble
static const float RADIUS2X = RADIUS*2.;
static const float MINHEIGHT = RADIUS2X + MARGIN*2.;

- (void)layoutSubviews
{
    CGFloat dx = 10.; // inset for tail
    CGFloat indent = self.indentationLevel * self.indentationWidth;
    
    // Perform layout for RHS bubble - since that's the default cell layout - and flip afterwards for LHS if needed
    [super layoutSubviews];
    self.imageView.frame = CGRectOffset(self.imageView.frame, indent, 0.); // default layout doesn't indent imageView, so do it manually

    // Draw mask for a RHS bubble
    CGRect scratch, frame, corners;
    CGRectDivide(self.contentView.frame, &scratch, &frame, indent, CGRectMinXEdge); // cut off LHS indentation box
    frame = CGRectInset(frame, 0., MARGIN);
    corners = CGRectMake(frame.origin.x+RADIUS, frame.origin.y+RADIUS, frame.size.width-RADIUS2X-dx, frame.size.height-RADIUS2X); // corner centers

    // Draw bubble starting from top-right corner going counter-clockwise
    UIBezierPath *path = UIBezierPath.new;
    [path addArcWithCenter:CGPointMake(CGRectGetMaxX(corners), CGRectGetMinY(corners))
                    radius:RADIUS
                startAngle:0 endAngle:-M_PI_2 clockwise:false];
    [path addArcWithCenter:CGPointMake(CGRectGetMinX(corners), CGRectGetMinY(corners))
                    radius:RADIUS
                startAngle:-M_PI_2 endAngle:M_PI clockwise:false];
    [path addArcWithCenter:CGPointMake(CGRectGetMinX(corners), CGRectGetMaxY(corners))
                    radius:RADIUS
                startAngle:M_PI endAngle:M_PI_2 clockwise:false];
    [path addArcWithCenter:CGPointMake(CGRectGetMaxX(corners), CGRectGetMaxY(corners))
                    radius:RADIUS
                startAngle:M_PI_2 endAngle:M_PI_4 clockwise:false]; // 45deg
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame))]; // bottom right corner tail
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(frame)-dx, CGRectGetMaxY(corners))];
    [path closePath];
 
    // Flip layout if LHS bubble
    if (_bubbleStyle == GSBBubbleCellStyleLeft) {
        CGFloat offset = -indent+dx;
        self.textLabel.frame = CGRectOffset(self.textLabel.frame, offset, 0.);
        self.imageView.frame = CGRectOffset(self.imageView.frame, offset, 0.);
        [path applyTransform:CGAffineTransformMake(-1., 0., 0., 1., frame.size.width+indent, 0.)]; // transform = scaleX + translateX
    }
    
    CAShapeLayer *shape = CAShapeLayer.new;
    shape.path = path.CGPath;
    self.contentView.layer.mask = shape;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize minsize = [super sizeThatFits:size];
    if (minsize.height < MINHEIGHT) minsize.height = MINHEIGHT; // enforce minimum height to fit radius
    return minsize;
}

@end
