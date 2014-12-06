//
//  TamagochiContact.h
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//



@interface TamagochiContactList : NSObject

@property (nonatomic, strong) NSMutableArray *local_array;


-(void)addDictionaryWithContactInfo:(NSDictionary *)aDictionary;

-(void)hasContactWithFirstName:(NSString *)firstNameString andLastName:(NSString *)lastNameString;

-(void)drop;

@end