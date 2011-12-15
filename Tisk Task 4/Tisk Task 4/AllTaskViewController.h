//
//  AllTaskViewController.h
//  Tisk Task 4
//
//  Created by Jordan Zucker on 12/14/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllTaskViewController : UIViewController
{
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
