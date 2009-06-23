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

@interface ScarabAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, TTNavigationDelegate> {
  UIWindow *window;
  UITabBarController *tabBarController;
  SplashScreenController *splashScreenController;
  LibraryViewController *libraryViewController;
  
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;
  
  UIViewController *visibleController;
  
  MBProgressHUD *HUD;
}

@property(nonatomic,retain) IBOutlet UIWindow *window;
@property(nonatomic,retain) IBOutlet UITabBarController *tabBarController;
@property(nonatomic,retain) IBOutlet SplashScreenController *splashScreenController;
@property(nonatomic,retain) IBOutlet LibraryViewController *libraryViewController;

@property(nonatomic,retain,readonly) NSManagedObjectModel *managedObjectModel;
@property(nonatomic,retain,readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,assign) UIViewController *visibleController;

@property(nonatomic,readonly) NSString *applicationDocumentsDirectory;

#pragma mark Splash Screen

- (void)doneWithSplash;

#pragma mark HUD Methods

- (void)showHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText animated:(BOOL)animated;
- (void)hideHUDUsingAnimation:(BOOL)animated;
- (void)showHUDWithLabel:(NSString *)labelText details:(NSString *)detailsLabelText whileExecuting:(SEL)selector onTarget:(id)target withObject:(id)object animated:(BOOL)animated;
- (void)hudWasHidden;

#pragma mark Core Data

- (void)save:(NSError **)error;

@end
