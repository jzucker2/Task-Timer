//
//  FirstViewController.m
//  Tisk Task
//
//  Created by Jordan Zucker on 11/7/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "FirstViewController.h"

@implementation FirstViewController
@synthesize navigationController;
@synthesize firstTableViewController;
//@synthesize allTask;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
        //allTask = [[[AllTaskViewController alloc] initWithNibName:@"AllTaskViewController" bundle:[NSBundle mainBundle]] autorelease];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //AllTaskViewController *allTask = (AllTaskViewController *)[navigationController topViewController];
    navigationController.delegate = self;

    //AllTaskViewController *allTask = [[AllTaskViewController alloc] initWithNibName:@"AllTaskViewController" bundle:nil];
    //AllTaskViewController *allTask = (AllTaskViewController *) [navigationController topViewController];
    //[navigationController initWithRootViewController:allTask];
    AllTaskViewController *allTask = [[AllTaskViewController alloc] initWithNibName:@"AllTaskViewController" bundle:[NSBundle mainBundle]];
    [navigationController initWithRootViewController:allTask];
    //[allTask release];
    
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark Navigation Controller Delegate

- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"nav controller delegate");
}

@end
