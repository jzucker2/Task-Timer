//
//  TodayTaskViewController.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/8/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TodayTaskViewController : UITableViewController <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;	    
    NSManagedObjectContext *addingManagedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;

//- (IBAction) addTask;
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end
