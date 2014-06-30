//
//  MBDialogView.h
//  scrollol
//
//  Created by Administrateur on 27/05/2014.
//  Copyright (c) 2014 Administrateur. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	MBLDirectionNorth = 0,
	MBLDirectionSouth = 1,
	MBLDirectionWest = 2,
	MBLDirectionEast = 3
} MBLDirection;

@class MBArrowView;
@interface MBDialogView : UIView

@property (strong, nonatomic) MBArrowView *arrow;
@property (strong, nonatomic) UIView *dialog;
@property (nonatomic) NSInteger offset;
@property (nonatomic) NSInteger sizeArrow;
@property (nonatomic) BOOL isClose;
@property (nonatomic) CGRect initialFrame;
@property (nonatomic) CGPoint basePoint ;


- (CGRect)getDialogFrame;
- (instancetype)initWithFrame:(CGRect)frame andArrowDirection:(MBLDirection)direction andOffset:(NSInteger)offset;
- (void)dismiss;
- (void)show;

- (void)triggerBlockAfterAnimation:(id)block;
@end

