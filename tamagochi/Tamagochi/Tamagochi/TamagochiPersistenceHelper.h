//
//  TamagochiPersistenceHelper.h
//  Tamagochi
//
//  Created by Lucas on 12/3/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#ifndef Tamagochi_TamagochiPersistenceHelper_h
#define Tamagochi_TamagochiPersistenceHelper_h


#endif

#import <CoreData/CoreData.h>

@interface TamagochiPersistenceHelper : NSObject


@property (nonatomic, retain, readonly) NSManagedObjectModel * managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory; // nice to have to reference files for core data
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
- (NSManagedObjectModel *)managedObjectModel;
- (NSManagedObjectContext *)managedObjectContext;
- (void)saveContext;
+ (instancetype) sharedInstance;


@end