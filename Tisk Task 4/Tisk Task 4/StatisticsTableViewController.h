//
//  StatisticsTableViewController.h
//  Tisk Task 4
//
//  Created by Jordan Zucker on 12/22/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MetaDataWrapper.h"

@interface StatisticsTableViewController : UITableViewController
{
    NSArray *notificationsArray;
    NSArray *allTasksArray;
    NSArray *todayTasksArray;
    NSArray *historyArray;
    NSDictionary *metadata;
    
    NSArray *notificationsKeysArray;
    NSArray *allTasksKeysArray;
    NSArray *todayTasksKeysArray;
    NSArray *historyKeysArray;
}
@property (nonatomic, retain) NSArray *notificationsKeysArray;
@property (nonatomic, retain) NSArray *allTasksKeysArray;
@property (nonatomic, retain) NSArray *todayTasksKeysArray;
@property (nonatomic, retain) NSArray *historyKeysArray;
@property (nonatomic, retain) NSArray *notificationsArray;
@property (nonatomic, retain) NSArray *allTasksArray;
@property (nonatomic, retain) NSArray *todayTasksArray;
@property (nonatomic, retain) NSArray *historyArray;
@property (nonatomic, retain) NSDictionary *metadata;

@end
