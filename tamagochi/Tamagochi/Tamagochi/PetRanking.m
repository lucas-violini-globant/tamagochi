//
//  PetRanking.m
//  Tamagochi
//
//  Created by Lucas on 11/29/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TamagochiPet.h"


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
    if ([_localArray count] >= position)
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


@end

