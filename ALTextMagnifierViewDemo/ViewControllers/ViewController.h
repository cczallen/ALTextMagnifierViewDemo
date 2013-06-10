//
//  ViewController.h
//  ALTextMagnifierViewDemo
//
//  Created by Allen Lee on 13/6/3.
//  Copyright (c) 2013年 ALLENLEE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALTextMagnifierView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet ALTextMagnifierView *textMagnifierView;
- (IBAction)demoAction:(id)sender;
- (IBAction)activeClassesAction:(id)sender;

@end
