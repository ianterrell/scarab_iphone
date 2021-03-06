//
//  ScarabAppDelegate.h
//  Scarab
//
//  Created by Ian Terrell on 6/9/09.
//  Copyright Ian Terrell 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashScreenController;
@class LibraryViewController;
@class FavoritesViewController;
@class InterviewViewController;
@class TabBarController;

@interface ScarabAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
  UIWindow *window;
  SplashScreenController *splashScreenController;
  LibraryViewController *libraryViewController;
  
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
  
  UIViewController *visibleController;
  FavoritesViewController *favoritesViewController;
  InterviewViewController *interviewViewController;
  TabBarController *tabBarController;
  
  MBProgressHUD *HUD;
  
  NSString *pushNotificationDeviceToken;
}

@property(nonatomic,retain) IBOutlet UIWindow *window;
@property(nonatomic,retain) IBOutlet SplashScreenController *splashScreenController;
@property(nonatomic,retain) IBOutlet LibraryViewController *libraryViewController;
@property(nonatomic,retain) FavoritesViewController *favoritesViewController;
@property(nonatomic,retain) InterviewViewController *interviewViewController;
@property(nonatomic,retain) TabBarController *tabBarController;

@property(nonatomic,retain,readonly) NSManagedObjectModel *managedObjectModel;
@property(nonatomic,retain,readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,assign) UIViewController *visibleController;

@property(nonatomic,readonly) NSString *applicationDocumentsDirectory;
@property(nonatomic,readonly) NSString *baseServerURL;

@property(nonatomic,retain) NSString *pushNotificationDeviceToken;

#pragma mark Splash Screen

- (void)doneWithSplash;

#pragma mark Helpers

- (void)showGenericError;
- (void)showSaveError;
- (void)showReinstallError;

#pragma mark Setup Helper Methods

- (void)setUpAnalytics;
- (void)setUpStore;
- (void)setUpAudioDirectory;
- (void)setUpObjectiveResource;
- (void)setUpThree20;
- (void)setUpSplashScreen;

#pragma mark Network Connectivity Stuff

- (void)showNetworkWarningIfNeeded;
- (NSString *)dontShowConnectivityAlertFlagPath;

#pragma mark HUD Methods

- (void)showHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText animated:(BOOL)animated;
- (void)hideHUDUsingAnimation:(BOOL)animated;
- (void)showHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText whileExecuting:(SEL)selector onTarget:(id)target withObject:(id)object animated:(BOOL)animated;
- (void)hudWasHidden;

#pragma mark Core Data

- (void)save:(NSError **)error;

@end
