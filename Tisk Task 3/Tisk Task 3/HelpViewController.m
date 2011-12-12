//
//  HelpViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/11/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "HelpViewController.h"

@implementation HelpViewController

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
    
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstHelpView"] ) {
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:@"FirstHelpView"];
        // proceed to do what you wish to only on the first launch
        UIAlertView *enableAlert = [[UIAlertView alloc] initWithTitle:@"Please enable notifications" message:@"In order for this app to work, please enable notifications, and set them to type 'Alerts'" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [enableAlert show];
        [enableAlert release];
    }
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

- (IBAction)done:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
