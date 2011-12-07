//
//  TaskTimerViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfo.h"
#import "CountdownFormatter.h"

@interface TaskTimerViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *durationLabel;
    IBOutlet UILabel *countdownLabel;
    IBOutlet UIButton *timerButton;
    IBOutlet UILabel *elapsedLabel;
    NSTimer *countdownTimer;
    TaskInfo *taskInfo;
    double timeLeft;
    IBOutlet UITextView *specificsView;
    IBOutlet UIButton *finishEarlyButton;
    CountdownFormatter *timerFormatter;
}

@property (nonatomic, retain) CountdownFormatter *timerFormatter;
@property (nonatomic, retain) IBOutlet UIButton *finishEarlyButton;
@property (nonatomic, retain) IBOutlet UITextView *specificsView;
@property (nonatomic, retain) IBOutlet UILabel *elapsedLabel;
@property (nonatomic, retain) TaskInfo *taskInfo;
@property (nonatomic, retain) NSTimer *countdownTimer;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UILabel *durationLabel;
@property (nonatomic, retain) IBOutlet UILabel *countdownLabel;
@property (nonatomic, retain) IBOutlet UIButton *timerButton;

- (IBAction)timerButtonAction:(id)sender;

- (IBAction)finishEarlyAction:(id)sender;

- (void) startTimer;

- (void) stopTimer;

- (void) finishTimer;

- (void) endTimer;

- (void) continueTimer;

- (void) updateCountdownLabel;


@end
