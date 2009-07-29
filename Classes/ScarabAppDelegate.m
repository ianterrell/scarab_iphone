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
#import "SMStore.h"

#import "IssuePreviewController.h"
#import "LibraryViewController.h"
#import "WorkViewController.h"
#import "AuthorViewController.h"
#import "TabBarController.h"
#import "PlaceholderController.h"

#define kDatabaseName @"Scarab.sqlite3"
#define kConnectionTimeout 20.0

@implementation ScarabAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize splashScreenController;
@synthesize visibleController;
@synthesize libraryViewController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  debugLog(@"Application did finish launching!");
  
  // Set up store
  [[SKPaymentQueue defaultQueue] addTransactionObserver:[SMStore defaultStore]];
  
  // TEST
//  [[SMStore defaultStore] test];

  [self setUpObjectiveResource];
  [self setUpThree20];
  
  // Set up HUD
  HUD = nil;

  // Set up core data
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


#pragma mark -
#pragma mark Setup Helper Methods

- (void)setUpObjectiveResource {
  // TODO: Extract ObjectiveResource config out to bundle or some such
  [ObjectiveResourceConfig setSite:@"http://staging.scarabmag.com/"];
  //[ObjectiveResourceConfig setUser:@"remoteResourceUserName"];
  //[ObjectiveResourceConfig setPassword:@"remoteResourcePassword"];
  [ObjectiveResourceConfig setResponseType:XmlResponse];
  [Connection setTimeout:kConnectionTimeout];
}

- (void)setUpTTNavigator {
  TTNavigator* navigator = [TTNavigator navigator];
  navigator.persistenceMode = TTNavigatorPersistenceModeAll;
  navigator.window = [[[UIWindow alloc] initWithFrame:TTScreenBounds()] autorelease];
  
  TTURLMap* map = navigator.URLMap;
  
  [map from:@"*" toViewController:[TTWebController class]];
  [map from:@"scarab://tabBar" toSharedViewController:[TabBarController class]];
  [map from:@"scarab://library" toSharedViewController:[LibraryViewController class]];
  [map from:@"scarab://issue/(initWithNumber:)" toViewController:[IssuePreviewController class]];
  [map from:@"scarab://work" toViewController:[WorkViewController class]];
  [map from:@"scarab://author" toViewController:[AuthorViewController class]];
  [map from:@"scarab://placeholder/(initWithType:)" toViewController:[PlaceholderController class]];  
  
  // Before opening the tab bar, we see if the controller history was persisted the last time
  if (![navigator restoreViewControllers]) {
    // This is the first launch, so we just start with the tab bar
    [navigator openURL:@"scarab://tabBar" animated:NO];
  }
}

- (void)setUpThree20 {
  [TTStyleSheet setGlobalStyleSheet:[[[ScarabStyleSheet alloc] init] autorelease]];
  [self setUpTTNavigator];
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
  
  NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent:kDatabaseName]];

  NSError *error;
  persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
  if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
    debugLog(@"Error setting up the store coordinator: %@", [error localizedDescription]);
    // TODO: Handle the error.
  }    
  
  return persistentStoreCoordinator;
}

#pragma mark -
#pragma mark HUD Methods

- (void)setupHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText {
  [self hudWasHidden]; // no harm making sure it's gone
  HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
  [self.window addSubview:HUD];
  HUD.delegate = self;
  HUD.labelText = labelText;
  HUD.detailsLabelText = detailsLabelText;
}

- (void)showHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText animated:(BOOL)animated {
  [self setupHUDWithLabel:labelText details:detailsLabelText];
  [HUD showUsingAnimation:animated];
}

- (void)hideHUDUsingAnimation:(BOOL)animated {
  [HUD hideUsingAnimation:animated];
}

- (void)showHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText whileExecuting:(SEL)selector onTarget:(id)target withObject:(id)object animated:(BOOL)animated {
  [self setupHUDWithLabel:labelText details:detailsLabelText];
  [HUD showWhileExecuting:selector onTarget:target withObject:object animated:animated];
}

- (void)hudWasHidden {
  [HUD removeFromSuperview];
  [HUD release];
  HUD = nil;
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

