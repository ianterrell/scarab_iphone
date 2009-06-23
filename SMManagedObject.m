//
//  SMManagedObject.m
//  Scarab
//
//  Created by Ian Terrell on 6/10/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import "SMManagedObject.h"

@implementation SMManagedObject

#pragma mark Basics

-(id)init {
  NSEntityDescription *entity = [[[AppDelegate managedObjectModel] entitiesByName] objectForKey:[[self class] className]];
  return [self initWithEntity:entity insertIntoManagedObjectContext:nil];
}

+(NSManagedObjectContext *)defaultContext {
  return [AppDelegate managedObjectContext];
}

#pragma mark Fetch

+(NSMutableArray *)fetch {
  return [self fetchInContext:nil first:NO predicate:nil sortDescriptors:nil];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptors:nil];
}

+(id)fetchFirst {
  return [self fetchInContext:nil first:YES predicate:nil sortDescriptors:nil];
}

+(id)fetchFirstWithPredicate:(NSPredicate *)predicate {
  return [self fetchInContext:nil first:YES predicate:predicate sortDescriptors:nil];
}

#pragma mark Fetch Sorted

+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchInContext:nil first:NO predicate:nil sortDescriptor:sortDescriptor];
}

+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:NO predicate:nil sortDescriptors:sortDescriptors];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptor:sortDescriptor];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptors:sortDescriptors];
}

+(id)fetchFirstWithSortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchInContext:nil first:YES predicate:nil sortDescriptor:sortDescriptor];
}

+(id)fetchFirstWithSortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:YES predicate:nil sortDescriptors:sortDescriptors];
}

+(id)fetchFirstWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
  return [self fetchInContext:nil first:YES predicate:predicate sortDescriptor:sortDescriptor];
}

+(id)fetchFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:YES predicate:predicate sortDescriptors:sortDescriptors];
}

#pragma mark Main Fetchers

+(id)fetchInContext:(NSManagedObjectContext *)managedObjectContext first:(BOOL)first predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSMutableArray *fetchedItems = [self fetchInContext:managedObjectContext first:first predicate:predicate sortDescriptors:sortDescriptors];
  [sortDescriptors release];
  return fetchedItems;
}

+(id)fetchInContext:(NSManagedObjectContext *)managedObjectContext first:(BOOL)first predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
  if (managedObjectContext == nil)
    managedObjectContext = [self defaultContext];
  
	NSEntityDescription *entity = [NSEntityDescription entityForName:[self className] inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
  [request setPredicate:predicate];
	[request setSortDescriptors:sortDescriptors];
  
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		NSLog(@"Error fetching results in SMManagedObject");
    // TODO: really handle something if necessary.
	}
  [request release];
	[mutableFetchResults autorelease];
  
  if (first)
    return [mutableFetchResults count] > 0 ? [mutableFetchResults objectAtIndex:0] : nil;
  else
    return mutableFetchResults;
}

@end
