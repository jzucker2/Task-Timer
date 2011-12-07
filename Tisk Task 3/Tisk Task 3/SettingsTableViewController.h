//
//  SettingsTableViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsTableViewController : UITableViewController
{
    NSMutableArray *settingsArray;
}

@property (nonatomic, retain) NSMutableArray *settingsArray;

@end
