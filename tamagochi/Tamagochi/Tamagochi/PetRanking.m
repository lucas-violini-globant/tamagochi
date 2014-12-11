//
//  PetRanking.m
//  Tamagochi
//
//  Created by Lucas on 11/29/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TamagochiPet.h"
#import "TamagochiPersistenceHelper.h"
#import <CoreData/CoreData.h>


@interface PetRanking : NSObject

@property (nonatomic, strong) NSMutableArray *localArray;

@end


@implementation PetRanking : NSObject


-(id) init
{
    self = [super init];
    if (self)
    {
        _localArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addPet:(TamagochiPet *)aPet
{
    [_localArray addObject:aPet];
}

-(int)count
{
    return [_localArray count];
}


+ (instancetype) sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    //Garantiza que lo que se encuentre dentro solo se ejecutará una vez.
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
        }
    );
    return _sharedObject;
}



-(BOOL)addPetsInArray:(NSArray *) aNSArray
{
    NSString *code = @"";
    for (NSDictionary *petDict in aNSArray)
    {
        //Solo agrego mascotas si el "code" no existe previamente
        code = [petDict valueForKey:@"code"];
        NSLog(@"Procesando code: %@",code);
        if ([self hasPetWithUniqueCode:code])
        {
            TamagochiPet *pet = [self getPetWithUniqueCode:code];
            [pet setFromDictionary:petDict];
        }
        else
        {
            [_localArray addObject: [TamagochiPet newInstanceAndInitWithDictionary:petDict] ] ;
        }
    }
    [PetRanking saveToDataBase];

    
    //Finally, sort the ranking by level of each pet...
    [self sortByLevel];
    return YES;
}




-(BOOL) hasPetWithUniqueCode:(NSString *)uniqueCode
{
    BOOL result = NO;
    for (TamagochiPet *pet in _localArray)
    {
        if ([[pet getUniqueCode] isEqualToString:uniqueCode])
        {
            result = YES;
        }
    }
    return result;
}

-(id)getPetWithUniqueCode:(NSString *)uniqueCode
{
    TamagochiPet *result;
    
    for (TamagochiPet *pet in _localArray)
    {
        if ([[pet getUniqueCode] isEqualToString: uniqueCode])
        {
            result = pet;
        }
    }
    return result;
    
}

-(NSMutableArray *)getNSMutableArray
{
    return _localArray;
}

-(TamagochiPet *)getPetByPosition:(int)position
{

    TamagochiPet *pet;
    if ([_localArray count] > position)
    {
        pet = [_localArray objectAtIndex:position];
    }
    else
    {
        pet = nil;
    }
    return pet;
}

-(void)sortByLevel
{
    
    NSArray *sortedArray;

    sortedArray = [_localArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        return [(TamagochiPet*)a compareLevel:(TamagochiPet *)b];
    }];
    
    _localArray = [NSMutableArray arrayWithArray:sortedArray];
}


-(void)dropAll
{
    [self deleteDataBase];
    [_localArray removeAllObjects];
}

-(PetRanking *)loadFromDataBase
{
    [_localArray removeAllObjects];
    
    NSManagedObjectContext *context = [[TamagochiPersistenceHelper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TamagochiPet" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchLimit:200];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"level" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects != nil)
    {
        NSUInteger count = [fetchedObjects count]; // May be 0 if the object has been deleted.
        if (count)
        {
            for ( TamagochiPet *pet in fetchedObjects)
            {
                [pet configureWithTag:[pet getTag]];
                [self addPet:pet];
            }
        }
    }
    else
    {
        // Deal with error.
        NSLog(@"Error on TamagochiPet --> +(void)loadFromDataBaseByUniqueCode:");
    }
    return self;

    
}

-(void)deleteDataBase
{
    NSManagedObjectContext *context = [[TamagochiPersistenceHelper sharedInstance] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TamagochiPet" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    NSError * error = nil;
    NSArray * pets = [context executeFetchRequest:fetchRequest error:&error];
    //error handling goes here
    for (NSManagedObject * pet in pets) {
        [context deleteObject:pet]; }
    NSError *saveError = nil;
    if (![context save:&saveError])
    { //Guardamos los cambios en el contexto.
        NSLog([NSString stringWithFormat:@"Error, couldn't delete: %@", [saveError localizedDescription]], nil);
        [context rollback];
    }
}

+(void)saveToDataBase
{
    NSManagedObjectContext *context = [[TamagochiPersistenceHelper sharedInstance] managedObjectContext];

    NSError *saveError = nil;
    if (![context save:&saveError])
    { //Guardamos los cambios en el contexto.
        NSLog([NSString stringWithFormat:@"Error, couldn't delete: %@", [saveError localizedDescription]], nil);
        [context rollback];
    }
}




@end

