//
//  AppDelegate.m
//  Tisk Task 2
//
//  Created by Jordan Zucker on 11/11/11.
//  Copyright (c) 2011 University of Illinois. All rights reserved.
//

#import "AppDelegate.h"

#import "AllTaskTableViewController.h"
#import "TodayTaskTableViewController.h"
#import "SettingsTableViewController.h"
#import "CompletedTaskTableViewController.h"

#import "NSManagedObjectContext+FetchedObjectFromURI.h"

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
    
    AllTaskTableViewController *view1 = [[AllTaskTableViewController alloc] initWithNibName:@"AllTaskTableView" bundle:nil];
    view1.managedObjectContext = context;
    view1.title = @"All Tasks";
    
    TodayTaskTableViewController *view2 = [[TodayTaskTableViewController alloc] initWithNibName:@"TodayTaskTableView" bundle:nil];
    view2.managedObjectContext = context;
    view2.title = @"Today's Tasks";
    
    CompletedTaskTableViewController *view3 = [[CompletedTaskTableViewController alloc] initWithNibName:@"CompletedTaskTableView" bundle:nil];
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
    //[self.tabBarController.viewControllers.lastObject viewWillAppear:YES];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"applicationWillTerminate");
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
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
    
    if ([type isEqualToString:@"alarm"]) {
        [self endTask:taskInfo];
    }
    else
    {
        [self handleReminderWithTask:taskInfo];
    }
    
}

#pragma mark -
#pragma mark end Task

- (void) endTask:(TaskInfo *)taskInfo
{
    NSDate *finishDate = [NSDate date];
    //NSTimeInterval = timeLeft;
    //NSDate *end = [start dateByAddingTimeInterval:timeLeft];
    NSNumber *running = [NSNumber numberWithBool:NO];
    
    double elapsed = [taskInfo.elapsedTime doubleValue];
    //double duration = [taskInfo.duration doubleValue];
    
    //elapsed = (duration - timeLeft);
    NSNumber *elapsedNumber = [NSNumber numberWithDouble:elapsed];
    [taskInfo setValue:elapsedNumber forKey:@"elapsedTime"];
    
    
    [taskInfo setValue:finishDate forKey:@"completionDate"];
    NSNumber *completed = [NSNumber numberWithBool:YES];
    [taskInfo setValue:completed forKey:@"isCompleted"];
    
    NSNumber *todayBOOL = [NSNumber numberWithBool:NO];
    [taskInfo setValue:todayBOOL forKey:@"isToday"];
    
    //[taskInfo setValue:start forKey:@"startTime"];
    //[taskInfo setValue:end forKey:@"projectedEndTime"];
    [taskInfo setValue:running forKey:@"isRunning"];
    
    //NSManagedObjectContext *managedObjectContext = [taskInfo managedObjectContext];
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Update to handle the error appropriately.
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }

}

#pragma mark -
#pragma mark Handle Reminder

- (void) handleReminderWithTask:(TaskInfo *)taskInfo
{
    NSLog(@"handle reminder for %@", taskInfo);
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    if (localNotification == nil) {
        return;
    }
    
    /*
     need to figure out precisely when to fire timer, some factors:
     1. how much time left in day vs. how much time left in task
     2. time zone
     3. how many times have you been reminded? should i keep track of that? probably, but won't for now. should increase frequency of reminders when timesReminded increases
     4. how long duration is in general. Remind more frequently for shorter tasks but can't take 3 hours to remind for a 3 hour task
     
     */
    
    // since this is a reminder, going to cut time until next reminder in half
    double duration = [taskInfo.duration doubleValue];
    duration = duration/2;
    //double elapsed = [taskInfo.elapsedTime doubleValue];
    //double reminderTime = duration - elapsed;
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:duration];
    localNotification.fireDate = date;
    localNotification.alertBody = [NSString stringWithFormat:@"%@ still needs work today", taskInfo.title];
    localNotification.alertAction = @"Start Working";
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber++;
    
    NSManagedObjectID *taskID = [taskInfo objectID];
    NSURL *taskURL = [taskID URIRepresentation];
    
    NSString *URLString = [taskURL absoluteString];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:taskInfo.title, @"title", URLString, @"taskURLString", @"reminder", @"type", nil];
    
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    
    [localNotification release];
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
	
	
	NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"TaskData.sqlite"];
	/*
	 Set up the store.
	 For the sake of illustration, provide a pre-populated default store.
	 */
	NSFileManager *fileManager = [NSFileManager defaultManager];
	// If the expected store doesn't exist, copy the default store.
	if (![fileManager fileExistsAtPath:storePath]) {
		NSString *defaultStorePath = [[NSBundle mainBundle] pathForResource:@"TaskData" ofType:@"sqlite"];
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
