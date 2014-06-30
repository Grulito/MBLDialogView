//
//  MBArrowView.m
//  scrollol
//
//  Created by Administrateur on 27/05/2014.
//  Copyright (c) 2014 Administrateur. All rights reserved.
//

#import "MBArrowView.h"

@implementation MBArrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.layer.backgroundColor = [UIColor clearColor].CGColor;
		self.backgroundColor = [UIColor clearColor];
		[self setNeedsDisplay];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	int offset = self.position;
	int size = rect.size.height;
	
	int x = CGRectGetMinX(rect)+ offset;
	
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGContextBeginPath(ctx);
	
	if (self.direction == MBLDirectionNorth) {
		CGContextMoveToPoint   (ctx, x, CGRectGetMinY(rect));  // top
		CGContextAddLineToPoint(ctx, x+size , CGRectGetMaxY(rect));  // mid right
		CGContextAddLineToPoint(ctx, x-size, CGRectGetMaxY(rect));  //
	}
	else if (self.direction == MBLDirectionSouth) {
		CGContextMoveToPoint   (ctx, x, CGRectGetMaxY(rect));  // top left
		CGContextAddLineToPoint(ctx, x+size , CGRectGetMinY(rect));  // mid right
		CGContextAddLineToPoint(ctx, x-size, CGRectGetMinY(rect));  //
	}
	else if (self.direction == MBLDirectionWest) {
		size = rect.size.width;
		CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect)+offset);  // top left
		CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect)+offset+size);  // mid right
		CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect)+offset-size);  //
	}
	else if (self.direction == MBLDirectionEast) {
		size = rect.size.width;
		CGContextMoveToPoint   (ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect)+offset);  // top left
		CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect)+offset+size);  // mid right
		CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMinY(rect)+offset-size);  //
	}
	
	
	CGContextClosePath(ctx);
	CGContextSetRGBFillColor(ctx, 1, 1, 1, 1);
	CGContextFillPath(ctx);
}

- (CGPoint)getArrowPosition
{
	CGPoint pos;
	if (self.direction == MBLDirectionNorth) {
		pos = CGPointMake(self.position, 0);
	}
	else if (self.direction == MBLDirectionSouth) {
		pos = CGPointMake(self.position, self.superview.frame.size.height);
	}
	else if (self.direction == MBLDirectionWest) {
	}
	else if (self.direction == MBLDirectionEast) {
	}
	return pos;
}

@end
