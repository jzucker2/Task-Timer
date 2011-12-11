//
//  StatisticsTableViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/11/11.
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
}

@property (nonatomic, retain) NSArray *notificationsArray;
@property (nonatomic, retain) NSArray *allTasksArray;
@property (nonatomic, retain) NSArray *todayTasksArray;
@property (nonatomic, retain) NSArray *historyArray;
@property (nonatomic, retain) NSDictionary *metadata;

@end
