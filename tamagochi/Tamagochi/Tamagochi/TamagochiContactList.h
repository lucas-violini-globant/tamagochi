//
//  TamagochiContact.h
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//



@interface TamagochiContactList : NSObject

@property (nonatomic, strong) NSMutableArray *local_array;


-(BOOL)hasContactWithFirstName:(NSString *)firstNameString andLastName:(NSString *)lastNameString;

-(void)addContactWithFirstName:(NSString *) firstNameString lastName:(NSString *)lastNameString phone:(NSString *)phone company:(NSString *)company email:(NSString *)email;

-(void)drop;

-(int)count;

-(NSMutableDictionary *)objectAtIndex:(NSUInteger)index;

@end