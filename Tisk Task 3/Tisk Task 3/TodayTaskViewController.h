//
//  TodayTaskViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TaskInfo.h"
#import "TaskTimerViewController.h"

@interface TodayTaskViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    IBOutlet UITableView *todayTableView;
    IBOutlet UILabel *metadataLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *metadataLabel;
@property (nonatomic, retain) IBOutlet UITableView *todayTableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

- (void) updateMetadataLabel;


@end