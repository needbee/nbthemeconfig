//
//  NBViewController.m
//  demo
//
//  Created by Josh Justice on 3/12/14.
//  Copyright (c) 2014 NeedBee. All rights reserved.
//

#import "NBViewController.h"
#import "NBThemeConfig.h"

@interface NBViewController ()

@end

@implementation NBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // simple colors and patterns
    self.label.textColor = [NBThemeConfig colorForComponent:@"mainContentText"];
    self.contentView.backgroundColor = [NBThemeConfig colorForComponent:@"mainContentBackground"];
    
    // shadow
    self.contentView.layer.shadowColor = [NBThemeConfig cgColorForComponent:@"mainContentShadow"];
    self.contentView.layer.shadowRadius = 2.0;
    self.contentView.layer.shadowOffset = CGSizeMake(0, 2.0);
    self.contentView.layer.shadowOpacity = 0.8f;
    
    // gradient
    CAGradientLayer *gradient = [[CAGradientLayer alloc] init];
    gradient.frame = self.view.bounds;
    [NBThemeConfig setGradient:gradient
               byComponentName:@"mainBackground"];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

@end
