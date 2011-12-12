//
//  TutorialViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/12/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate>
{
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *helpScrollView;
    NSString *welcomeString;
    NSString *step1String;
    NSString *step2String;
    NSString *step3String;
    IBOutlet UITextView *welcomeTextView;
}

@property (nonatomic, retain) IBOutlet UITextView *welcomeTextView;
@property (nonatomic, retain) NSString *welcomeString;
@property (nonatomic, retain) NSString *step1String;
@property (nonatomic, retain) NSString *step2String;
@property (nonatomic, retain) NSString *step3String;

@property (nonatomic, retain) IBOutlet UIScrollView *helpScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (void) setUpScrollView;

- (void) setHelpText;

- (IBAction)done:(id)sender;

@end
