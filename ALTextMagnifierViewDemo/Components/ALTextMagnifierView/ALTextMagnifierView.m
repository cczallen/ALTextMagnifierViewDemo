//
//  ALTextMagnifierView.m
//  
//
//  Created by Allen Lee on 13/6/3.
//  
//

#import <QuartzCore/QuartzCore.h>
#import "ALTextMagnifierView.h"
#import "UIViewAdditions.h"

#define TAGForMagnifierLabel 8376
#define TAGForColumnNameLabel 8375
#define OffwhiteColor [UIColor colorWithWhite:1.000 alpha:0.970]

#pragma mark - ALTextMagnifierView
@interface ALTextMagnifierView ()
- (UILabel *)creatMagnifierLabel	;
- (void)removeMagnifierLabel;
- (UILabel *)getLabelByPoint:(CGPoint)pt	;
@end


@implementation ALTextMagnifierView
- (BOOL)isMagnifierEnabled		{
	return _magnifierEnabled;
}

- (UILabel *)magnifierLabel	{
	UILabel * label = (UILabel *)[self viewWithTag:TAGForMagnifierLabel];
	return label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[self myInit];
    }
    return self;
}

-(void)awakeFromNib
{
	[super awakeFromNib];
	// Initialization code
	[self myInit];
}

-(void)myInit	{
	//	[super myInit];
	
	//Default Settings
	[self setMagnifierEnabled:NO];
	[self setFontForMagnifier:[UIFont fontWithName:@"Futura" size:34]];
	[self setTextColorForMagnifier:[UIColor blackColor]];
	[self setBackgroundColorForMagnifier:OffwhiteColor];
	[self setBorderColorForMagnifier:[UIColor grayColor]];
	[self setBorderWidthForMagnifier:3];
	[self setOffsetForMagnifier:UIOffsetMake(0, -48)];
	[self setTextAlignmentForMagnifier:NSTextAlignmentCenter];
	[self setDurationForMagnifierShow:2.5];
	
}

- (UILabel *)creatMagnifierLabel		{
	UILabel *label = [[UILabel alloc] init];
	[label.layer setBorderColor:self.borderColorForMagnifier.CGColor];
	[label.layer setBorderWidth:self.borderWidthForMagnifier];
	[label.layer setMasksToBounds:NO];
	[label.layer setShadowColor:[UIColor blackColor].CGColor];
	[label.layer setShadowOffset:CGSizeMake(5, 5)];
	[label.layer setShadowRadius:7];
	[label.layer setShadowOpacity:0.9];
	[label setTag:TAGForMagnifierLabel];
	[label setFont:self.fontForMagnifier];
	[label setTextColor:self.textColorForMagnifier];
	[label setTextAlignment:self.textAlignmentForMagnifier];
	[label setBackgroundColor:self.backgroundColorForMagnifier];
	
	[label setAdjustsFontSizeToFitWidth:YES];
	[label setMinimumScaleFactor:0.2];
	
	return label;
}

- (UITextField *)getTextFieldByTouch:(UITouch *)touch	{
	CGPoint pt = [touch locationInView:self];
	UITextField * tf = nil;
	for (UIView * subView in self.subviews) {
		if (CGRectContainsPoint(subView.frame, pt) && [subView isKindOfClass:UITextField.class]) {
			tf = (UITextField *)subView;		break;
		}
	}
	return tf;
}

- (UILabel *)getLabelByPoint:(CGPoint)pt		{
	UILabel * lb = nil;
	for (UIView * subView in self.subviews) {
		if (CGRectContainsPoint(subView.frame, pt) && [subView isKindOfClass:UILabel.class]) {
			lb = (UILabel *)subView;		break;
		}
	}
	return lb;
}


