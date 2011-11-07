//
//  EveryTaskViewController.h
//  Task Timer 2
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "AddViewController.h"

@interface EveryTaskViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;	    
    NSManagedObjectContext *addingManagedObjectContext;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UIButton *backButton;
    IBOutlet UITableView *taskTableView;
}

@property (nonatomic, retain) IBOutlet UITableView *taskTableView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;
@property (nonatomic, retain) IBOutlet UIButton *backButton;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;

- (IBAction)back:(id)sender;
- (IBAction)addTask:(id)sender;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
