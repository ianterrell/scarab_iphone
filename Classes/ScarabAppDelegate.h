//
//  ScarabAppDelegate.h
//  Scarab
//
//  Created by Ian Terrell on 6/9/09.
//  Copyright Ian Terrell 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SplashScreenController;

@interface ScarabAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, TTNavigationDelegate> {
  UIWindow *window;
  UITabBarController *tabBarController;
  SplashScreenController *splashScreenController;
  
  NSPersistentStoreCoordinator *persistentStoreCoordinator;
  NSManagedObjectModel *managedObjectModel;
  NSManagedObjectContext *managedObjectContext;	  
}

@property(nonatomic,retain) IBOutlet UIWindow *window;
@property(nonatomic,retain) IBOutlet UITabBarController *tabBarController;
@property(nonatomic,retain) IBOutlet SplashScreenController *splashScreenController;

@property(nonatomic,retain,readonly) NSManagedObjectModel *managedObjectModel;
@property(nonatomic,retain,readonly) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,retain,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,readonly) NSString *applicationDocumentsDirectory;

-(void)doneWithSplash;

-(void)save:(NSError **)error;

@end
