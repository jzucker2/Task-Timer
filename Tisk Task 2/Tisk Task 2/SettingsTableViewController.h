//
//  SettingsTableViewController.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 11/11/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController
{
    NSMutableArray *settingsArray;
}

@property (nonatomic, retain) NSMutableArray *settingsArray;

@end
