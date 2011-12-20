//
//  EditingViewController.h
//  Tisk Task 4
//
//  Created by Jordan Zucker on 12/19/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditingViewController : UIViewController <UITextViewDelegate>
{
    UITextField *textField;
    NSManagedObject *editedObject;
    NSString *editedFieldKey;
    NSString *editedFieldName;
    
    BOOL editingDuration;
    BOOL editingSpecifics;
    UIDatePicker *datePicker;
    UITextView *textView;
    BOOL editingExistingObject;
}

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) NSManagedObject *editedObject;
@property (nonatomic, retain) NSString *editedFieldKey;
@property (nonatomic, retain) NSString *editedFieldName;

@property (nonatomic, assign, getter = isEditingExistingObject) BOOL editingExistingObject;
@property (nonatomic, assign, getter = isEditingSpecifics) BOOL editingSpecifics;
@property (nonatomic, assign, getter = isEditingDuration) BOOL editingDuration;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancel;
- (IBAction)save;

@end