#pragma mark - touches events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event	{
	[super touchesBegan:touches withEvent:event];
	if (!self.isMagnifierEnabled) {
		return;
	}
	//pass
	[self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event	{
	[super touchesMoved:touches withEvent:event];
	if (!self.isMagnifierEnabled) {
		return;
	}
	
	CGPoint pt = [[touches anyObject] locationInView:self];
	UITextField * tf = [self getTextFieldByTouch:[touches anyObject]];
	
	UILabel * label = self.magnifierLabel;
	if ([[tf text] length] >0) {
		BOOL isInitMagnifier = (label == nil);
		if (isInitMagnifier) {
			label = [self creatMagnifierLabel];
			[self addSubview:label];		[label moveToSuperviewsCenter];
		}
		[label setText:tf.text];
		
		//set frame
		[label sizeToFit];
		CGRect frame = CGRectInset(label.frame, -10, -5);
		frame.size.width = MIN(frame.size.width, self.width -10);
		[label setFrame:frame];
		
		pt.x += self.offsetForMagnifier.horizontal;
		pt.y += self.offsetForMagnifier.vertical;
		CGFloat halfWidth = label.width*0.5;
		if (pt.x + halfWidth > label.superview.width-5) {
			pt.x = label.superview.width -halfWidth-5;
		}else if (pt.x < halfWidth+5)	{
			pt.x = halfWidth+5;
		}
		if (pt.y < label.height*0.5) {
			pt.y = label.height*0.5;
		}
		[label setCenter:pt];
		
		//show
		if (isInitMagnifier) {	// || label.alpha <0.1
			CGRect frame = label.frame;
			[label setFrame:tf.frame];
			[label.layer setBorderWidth:0];
			[label setAlpha:0.75];
			
			[UIView animateWithDuration:0.16 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
				[label setFrame:frame];
				[label setAlpha:1];
			}completion:^(BOOL finished) {
				[label.layer setBorderWidth:self.borderWidthForMagnifier];
			}];
		}else	{
			[label setAlpha:1];
		}
		
	}else	{
		
		[UIView animateWithDuration:0.2 animations:^(void) {
			[label setAlpha:0];
		}];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event	{
	[super touchesEnded:touches withEvent:event];
	[self removeMagnifierLabel];
	
	UITextField * tf = [self getTextFieldByTouch:[touches anyObject]];
	if (tf == nil) {
		[self.magnifierLabel removeFromSuperviewWithAnimation];
	}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event	{
	[super touchesCancelled:touches withEvent:event];
	[self removeMagnifierLabel];
}

- (void)removeMagnifierLabel	{
	if (!self.isMagnifierEnabled) {
		return;
	}
	
	UIView * view = self.magnifierLabel;
	
	[UIView cancelPreviousPerformRequestsWithTarget:view selector:@selector(removeFromSuperviewWithAnimation) object:nil];
	[view performSelector:@selector(removeFromSuperviewWithAnimation) withObject:nil afterDelay:self.durationForMagnifierShow];
}

@end



#pragma mark - ResultTextField
@interface ActualFontSizeTextField ()
-(void)myInit;
@end

@implementation ActualFontSizeTextField

- (id)initWithFrame:(CGRect)frame	{
    self = [super initWithFrame:frame];
    if (self) {
		[self myInit];
    }
    return self;
}
-(void)awakeFromNib	{
	[super awakeFromNib];
	[self myInit];
}

-(void)myInit	{
}


- (void)setText:(NSString *)text		{
	[super setText:text];
	if ([text length]==0) {
		return;
	}
	
	CGFloat actualFontSize;
	UITextField * tf = self;
	[[tf text] sizeWithFont:[tf font]
				minFontSize:[tf minimumFontSize]
			 actualFontSize:&actualFontSize
				   forWidth:[tf bounds].size.width
			  lineBreakMode:NSLineBreakByTruncatingTail];
	
	if (actualFontSize < self.font.pointSize) {
		UIFont * actualFont = [UIFont fontWithName:self.font.familyName size:(int)actualFontSize];
		[self setFont:actualFont];
	}
}

@end



#pragma mark - UIView (ALViewUtilities)
@implementation UIView (ALViewUtilities)
-(void)moveToSuperviewsCenter	{
	
	if (self.superview == nil) {
		NSLog(@"LOG:  self.superview == nil]");
		return;
	}
	
	CGRect rect = self.frame;
	rect.origin.x = (self.superview.frame.size.width -self.frame.size.width) *0.5;
	rect.origin.y = (self.superview.frame.size.height -self.frame.size.height) *0.5;
	
	[self setFrame:rect];
}

-(void)removeFromSuperviewWithAnimation	{
	[self removeFromSuperviewWithAnimation:0.28];
}
- (void)removeFromSuperviewWithAnimation:(NSTimeInterval)duration	{
	[UIView animateWithDuration:duration animations:^(void) {
		[self setAlpha:0];
	}completion:^(BOOL finished) {
		[self removeFromSuperview];
	}];
}
@end