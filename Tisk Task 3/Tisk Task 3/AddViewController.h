//
//  AddViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "DetailViewController.h"

@protocol AddViewControllerDelegate;

@interface AddViewController : DetailViewController { id <AddViewControllerDelegate> delegate; }

@property (nonatomic, assign) id <AddViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;


@end

@protocol AddViewControllerDelegate

- (void) addViewController:(AddViewController *)controller didFinishWithSave:(BOOL) save;

@end
