//
//  ScarabAppDelegate.m
//  Scarab
//
//  Created by Ian Terrell on 6/9/09.
//  Copyright Ian Terrell 2009. All rights reserved.
//

#import "ScarabAppDelegate.h"
#import "SplashScreenController.h"
#import "ScarabStyleSheet.h"

@implementation ScarabAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize splashScreenController;
@synthesize visibleController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  debugLog(@"Application did finish launching!");
  
  // Set up ObjectiveResource
  // TODO: Extract ObjectiveResource config out to bundle or some such
  [ObjectiveResourceConfig setSite:@"http://192.168.1.100:3000/"];
  //  [ObjectiveResourceConfig setUser:@"remoteResourceUserName"];
  //  [ObjectiveResourceConfig setPassword:@"remoteResourcePassword"];
  [ObjectiveResourceConfig setResponseType:XmlResponse];

  // Set up Three20
  [TTStyleSheet setGlobalStyleSheet:[[[ScarabStyleSheet alloc] init] autorelease]];
  TTNavigationCenter* nav = [TTNavigationCenter defaultCenter];
  nav.delegate = self;
  nav.urlSchemes = [NSArray arrayWithObject:@"tt"];

	NSManagedObjectContext *context = [self managedObjectContext];
	if (!context) {
    // Do I want to start it up here?  I mean, duzzit matter?
		// TODO: Handle the error.
    debugLog(@"Error grabbing the context in applicationDidFinishLaunching");
	}
	
  [window addSubview:tabBarController.view];
  [window addSubview:splashScreenController.view];
}

/**
 * applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {	
  NSError *error;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
    debugLog(@"Error grabbing the context and saving in applicationWillTerminate");
      // TODO: Handle the error.
    } 
  }
}

/*
// Optional UITabBarControllerDelegate method
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
-(void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

#pragma mark -
#pragma mark Splash Screen

-(void)doneWithSplash {
  debugLog(@"Done with splash screen");
  [splashScreenController release];
}

#pragma mark -
#pragma mark Saving

/**
 Performs the save action for the application, which is to send the save:
 message to the application's managed object context.
 */
-(void)save:(NSError **)error {	
  if (![[self managedObjectContext] save:error]) {
    debugLog(@"Error grabbing the context and saving in save");
    // TODO: Handle error
  }
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
    [managedObjectContext setPersistentStoreCoordinator:coordinator];
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
-(NSPersistentStoreCoordinator *)persistentStoreCoordinator {	
  if (persistentStoreCoordinator != nil) {
    return persistentStoreCoordinator;
  }

  NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Scarab.sqlite"]];  // TODO: set name of database in bundle, config, somewhere

  NSError *error;
  persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
    NSLog(@"Error setting up the store coordinator");
    // TODO: Handle the error.
  }    

  return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
-(NSString *)applicationDocumentsDirectory {	
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
  return basePath;
}

#pragma mark -
#pragma mark TTNavigationDelegate methods

- (BOOL)shouldLoadExternalURL:(NSURL*)url {
  TTWebController *webController = [[TTWebController alloc] init];
	[visibleController.navigationController pushViewController:webController animated:YES];
  [webController performSelector:@selector(openURL:) withObject:url afterDelay:0.4]; // fix for activity view
	[webController release];

  return NO;
}


#pragma mark -
#pragma mark Memory management

-(void)dealloc {
  [managedObjectContext release];
  [managedObjectModel release];
  [persistentStoreCoordinator release];
  [splashScreenController release];
  [tabBarController release];
  [window release];
  [super dealloc];
}

@end

