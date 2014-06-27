//
//  MBDialogView.m
//  scrollol
//
//  Created by Administrateur on 27/05/2014.
//  Copyright (c) 2014 Administrateur. All rights reserved.
//

#import "MBDialogView.h"
#import "MBArrowView.h"

@implementation MBDialogView

- (instancetype)initWithFrame:(CGRect)frame andArrowDirection:(MBLDirection)direction andOffset:(NSInteger)offset;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		_offset = offset;
		self.backgroundColor = [UIColor clearColor];
		_sizeArrow = (frame.size.height*4/100 + frame.size.width*4/100) /2;
		
		// arrow config
		[self _makeArrowWithFrame:frame andDirection:direction];
		_arrow.position = offset;
		_arrow.direction = direction;
		[self addSubview:_arrow];
		
		// frame config
		[self _defaultDialogWithComponentFrame:frame ColorWithArrowDirection:direction];
		[self addSubview:_dialog];
    }
    return self;
}


/* adjust the dialog frame to fit to global view - arrow frame */
- (void)_defaultDialogWithComponentFrame:(CGRect)frame ColorWithArrowDirection:(MBLDirection)direction
{
	if (direction == MBLDirectionNorth)
	{
		_dialog = [[UIView alloc] initWithFrame:CGRectMake(0, _sizeArrow, frame.size.width, frame.size.height - _sizeArrow)];
	}
	else if (direction == MBLDirectionSouth)
	{
		_dialog = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - _sizeArrow)];
	}
	else if (direction == MBLDirectionEast)
	{
		_dialog = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - _sizeArrow, frame.size.height)];
	}
	else if (direction == MBLDirectionWest)
	{
		_dialog = [[UIView alloc] initWithFrame:CGRectMake(_sizeArrow, 0, frame.size.width - _sizeArrow, frame.size.height)];
	}
	_dialog.backgroundColor = [UIColor whiteColor];
	_dialog.layer.masksToBounds = YES;
	_dialog.layer.cornerRadius = 5;
}


/*
 
|-------|	frame total
|-------|	arrow here for north pos
|		|
|		|
|_______|
 */
- (void)_makeArrowWithFrame:(CGRect)frame andDirection:(MBLDirection)direction
{
	if (direction == MBLDirectionNorth)
	{
		_arrow = [[MBArrowView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, _sizeArrow)];
	}
	else if (direction == MBLDirectionSouth)
	{
		_arrow = [[MBArrowView alloc] initWithFrame:CGRectMake(0, frame.size.height-_sizeArrow, frame.size.width, _sizeArrow)];
	}
	else if (direction == MBLDirectionEast)
	{
		_arrow = [[MBArrowView alloc] initWithFrame:CGRectMake(frame.size.width-_sizeArrow, 0, _sizeArrow, frame.size.height)];
	}
	else if (direction == MBLDirectionWest)
	{
		_arrow = [[MBArrowView alloc] initWithFrame:CGRectMake(0, 0, _sizeArrow, frame.size.height)];
	}
}

- (id)initWithFrame:(CGRect)frame
{
	return [self initWithFrame:frame andArrowDirection:MBLDirectionNorth andOffset:frame.size.width*4/100+3]; // 3 = cornerRadius
}

- (void)addSubview:(UIView *)view
{
	if (view == _dialog || view == _arrow)
	{
		[super addSubview:view];
	}
	else
	{
		[_dialog addSubview:view];
	}
}

- (CGRect)getDialogFrame
{
	return _dialog.frame;
}

- (void)dismiss
{
	CABasicAnimation *scale = [CABasicAnimation animation];
	scale.keyPath = @"transform.scale";
	scale.toValue = @0;
	scale.duration = 0.2;
	
	CABasicAnimation *positionX = [CABasicAnimation animation];
	positionX.keyPath = @"position.x";
	positionX.toValue = @35;
	positionX.duration = 0.2;
	
	CABasicAnimation *positionY = [CABasicAnimation animation];
	positionY.keyPath = @"position.y";
	positionY.toValue = @60;
	positionY.duration = 0.2;
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects:scale,positionX,positionY,nil];
	animationGroup.removedOnCompletion = NO;
	animationGroup.fillMode = kCAFillModeForwards;
	animationGroup.delegate = self;
	[animationGroup setValue:@"dismiss" forKey:@"animationID"];
	animationGroup.duration = 0.2;
	
	[self.layer addAnimation:animationGroup forKey:@"animations"];
	self.isClose = YES;
}

- (void)show;
{
	CGFloat animationDuration = 0.2;
	CABasicAnimation *scale = [CABasicAnimation animation];
	scale.keyPath = @"transform.scale";
	scale.toValue = @1;
	scale.duration = animationDuration;
	scale.removedOnCompletion = NO;
	scale.fillMode = kCAFillModeForwards;
	
	CABasicAnimation *positionX = [CABasicAnimation animation];
	positionX.keyPath = @"position.x";
	positionX.toValue = @100;
	positionX.duration = animationDuration;
	
	CABasicAnimation *positionY = [CABasicAnimation animation];
	positionY.keyPath = @"position.y";
	positionY.toValue = @210;
	positionY.duration = animationDuration;
	
	CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
	animationGroup.animations = [NSArray arrayWithObjects:scale,positionX,positionY,nil];
	animationGroup.removedOnCompletion = NO;
	animationGroup.fillMode = kCAFillModeForwards;
	animationGroup.duration = animationDuration;
	animationGroup.delegate = self;
	[animationGroup setValue:@"show" forKey:@"animationID"];
	
	[self.layer addAnimation:animationGroup forKey:@"animations"];
	self.isClose = NO;
	
	return;
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
	if ([[theAnimation valueForKey:@"animationID"] isEqual:@"dismiss"]) {
		self.layer.position = CGPointMake(40, 60);
		self.layer.transform = CATransform3DMakeScale(0, 0, 0);
	}
	if ([[theAnimation valueForKey:@"animationID"] isEqual:@"show"]) {
		self.layer.position = CGPointMake(100, 210);
		self.layer.transform = CATransform3DMakeScale(1, 1, 1);
	}
}
@end
