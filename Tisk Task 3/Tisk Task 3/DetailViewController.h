//
//  DetailViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountdownFormatter.h"

@class TaskInfo, EditingViewController;

@interface DetailViewController : UITableViewController
{
    TaskInfo *taskInfo;
    NSUndoManager *undoManager;
    UISwitch *todaySwitch;
}

@property (nonatomic, retain) UISwitch *todaySwitch;
@property (nonatomic, retain) TaskInfo *taskInfo;
@property (nonatomic, retain) NSUndoManager *undoManager;

- (void) setUpUndoManager;
- (void) cleanUpUndoManager;
- (void) updateRightBarButtonItemState;

- (IBAction)todaySwitchValueChanged:(id)sender;

@end
