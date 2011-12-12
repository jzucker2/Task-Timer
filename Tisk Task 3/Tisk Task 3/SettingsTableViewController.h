//
//  SettingsTableViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatisticsTableViewController.h"
#import "MessageUI/MessageUI.h"

@interface SettingsTableViewController : UITableViewController <MFMailComposeViewControllerDelegate>
{
    /*
    NSMutableArray *settingsArray;
    NSMutableArray *sortedKeys;
    NSMutableDictionary *tableContents;
     */
    NSArray *versionArray;
    NSArray *findMoreArray;
    
}
@property (nonatomic, retain) NSArray *versionArray;
@property (nonatomic, retain) NSArray *findMoreArray;
/*
@property (nonatomic, retain) NSMutableArray *sortedKeys;
@property (nonatomic, retain) NSMutableDictionary *tableContents;
@property (nonatomic, retain) NSMutableArray *settingsArray;
 */

- (void) showEmailModalView;

- (void) showWebsiteView;

@end
