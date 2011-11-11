//
//  TaskDetails.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 11/11/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TaskInfo;

@interface TaskDetails : NSManagedObject

@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSString * details;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSDate * completionDate;
@property (nonatomic, retain) NSNumber * elapsedTime;
@property (nonatomic, retain) TaskInfo *info;

@end
