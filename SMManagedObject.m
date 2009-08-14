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
  return [self fetchInContext:nil first:NO predicate:nil sortDescriptors:nil limit:0];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptors:nil limit:0];
}

+(NSMutableArray *)fetchLimit:(int)limit {
  return [self fetchInContext:nil first:NO predicate:nil sortDescriptors:nil limit:limit];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate limit:(int)limit {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptors:nil limit:limit];
}

+(id)fetchFirst {
  return [self fetchInContext:nil first:YES predicate:nil sortDescriptors:nil limit:0];
}

+(id)fetchFirstWithPredicate:(NSPredicate *)predicate {
  return [self fetchInContext:nil first:YES predicate:predicate sortDescriptors:nil limit:0];
}

#pragma mark Fetch Sorted

+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchInContext:nil first:NO predicate:nil sortDescriptor:sortDescriptor limit:0];
}

+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:NO predicate:nil sortDescriptors:sortDescriptors limit:0];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptor:sortDescriptor limit:0];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptors:sortDescriptors limit:0];
}

+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor limit:(int)limit {
	return [self fetchInContext:nil first:NO predicate:nil sortDescriptor:sortDescriptor limit:limit];
}

+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors limit:(int)limit {
  return [self fetchInContext:nil first:NO predicate:nil sortDescriptors:sortDescriptors limit:limit];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor limit:(int)limit {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptor:sortDescriptor limit:limit];
}

+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors limit:(int)limit {
  return [self fetchInContext:nil first:NO predicate:predicate sortDescriptors:sortDescriptors limit:limit];
}

+(id)fetchFirstWithSortDescriptor:(NSSortDescriptor *)sortDescriptor {
	return [self fetchInContext:nil first:YES predicate:nil sortDescriptor:sortDescriptor limit:0];
}

+(id)fetchFirstWithSortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:YES predicate:nil sortDescriptors:sortDescriptors limit:0];
}

+(id)fetchFirstWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor {
  return [self fetchInContext:nil first:YES predicate:predicate sortDescriptor:sortDescriptor limit:0];
}

+(id)fetchFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors {
  return [self fetchInContext:nil first:YES predicate:predicate sortDescriptors:sortDescriptors limit:0];
}

#pragma mark Main Fetchers

+(id)fetchInContext:(NSManagedObjectContext *)managedObjectContext first:(BOOL)first predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor limit:(int)limit {
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	NSMutableArray *fetchedItems = [self fetchInContext:managedObjectContext first:first predicate:predicate sortDescriptors:sortDescriptors limit:limit];
  [sortDescriptors release];
  return fetchedItems;
}

+(id)fetchInContext:(NSManagedObjectContext *)managedObjectContext first:(BOOL)first predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors limit:(int)limit {
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
  
  if (managedObjectContext == nil)
    managedObjectContext = [self defaultContext];
  
	NSEntityDescription *entity = [NSEntityDescription entityForName:[self className] inManagedObjectContext:managedObjectContext];
	[request setEntity:entity];
  [request setPredicate:predicate];
	[request setSortDescriptors:sortDescriptors];
  if (first)
    [request setFetchLimit:1];
  else if (limit > 0)
    [request setFetchLimit:limit];
      
	NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
	if (mutableFetchResults == nil) {
		NSLog(@"Error fetching results in SMManagedObject");
    [AppDelegate showGenericError];
	}
  [request release];
	[mutableFetchResults autorelease];
  
  if (first)
    return [mutableFetchResults count] > 0 ? [mutableFetchResults objectAtIndex:0] : nil;
  else
    return mutableFetchResults;
}

#pragma mark Objective Resource Helpers

+ (NSArray *)findAllSinceNumber:(NSNumber *)number {
  // htp://server/models/since/:number.xml
  NSString *sincePath = [NSString stringWithFormat:@"%@%@/since/%d%@",
                         [self getRemoteSite],
                         [self getRemoteCollectionName],
                         [number intValue],
                         [self getRemoteProtocolExtension]];
  Response *response = [Connection get:sincePath];
	return [self performSelector:[self getRemoteParseDataMethod] withObject:response.body];
}


@end
