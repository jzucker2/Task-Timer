//
//  EditingViewController.h
//  Tisk Task 2
//
//  Created by Jordan Zucker on 12/1/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditingViewController : UIViewController
{
    UITextField *textField;
    NSManagedObject *editedObject;
    NSString *editedFieldKey;
    NSString *editedFieldName;
    
    BOOL editingDuration;
    UIDatePicker *datePicker;
}

@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) NSManagedObject *editedObject;
@property (nonatomic, retain) NSString *editedFieldKey;
@property (nonatomic, retain) NSString *editedFieldName;

@property (nonatomic, assign, getter = isEditingDuration) BOOL editingDuration;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancel;
- (IBAction)save;

@end
