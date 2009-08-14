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

#import "LibraryViewController.h"
#import "IssueViewController.h"
#import "IssuePreviewController.h"
#import "WorkViewController.h"
#import "AuthorViewController.h"
#import "TabBarController.h"
#import "FeedbackViewController.h"
#import "FavoritesViewController.h"
#import "NewsViewController.h"
#import "InterviewsViewController.h"
#import "InterviewViewController.h"
#import "CleanUpFilesViewController.h"
#import "CreditsViewController.h"
#import "RestoreTransactionsViewController.h"
#import "MoreController.h"

#import "Transaction.h"
#import "Work.h"

#define kDatabaseName @"Scarab.sqlite3"
#define kConnectionTimeout 20.0

@implementation ScarabAppDelegate

@synthesize window;
@synthesize splashScreenController;
@synthesize visibleController;
@synthesize libraryViewController;
@synthesize favoritesViewController;
@synthesize interviewViewController;

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
  debugLog(@"Application did finish launching!");

  [self setUpStore];
  [self setUpAudioDirectory];
  [self setUpObjectiveResource];
  [self setUpThree20];
  [self setUpSplashScreen];
  
  // Set up HUD
  HUD = nil;

  // Set up core data
	NSManagedObjectContext *context = [self managedObjectContext];
	if (!context) {
    debugLog(@"Error grabbing the context in applicationDidFinishLaunching");
    [self showReinstallError];
	}
}

/**
 * applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {	
  NSError *error;
  if (managedObjectContext != nil) {
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      debugLog(@"Error grabbing the context and saving in applicationWillTerminate");
      // We're quitting... not much to handle.  Oh well.
    } 
  }
}


#pragma mark -
#pragma mark Setup Helper Methods

/**
 * Sets up the store to handle transactions -- including any in progress
 */
- (void)setUpStore {
  [[SKPaymentQueue defaultQueue] addTransactionObserver:[SMStore defaultStore]];
}

/**
 * Creates the directory to hold the audio files if it does not already exist.
 */
- (void)setUpAudioDirectory {
  NSFileManager *manager = [NSFileManager defaultManager];
  if (![manager fileExistsAtPath:[Work audioDirectoryPath]]) {
    debugLog(@"Audio directory does not exist, creating.");
    if (![manager createDirectoryAtPath:[Work audioDirectoryPath] attributes:nil]) {
      debugLog(@"Error!  This is a problem.  Couldn't create audio directory.");
      [self showReinstallError];
    }
  }
}

/**
 Returns the base URL where images and other media are found online.  No trailing slash.
 */
-(NSString *)baseServerURL {	
  return @"http://staging.scarabmag.com"; // localhost:3000 // staging.scarabmag.com
}

- (void)setUpObjectiveResource {
  // TODO: Extract ObjectiveResource config out to bundle or some such
  [ObjectiveResourceConfig setSite:[NSString stringWithFormat:@"%@/api/v1/", self.baseServerURL]];
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
  [map from:@"scarab://previewIssue/(initWithNumber:)" toViewController:[IssuePreviewController class]];
  [map from:@"scarab://issues/(initWithNumber:)" parent:@"scarab://library" toViewController:[IssueViewController class] selector:nil transition:0];  
  [map from:@"scarab://works/(initWithId:)" toViewController:[WorkViewController class]];
  [map from:@"scarab://authors/(initWithId:)" toViewController:[AuthorViewController class]];

  [map from:@"scarab://favorites" toSharedViewController:[FavoritesViewController class]];
  [map from:@"scarab://news" toSharedViewController:[NewsViewController class]];
  
  [map from:@"scarab://interviews" toSharedViewController:[InterviewsViewController class]];
  [map from:@"scarab://interviews/(initWithId:)" toViewController:[InterviewViewController class]];
  [map from:@"scarab://footnotes/(openFootnote:)" toObject:self selector:@selector(openFootnote:)];
  
  [map from:@"scarab://more" toSharedViewController:[MoreController class]];
  [map from:@"scarab://feedback" toViewController:[FeedbackViewController class]];
  [map from:@"scarab://syncDevice" toViewController:[RestoreTransactionsViewController class]];
  [map from:@"scarab://cleanUpFiles" toViewController:[CleanUpFilesViewController class]];
  [map from:@"scarab://credits" toViewController:[CreditsViewController class]];

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

- (void)setUpSplashScreen {
  self.splashScreenController = [[SplashScreenController alloc] initWithNibName:@"SplashScreen" bundle:nil];  
  [[UIApplication sharedApplication].keyWindow addSubview:self.splashScreenController.view];
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
#pragma mark Actions

- (void)openFootnote:(NSString *)footnoteId {
  [interviewViewController openFootnoteWithId:footnoteId];
}

- (void)showGenericError {
  TTAlert(@"Oops! An error occurred while performing your request. Please exit the application and come back and try again.\n\nIf the problem persists, please email support@scarabmag.com with a description of what you're doing before you see this.  Thank you!");
}

- (void)showSaveError {
  TTAlert(@"Oops! An error occurred while saving some data. All of your purchases are protected, though. Please exit the application and come back and try again.\n\nIf the problem persists, please email support@scarabmag.com with a description of what you're doing before you see this.  Thank you!");
}

- (void)showReinstallError {
  TTAlert(@"Oops! A serious error occurred! Please exit the application and come back and try again.\n\nIf the problem persists, please delete and then redownload the application (it will be free).  Sorry for the trouble, and thank you!");
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
    // Errors should be handled where this is called to provide context sensitive information if necessary.
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
    [self showReinstallError];
  }    
  
  return persistentStoreCoordinator;
}

#pragma mark -
#pragma mark HUD Methods

- (void)setupHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText {
  [self hudWasHidden]; // no harm making sure it's gone
  HUD = [[MBProgressHUD alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
  [[UIApplication sharedApplication].keyWindow addSubview:HUD];
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
#pragma mark Constantsish

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
  [favoritesViewController release];
  [interviewViewController release];
  [window release];
  [super dealloc];
}

@end

