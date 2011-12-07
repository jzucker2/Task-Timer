//
//  NSManagedObjectContext+FetchedObjectFromURI.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (FetchedObjectFromURI)

- (NSManagedObject *) objectWithURI:(NSURL *)uri;

@end
