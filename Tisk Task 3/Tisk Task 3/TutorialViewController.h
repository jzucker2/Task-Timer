//
//  TutorialViewController.h
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/12/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController <UIScrollViewDelegate, UITextViewDelegate>
{
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *helpScrollView;
    NSString *welcomeString;
    NSString *step1String;
    NSString *step2String;
    NSString *step3String;
}

@property (nonatomic, retain) IBOutlet UIScrollView *helpScrollView;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;

- (void) setUpScrollView;

- (void) setHelpText;

- (IBAction)done:(id)sender;

@end
