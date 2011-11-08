//
//  SettingsViewController.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/8/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController
{
    IBOutlet UITableView *settingsTableView;
    NSMutableArray *settingsArray;
    
}

@property (nonatomic, retain) NSMutableArray *settingsArray;
@property (nonatomic, retain) IBOutlet UITableView *settingsTableView;

@end
