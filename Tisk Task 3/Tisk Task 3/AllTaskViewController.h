//
//  AllTaskViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfo.h"
#import "AddViewController.h"
#import "DetailViewController.h"

@interface AllTaskViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, AddViewControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    IBOutlet UITableView *allTaskTableView;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *addingManagedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) IBOutlet UITableView *allTaskTableView;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (IBAction) addTask;

- (IBAction)todaySwitchValueChanged:(id)sender;


@end
