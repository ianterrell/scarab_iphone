//
//  SMManagedObject.m
//  Scarab
//
//  Created by Ian Terrell on 6/10/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMManagedObject.h"

@implementation SMManagedObject

-(id)init {
  NSEntityDescription *entity = [[[AppDelegate managedObjectModel] entitiesByName] objectForKey:[[self class] className]];
  return [self initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSManagedObjectContext *)defaultContext {
  return [AppDelegate managedObjectContext];
}

+(NSMutableArray *)fetch {
  return [self fetchInContext:nil withSortDescriptors:nil];
}

+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchInContext:nil withSortDescriptor:sortDescriptor];
}

+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil withSortDescriptors:sortDescriptors];
}

+(NSMutableArray *)fetchInContext:(NSManagedObjectContext *)managedObjectContext {
  return [self fetchInContext:managedObjectContext withSortDescriptors:nil];
}

+(NSMutableArray *)fetchInContext:(NSManagedObjectContext *)managedObjectContext withSortDescriptor:(NSSortDescriptor *)sortDescriptor {
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSMutableArray *fetchedItems = [self fetchInContext:managedObjectContext withSortDescriptors:sortDescriptors];
  [sortDescriptors release];
  return fetchedItems;
}

+(NSMutableArray *)fetchInContext:(NSManagedObjectContext *)managedObjectContext withSortDescriptors:(NSArray *)sortDescriptors {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
  if (managedObjectContext == nil) {
    managedObjectContext = [self defaultContext];
  }
  
	NSEntityDescription *entity = [NSEntityDescription entityForName:[self className] inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
	
  if (sortDescriptors != nil)
    [request setSortDescriptors:sortDescriptors];
  
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		NSLog(@"Error fetching results in SMManagedObject");
    // TODO: really handle something if necessary.
	}
  [request release];
	
  return [mutableFetchResults autorelease];
}

@end
