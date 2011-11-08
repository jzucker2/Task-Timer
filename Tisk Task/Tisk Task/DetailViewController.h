//
//  DetailViewController.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingViewController.h"
@class Task;

@interface DetailViewController : UITableViewController
{
    Task *task;
    NSUndoManager *undoManager;
    UISwitch *mySwitch;
}
@property (nonatomic, retain) UISwitch *mySwitch;
@property (nonatomic, retain) Task *task;
@property (nonatomic, retain) NSUndoManager *undoManager;

- (void)setUpUndoManager;
- (void)cleanUpUndoManager;
- (void)updateRightBarButtonItemState;

- (IBAction)switchValueChanged:(id)sender;

@end
