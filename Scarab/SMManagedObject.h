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

+(NSMutableArray *)fetch;
+(NSMutableArray *)fetchWithSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+(NSMutableArray *)fetchWithSortDescriptors:(NSArray *)sortDescriptors;
+(NSMutableArray *)fetchInContext:(NSManagedObjectContext *)managedObjectContext;
+(NSMutableArray *)fetchInContext:(NSManagedObjectContext *)managedObjectContext withSortDescriptor:(NSSortDescriptor *)sortDescriptor;
+(NSMutableArray *)fetchInContext:(NSManagedObjectContext *)managedObjectContext withSortDescriptors:(NSArray *)sortDescriptors;

@end
