//
//  EditingViewController.h
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditingViewController : UIViewController
{
    UITextField *textField;
    
    NSManagedObject *editedObject;
    NSString *editedFieldKey;
    NSString *editedFieldName;
	
    BOOL editingTime;
	UIDatePicker *durationPicker;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;

@property (nonatomic, retain) NSManagedObject *editedObject;
@property (nonatomic, retain) NSString *editedFieldKey;
@property (nonatomic, retain) NSString *editedFieldName;

@property (nonatomic, assign, getter=isEditingDate) BOOL editingTime;
@property (nonatomic, retain) IBOutlet UIDatePicker *durationPicker;

- (IBAction)cancel;
- (IBAction)save;

@end
