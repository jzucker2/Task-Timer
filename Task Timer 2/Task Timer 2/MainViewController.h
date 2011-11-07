//
//  MainViewController.h
//  Task Timer 2
//
//  Created by Jordan Zucker on 11/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "FlipsideViewController.h"
#import "AllTasksViewController.h"
#import "EveryTaskViewController.h"
#import <CoreData/CoreData.h>

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>
{
    IBOutlet UIButton *allTasksButton;
    IBOutlet UIButton *todayButton;
}
@property (nonatomic, retain) IBOutlet UIButton *allTasksButton;
@property (nonatomic, retain) IBOutlet UIButton *todayButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)showInfo:(id)sender;
- (IBAction)showToday:(id)sender;
- (IBAction)showAllTasks:(id)sender;

@end
