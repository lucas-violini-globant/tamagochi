//
//  TamagochiContact.m
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TamagochiContactList.h"

@interface TamagochiContactList()

@property (nonatomic, strong) NSString *firstNameKey;
@property (nonatomic, strong) NSString *lastNameKey;
@property (nonatomic, strong) NSString *phoneKey;
@property (nonatomic, strong) NSString *emailKey;
@property (nonatomic, strong) NSString *companyKey;
@end

@implementation TamagochiContactList : NSObject

-(instancetype)init
{
    self = [super init];
    if (self)
    {
    self.firstNameKey = @"first";
    self.lastNameKey = @"last";
    self.phoneKey = @"phone";
    self.emailKey = @"email";
    self.companyKey = @"company";
    }
    return self;
}

-(void)addContactWithFirstName:(NSString *) firstNameString lastName:(NSString *)lastNameString phone:(NSString *)phone company:(NSString *)company email:(NSString *)email

{
    
    NSMutableDictionary *contact = [[NSMutableDictionary alloc ]initWithObjectsAndKeys:
                                    firstNameString,self.firstNameKey,
                                    lastNameString,self.lastNameKey,
                                    phone,self.phoneKey,
                                    company, self.companyKey,
                                    email ,self.emailKey,nil];
    
    [self.local_array addObject:contact];
}

-(BOOL)hasContactWithFirstName:(NSString *)firstNameString andLastName:(NSString *)lastNameString
{
    BOOL found = NO;
    NSString *first;
    NSString *last;
    
    for (NSMutableDictionary *contact in self.local_array)
    {
        
        first =[contact objectForKey:self.firstNameKey];
        last = [contact objectForKey:self.lastNameKey];
        
        if (([first isEqualToString:firstNameString]) && ([last isEqualToString:lastNameString]))
        {
            found = YES;
        }
    }
    
    return found;
}

-(void)drop
{
    [self.local_array removeAllObjects];
}

-(int)count
{
    return [self.local_array count];
}

-(NSMutableDictionary *)objectAtIndex:(NSUInteger)index
{
    if ([self count] > index)
    {
        return [self.local_array objectAtIndex:index];
    }
    return [[NSMutableDictionary alloc] init];
}

@end