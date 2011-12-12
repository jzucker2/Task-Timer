//
//  TutorialViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/12/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "TutorialViewController.h"

@implementation TutorialViewController

@synthesize pageControl;
@synthesize helpScrollView;
@synthesize welcomeString, step1String, step2String, step3String;
@synthesize welcomeTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setHelpText];
    [pageControl setCurrentPage:0];
    
    [welcomeTextView setText:welcomeString];
    
    [self setUpScrollView];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTutorialView"] ) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"FirstTutorialView"];
        // proceed to do what you wish to only on the first launch
        UIAlertView *enableAlert = [[UIAlertView alloc] initWithTitle:@"Please enable notifications" message:@"In order for this app to work, please enable notifications, and set them to type 'Alerts'" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [enableAlert show];
        [enableAlert release];
    }
    
    //[helpScrollView setContentOffset:CGPointMake(0, 0)];
    //NSLog(@"contentOffset is %f", helpScrollView.contentOffset.x);
    
    //[pageControl setNumberOfPages:<#(NSInteger)#>
    
    
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [helpScrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Help Text

- (void) setHelpText
{
    welcomeString = @"Hello, and welcome to Tisk Task. This is a productivity app designed to help people who prefer to multi-task.";
    step1String = @"Step 1: Create a task in the 'All Tasks' tab.";
    step2String = @"Step 2: Set all tasks you wish to work on today by hitting the switch in the 'All Tasks.' These tasks will now appear in the 'Today's Tasks' tab. Once a task is set to today, Tisk Task will remind you about the task later";
    step3String = @"Step 3: Click on a task in the 'Today's Tasks' tab. From there you can start and stop your work on a task. Even if you leave the app, Tisk Task will let you know when the task is done.";
}

#pragma mark - UIScrollView Delegate

- (void) setUpScrollView
{
    [helpScrollView setDelegate:self];
    [helpScrollView setPagingEnabled:YES];
    [helpScrollView setScrollEnabled:YES];
    [helpScrollView setShowsVerticalScrollIndicator:NO];
    [helpScrollView setShowsHorizontalScrollIndicator:NO];
    //[helpScrollView setContentSize:CGSizeMake((helpScrollView.frame.size.width)*4, helpScrollView.frame.size.height)];
    
    //[self setHelpText];
    
    UITextView *step1TextView = [[UITextView alloc] init];
    [step1TextView setText:step1String];
    UITextView *step2TextView = [[UITextView alloc] init];
    [step2TextView setText:step2String];
    UITextView *step3TextView = [[UITextView alloc] init];
    [step3TextView setText:step3String];
    
    NSArray *textViewArray = [[NSArray alloc] initWithObjects:step1TextView, step2TextView, step3TextView, nil];
    [helpScrollView setContentSize:CGSizeMake((helpScrollView.frame.size.width)*[textViewArray count], helpScrollView.frame.size.height)];
    [pageControl setNumberOfPages:[textViewArray count]];
    
    [step1TextView release];
    [step2TextView release];
    [step3TextView release];
    
    //CGFloat x;
    NSInteger textViewCounter;
    for (textViewCounter = 0; textViewCounter <[textViewArray count]; textViewCounter++) {
        UITextView *adjustedTextView = [textViewArray objectAtIndex:textViewCounter];
        [adjustedTextView setEditable:NO];
        [adjustedTextView setPagingEnabled:NO];
        [adjustedTextView setScrollEnabled:NO];
        [adjustedTextView setFrame:CGRectMake(textViewCounter*helpScrollView.frame.size.width, 0, helpScrollView.frame.size.width, helpScrollView.frame.size.height)];
        [helpScrollView addSubview:adjustedTextView];
    }
    
    [textViewArray release];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"position is %f", scrollView.contentOffset.x);
    CGFloat position = scrollView.contentOffset.x;
    CGFloat width = scrollView.frame.size.width;
    
    NSInteger pageNumber = (NSInteger)(position/width);
    //NSLog(@"pageNumber is %i", pageNumber);
    
    [pageControl setCurrentPage:pageNumber];
    
    
    //NSInteger pageNumber = (scrollView.contentOffset.x)%(scrollView.frame.size.width);
}

#pragma mark - Toolbar

- (IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Memory Management

- (void) dealloc
{
    [welcomeTextView release];
    [welcomeString release];
    [step1String release];
    [step2String release];
    [step3String release];
    [helpScrollView release];
    [pageControl release];
    [super dealloc];
}

@end
