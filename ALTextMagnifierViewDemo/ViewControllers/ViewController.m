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
	pt.y += 50;
	[self.textMagnifierView setCenter:pt];
}

- (IBAction)demoAction:(id)sender {
	[self.textMagnifierView demoMagnifierView];
}

@end
