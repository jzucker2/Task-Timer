//
//  FirstViewController.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllTaskViewController.h"

@interface FirstViewController : UIViewController <UINavigationControllerDelegate>
{
    IBOutlet UINavigationController *navigationController;
    UITableViewController *firstTableViewController;
    //AllTaskViewController *allTask;
}

//@property (nonatomic, retain) IBOutlet AllTaskViewController *allTask;
@property (nonatomic, retain) IBOutlet UITableViewController *firstTableViewController;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
