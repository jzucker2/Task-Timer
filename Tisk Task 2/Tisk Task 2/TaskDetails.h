//
//  TaskDetails.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/2/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TaskInfo;

@interface TaskDetails : NSManagedObject

@property (nonatomic, retain) NSDate * completionDate;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * specifics;
@property (nonatomic, retain) NSNumber * elapsedTime;
@property (nonatomic, retain) NSDate * projectedEndTime;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) TaskInfo *info;

@end
