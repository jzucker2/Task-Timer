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
    [pageControl setCurrentPage:0];
    
    [self setUpScrollView];
    
    //[pageControl setNumberOfPages:<#(NSInteger)#>
    
    
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
    welcomeString = @"Welcome";
    step1String = @"Step 1";
    step2String = @"Step 2";
    step3String = @"Step 3";
}

#pragma mark - UIScrollView Delegate

- (void) setUpScrollView
{
    [helpScrollView setDelegate:self];
    [helpScrollView setPagingEnabled:YES];
    [helpScrollView setScrollEnabled:YES];
    [helpScrollView setShowsVerticalScrollIndicator:NO];
    [helpScrollView setShowsHorizontalScrollIndicator:NO];
    [helpScrollView setContentSize:CGSizeMake((helpScrollView.frame.size.width)*4, helpScrollView.frame.size.height)];
    
    [self setHelpText];
    
    UITextView *welcomeTextView = [[UITextView alloc] init];
    [welcomeTextView setText:welcomeString];
    UITextView *step1TextView = [[UITextView alloc] init];
    [step1TextView setText:step1String];
    UITextView *step2TextView = [[UITextView alloc] init];
    [step2TextView setText:step2String];
    UITextView *step3TextView = [[UITextView alloc] init];
    [step3TextView setText:step3String];
    
    NSArray *textViewArray = [[NSArray alloc] initWithObjects:welcomeTextView, step1TextView, step2TextView, step3TextView, nil];
    
    [welcomeTextView release];
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
    [helpScrollView release];
    [pageControl release];
    [super dealloc];
}

@end
