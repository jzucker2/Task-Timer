//
//  TaskInfo.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 11/11/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TaskDetails;

@interface TaskInfo : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * isToday;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * isRunning;
@property (nonatomic, retain) TaskDetails *details;

@end
