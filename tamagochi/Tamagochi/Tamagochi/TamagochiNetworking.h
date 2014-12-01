//
//  TamagochiNetworking.h
//  Tamagochi
//
//  Created by Lucas on 11/26/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#ifndef Tamagochi_TamagochiNetworking_h
#define Tamagochi_TamagochiNetworking_h


#endif


@interface TamagochiNetworking : NSObject

-(void)test1;

-(BOOL)uploadServerWithPetInformation;

-(BOOL)downloadPetFromServer;

-(void)downloadPetFromServerWithSuccess:(void (^)())success
                                failure:(void (^)())failure;

-(void)downloadPetsArrayFromServerWithSuccess:(void (^)())success
                                      failure:(void (^)())failure;

@end