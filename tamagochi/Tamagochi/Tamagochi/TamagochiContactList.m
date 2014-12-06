//
//  TamagochiContact.m
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TamagochiContactList.h"


@implementation TamagochiContactList : NSObject

-(void)addContactWithFirstName:(NSString *) nameString lastName:(NSString *)lastNameString phone:(NSString *)phone company:(NSString *)company mail:(NSString *)email

-(void)addDictionaryWithContactInfo:(NSDictionary *)aDictionary
{
    self.local_array addObject:aDictionary
}

-(void)hasContactWithFirstName:(NSString *)firstNameString andLastName:(NSString *)lastNameString
{}

-(void)drop
{}

@end