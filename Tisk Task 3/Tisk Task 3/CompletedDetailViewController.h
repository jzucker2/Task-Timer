//
//  CompletedDetailViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/10/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskInfo.h"
#import "CountdownFormatter.h"

@interface CompletedDetailViewController : UITableViewController
{
    TaskInfo *taskInfo;
}

@property (nonatomic, retain) TaskInfo *taskInfo;

@end
