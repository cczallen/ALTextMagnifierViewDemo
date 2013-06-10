//
//  ALTextMagnifierView.h
//
//
//  Created by Allen Lee on 13/6/3.
//  
//

#define TouchPointInvalid CGPointMake(-1, -1)
#import <UIKit/UIKit.h>


#pragma mark - ALTextMagnifierView
@interface ALTextMagnifierView : UIView

@property (nonatomic, readonly) UILabel * magnifierLabel;

@property (nonatomic, getter = isMagnifierEnabled) BOOL magnifierEnabled;	//default: NO
@property (nonatomic, strong) 	UIFont	* fontForMagnifier;					//[UIFont fontWithName:@"Futura" size:34]
@property (nonatomic, strong) 	UIColor * textColorForMagnifier;			//[UIColor blackColor]
@property (nonatomic, strong) 	UIColor * backgroundColorForMagnifier;		//[UIColor colorWithWhite:1.000 alpha:0.970]
@property (nonatomic, strong) 	UIColor * borderColorForMagnifier;			//[UIColor grayColor]
@property (nonatomic)			CGFloat   borderWidthForMagnifier;			//3
@property (nonatomic)			UIOffset	  offsetForMagnifier;				//UIOffsetMake(0, -55)
@property (nonatomic)			NSTextAlignment  textAlignmentForMagnifier;	//NSTextAlignmentCenter
@property (nonatomic)			NSTimeInterval  durationForMagnifierShow;	//2.5
@property (nonatomic, strong) 	NSArray * activeClasses;					//@[[UITextField class], [UILabel class]]

- (void)myInit;
- (UIView *)getTextSubviewByTouch:(UITouch *)touch;

- (void)showMagnifierViewBySubview:(UIView *)subview andTouchPoint:(CGPoint)pt;
- (void)hideMagnifierView;
- (void)removeMagnifierLabel;

- (IBAction)demoMagnifierView;

@end



#pragma mark - ResultTextField
@interface ActualFontSizeTextField : UITextField

@end



#pragma mark - UIView (ALViewUtilities)
@interface UIView (ALViewUtilities)
-(void)moveToSuperviewsCenter;
-(void)removeFromSuperviewWithAnimation;
-(void)removeFromSuperviewWithAnimation:(NSTimeInterval)duration;
@end
