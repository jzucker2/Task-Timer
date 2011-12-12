//
//  SettingsTableViewController.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "HelpViewController.h"

@implementation SettingsTableViewController

@synthesize versionArray, findMoreArray;

//@synthesize settingsArray;
//@synthesize sortedKeys, tableContents;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSString *versionString = [NSString stringWithFormat:@"Version %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
    
    NSString *buildString = [NSString stringWithFormat:@"Build %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    
    versionArray = [[NSArray alloc] initWithObjects:versionString, buildString, nil];
    

    
    NSString *author = @"Jordan Zucker";
    NSString *date = @"December 2011";
    
    NSString *sendEmail = @"Send me an email!";
    //[settingsArray addObject:sendEmail];
    
    NSString *visitMe = @"Visit my website";
    
    findMoreArray = [[NSArray alloc] initWithObjects:author, date, sendEmail, visitMe, nil];
    
    //NSString *stats = @"Statistics";
    
    
    
    //[settingsArray addObject:stats];
    
    //tableContents = [[NSMutableDictionary alloc] initWithObjectsAndKeys:versionDict, @"About", findMoreArray, @"Find out more", nil
    //NSMutableArray *versionArray = [[NSMutableArray alloc] initWithObjects:versionDict, build, nil];
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
    
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 4;
}


- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title;
    switch (section) {
        case 0:
            title = @"App Info";
            break;
        case 1:
            title = @"About Me";
            break;
            
        default:
            title = nil;
            break;
    }
    return  title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    switch (section) {
        case 0:
            rows = [versionArray count];
            break;
        case 1:
            rows = [findMoreArray count];
            break;
        case 2:
            rows = 1;
            break;
        case 3:
            rows = 1;
            break;
        default:
            rows = 0;
            break;
    }
    return rows;
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return [settingsArray count];
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = [versionArray objectAtIndex:indexPath.row];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            break;
        case 1:
            cell.textLabel.text = [findMoreArray objectAtIndex:indexPath.row];
            if (indexPath.row == 2 || indexPath.row == 3) {
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            }
            break;
        case 2:
            cell.textLabel.text = @"Statistics";
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
        case 3:
            cell.textLabel.text = @"View help";
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            break;
            
        default:
            break;
    }
    //cell.textLabel.text = [settingsArray objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 1:
            switch (indexPath.row) {
                case 2:
                    NSLog(@"send email");
                    [self showEmailModalView];
                    break;
                case 3:
                    NSLog(@"visit website");
                    [self showWebsiteView];
                    break;
                default:
                    [tableView deselectRowAtIndexPath:indexPath animated:NO];
                    break;
            }
            break;
        case 2:
            NSLog(@"View stats");
            StatisticsTableViewController *statsView = [[StatisticsTableViewController alloc] initWithNibName:@"StatisticsTableView" bundle:nil];
            statsView.title = @"Statistics";
            [self.navigationController pushViewController:statsView animated:YES];
            [statsView release];
            break;
        case 3:
            NSLog(@"Help view");
            HelpViewController *helpView = [[HelpViewController alloc] initWithNibName:@"HelpView" bundle:nil];
            //[self.navigationController pushViewController:helpView animated:YES];
            [self presentModalViewController:helpView animated:YES];
            [helpView release];
            break;
            
        default:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            break;
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
       *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark -
#pragma mark Show Email Modal view

- (void) showEmailModalView
{
    MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
    mailView.mailComposeDelegate = self;
    
    [mailView setSubject:@"From Tisk Task"];
    
    NSString *recipient = @"jordan.zucker@gmail.com";
    NSArray *recipientArray = [[NSArray alloc] initWithObjects:recipient, nil];
    
    [mailView setToRecipients:recipientArray];
    [recipientArray release];
    
    [mailView setMessageBody:@"" isHTML:NO];
    
    [self presentModalViewController:mailView animated:YES];
    [mailView release];
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultFailed:
            break;
        default:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending failed - Unknown error :(" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
            
            }
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Show Web View

- (void) showWebsiteView
{
    NSURL *url = [NSURL URLWithString:@"http://www.stackoverflow.com"];
    
    if (![[UIApplication sharedApplication] openURL:url])
        
        NSLog(@"%@%@",@"Failed to open url:",[url description]);
}

#pragma mark -
#pragma mark Memory Management

- (void) dealloc
{
    [versionArray release];
    [findMoreArray release];
    //[sortedKeys release];
    //[tableContents release];
    //[settingsArray release];
    [super dealloc];
}

@end
