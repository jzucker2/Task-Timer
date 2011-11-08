//
//  Task.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * current;

@end
