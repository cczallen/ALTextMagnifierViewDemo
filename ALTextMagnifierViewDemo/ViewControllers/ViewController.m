//
//  ViewController.m
//  ALTextMagnifierViewDemo
//
//  Created by Allen Lee on 13/6/3.
//  Copyright (c) 2013年 ALLENLEE. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self.textMagnifierView setMagnifierEnabled:YES];
	[self.textMagnifierView setActiveClasses:@[[UITextField class], [UILabel class]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews	{
	[super viewDidLayoutSubviews];
	if (self.textMagnifierView.tag == 999) {
		return;
	}
	CGPoint pt = self.view.center;
	pt.y += 55;
	[self.textMagnifierView setCenter:pt];
}

- (IBAction)demoAction:(id)sender {
	[self.textMagnifierView demoMagnifierView];
}

- (IBAction)activeClassesAction:(id)sender {
	NSArray * activeClasses = nil;
	switch ([sender tag]) {
		case 1:{
			activeClasses = @[[UITextField class], [UILabel class]];
		}break;
		case 2:{
			activeClasses = @[[UITextField class]];
		}break;
		case 3:{
			activeClasses = @[[UILabel class]];
		}break;
		default:
			break;
	}
	[self.textMagnifierView setActiveClasses:activeClasses];
}

@end
