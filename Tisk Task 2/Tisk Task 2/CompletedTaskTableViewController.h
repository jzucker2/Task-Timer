//
//  CompletedTaskTableViewController.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/2/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedTaskTableViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;

}
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
