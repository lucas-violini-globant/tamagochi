//
//  TamagochiFoodCollection.m
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TamagochiFood.h"


@interface TamagochiFoodCollection : NSObject

@property (nonatomic,strong)NSMutableArray *foodArray;

@end


@implementation TamagochiFoodCollection : NSObject

-(id)init
{
    self = [super init];
    if (self)
    {
        _foodArray = [[NSMutableArray alloc] init];
        int i;
        for (i=0; i < 9; i++)
        {
            [_foodArray addObject:[[TamagochiFood alloc] initWithFoodId:i]];
        }
    }
    return self;
}


-(id)getFoodById:(int)foodId
{
    return [_foodArray objectAtIndex:foodId];
}

-(long)size
{
    return [self count];
}

-(long)count
{
    return [_foodArray count];
}

@end