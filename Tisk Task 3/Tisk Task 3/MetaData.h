//
//  MetaData.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MetaData : NSManagedObject

@property (nonatomic, retain) NSNumber * numberActiveAlarms;
@property (nonatomic, retain) NSNumber * numberActiveReminders;
@property (nonatomic, retain) NSNumber * numberAllTasks;
@property (nonatomic, retain) NSNumber * overallTasksFinished;
@property (nonatomic, retain) NSNumber * overallTimeSpent;
@property (nonatomic, retain) NSNumber * tasksFinishedToday;
@property (nonatomic, retain) NSNumber * timeLeftAllTasks;
@property (nonatomic, retain) NSNumber * timeLeftToday;
@property (nonatomic, retain) NSNumber * timeSpentToday;

@end
