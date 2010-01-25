//
//  SMManagedObject.h
//  Scarab
//
//  Created by Ian Terrell on 6/10/09.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

@interface SMManagedObject : NSManagedObject {

}

+(NSManagedObjectContext *)defaultContext;

// Fetch
+(NSMutableArray *)fetch;
+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate;
+(NSMutableArray *)fetchLimit:(int)limit;
+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate limit:(int)limit;
+(id)fetchFirst;
+(id)fetchFirstWithPredicate:(NSPredicate *)predicate;

// Fetch sorted
+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors;
+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor;
+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;
+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor limit:(int)limit;
+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors limit:(int)limit;
+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor limit:(int)limit;
+(NSMutableArray *)fetchWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors limit:(int)limit;
+(id)fetchFirstWithSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+(id)fetchFirstWithSortDescriptors:(NSArray *)sortDescriptors;
+(id)fetchFirstWithPredicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor;
+(id)fetchFirstWithPredicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors;

// For that common pattern
+ (NSArray *)findAllSinceNumber:(NSNumber *)number;

// Main fetchers
+(id)fetchInContext:(NSManagedObjectContext *)managedObjectContext first:(BOOL)first predicate:(NSPredicate *)predicate sortDescriptor:(NSSortDescriptor *)sortDescriptor limit:(int)limit;
+(id)fetchInContext:(NSManagedObjectContext *)managedObjectContext first:(BOOL)first predicate:(NSPredicate *)predicate sortDescriptors:(NSArray *)sortDescriptors limit:(int)limit;


@end
