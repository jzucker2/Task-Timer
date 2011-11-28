//
//  TaskTimerViewController.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/8/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskTimerViewController : UIViewController
{
    NSManagedObject *editedObject;
    Task *task;
    IBOutlet UIButton *timerButton;
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *durationLabel;
    BOOL isRunning;
    NSTimer *taskTimer;
    IBOutlet UILabel *timeElapsedLabel;
    IBOutlet UILabel *countdownLabel;
    double timeLeft;
}

@property (nonatomic, retain) IBOutlet UILabel *timeElapsedLabel;
@property (nonatomic, retain) IBOutlet UILabel *countdownLabel;
@property (nonatomic, retain) NSTimer *taskTimer;
@property (nonatomic, retain) NSManagedObject *editedObject;
@property (nonatomic, retain) IBOutlet UIButton *timerButton;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *durationLabel;
@property (nonatomic, retain) Task *task;


- (IBAction)handleTimer:(id)sender;

- (void) startTimer;
- (void) stopTimer;

- (void) updateCountdownLabel;

- (void) updateDatabase;

- (void)setUpUndoManager;
- (void)cleanUpUndoManager;


@end
