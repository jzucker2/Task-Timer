//
//  TaskInfo.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/5/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TaskInfo : NSManagedObject

@property (nonatomic, retain) NSDate * completionDate;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * elapsedTime;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSNumber * isRepeating;
@property (nonatomic, retain) NSNumber * isRunning;
@property (nonatomic, retain) NSNumber * isToday;
@property (nonatomic, retain) NSDate * projectedEndTime;
@property (nonatomic, retain) NSString * specifics;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * title;

@end
