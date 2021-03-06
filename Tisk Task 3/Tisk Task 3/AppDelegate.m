//
//  AppDelegate.m
//  Tisk Task 3
//
//  Created by Jordan Zucker on 12/6/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "AppDelegate.h"

#import "AllTaskViewController.h"
#import "TodayTaskViewController.h"
#import "HistoryViewController.h"
#import "SettingsTableViewController.h"



@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (void)dealloc
{
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"didFinishLaunchingWithOptions");
    NSLog(@"options are %@", launchOptions);
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    /*
     UIViewController *viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
     UIViewController *viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
     */
    
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) {
        // Handle the error.
        NSLog(@"context error in app delegate");
    }
    
    AllTaskViewController *view1 = [[AllTaskViewController alloc] initWithNibName:@"AllTaskView" bundle:nil];
    view1.managedObjectContext = context;
    view1.title = @"All Tasks";
    
    TodayTaskViewController *view2 = [[TodayTaskViewController alloc] initWithNibName:@"TodayTaskView" bundle:nil];
    view2.managedObjectContext = context;
    view2.title = @"Today's Tasks";
    
    HistoryViewController *view3 = [[HistoryViewController alloc] initWithNibName:@"HistoryView" bundle:nil];
    view3.managedObjectContext = context;
    view3.title = @"History";
    
    SettingsTableViewController *view4 = [[SettingsTableViewController alloc] initWithNibName:@"SettingsTableView" bundle:nil];
    view4.title = @"Settings";
    
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:view1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:view2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:view3];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:view4];
    
    [view1 release];
    [view2 release];
    [view3 release];
    [view4 release];
    
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    //self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
    
    NSArray *tabBarItems = self.tabBarController.tabBar.items;
    UIImage *tab1 = [UIImage imageNamed:@"40-inbox.png"];
    UIImage *tab2 = [UIImage imageNamed:@"78-stopwatch.png"];
    UIImage *tab3 = [UIImage imageNamed:@"117-todo.png"];
    UIImage *tab4 = [UIImage imageNamed:@"20-gear2.png"];
    NSArray *tabBarImages = [[NSArray alloc] initWithObjects:tab1, tab2, tab3, tab4, nil];
    NSInteger tabBarItemCounter;
    for (tabBarItemCounter = 0; tabBarItemCounter < [tabBarItems count]; tabBarItemCounter++) 
    {
        UITabBarItem *tabBarItem = [tabBarItems objectAtIndex:tabBarItemCounter];
        tabBarItem.image = [tabBarImages objectAtIndex:tabBarItemCounter];
    }
    
    [nav1 release];
    [nav2 release];
    [nav3 release];
    [nav4 release];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (notification != nil) {
        [self application:[UIApplication sharedApplication] didReceiveLocalNotification:notification];
    }
    
    
    //[self application:[UIApplication sharedApplication] didReceiveLocalNotification:notification];
    
    
    // reset methods
    //[[UIApplication sharedApplication] cancelAllLocalNotifications];
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"applicationWillResignActive");
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    
    /*
    // save current view
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.tabBarController.selectedViewController.nibName
    [userDefaults setObject:<#(id)#> forKey:<#(NSString *)#>
     */
    
    NSError *error;
    if (managedObjectContext != nil) 
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) 
        {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"applicationWillEnterForeground");
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    /*
    NSLog(@"presented view controller has title: %@", self.tabBarController.navigationController.presentedViewController.nibName);
    NSLog(@"presenting view controller has title: %@", self.tabBarController.navigationController.presentingViewController.nibName);
    NSLog(@"selected view controller has nibname: %@", self.tabBarController.selectedViewController.nibName);
    NSLog(@"nibname: %@", self.tabBarController.selectedViewController.presentedViewController.nibName);
    NSLog(@"nibname: %@", self.tabBarController.selectedViewController.presentingViewController.nibName);
     */
    
    //NSLog(@"nibname: %@", self.tabBarController.navigationController.reloadInputViews)
    

    [self.tabBarController.view setNeedsDisplay];
    //self.tabBarController.presentedViewController.title
    //[self.tabBarController.presentedViewController na viewWillAppear:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    NSError *error;
    if (managedObjectContext != nil) 
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) 
        {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
}

#pragma mark -
#pragma mark Notifications

- (void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification");
    
    [UIApplication sharedApplication].applicationIconBadgeNumber--;
    NSLog(@"userInfo is %@", notification.userInfo);
    NSString *title = [notification.userInfo objectForKey:@"title"];
    NSLog(@"title is %@", title);
    
    if (!title) {
        return;
    }
    
    NSString *taskString = [notification.userInfo objectForKey:@"taskURLString"];
    
    NSURL *taskURL = [NSURL URLWithString:taskString];
    
    TaskInfo *taskInfo = (TaskInfo *) [managedObjectContext objectWithURI:taskURL];
    NSLog(@"taskInfo is %@", taskInfo);
    
    NSString *type = [notification.userInfo objectForKey:@"type"];
    
    NSString *alertTitle;
    NSString *message;
    
    if ([type isEqualToString:@"alarm"]) {
        [taskInfo endTask];
        alertTitle = @"You just finished a task!";
        message = [NSString stringWithFormat:@"You just finished %@", taskInfo.title];
        
    }
    else
    {
        NSInteger reminder = [taskInfo.timesReminded integerValue];
        reminder++;
        NSNumber *timesReminded = [NSNumber numberWithInteger:reminder];
        [taskInfo setTimesReminded:timesReminded];
        [taskInfo scheduleReminder];
        
        alertTitle = @"You still have some work to do!";
        message = [NSString stringWithFormat:@"You still need to work on %@", taskInfo.title];
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    

}

#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"TiskTaskData.sqlite"];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"TiskTaskData" ofType:@"sqlite"];
		if (defaultStorePath) {
			[fileManager copyItemAtPath:defaultStorePath toPath:storePath error:NULL];
		}
	}
    
	NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
	
	NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];	
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    
	NSError *error;
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
		// Update to handle the error appropriately.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
