//
//  FlipsideViewController.h
//  Task Timer 2
//
//  Created by Jordan Zucker on 11/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController
{
    UIButton *emailButton;
}

@property (nonatomic, retain) IBOutlet UIButton *emailButton;
@property (assign, nonatomic) IBOutlet id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
