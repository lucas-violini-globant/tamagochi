//
//  TestNetworking.m
//  Tamagochi
//
//  Created by Lucas on 11/26/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AFNetworking/AFNetworking.h"
#import "TamagochiPet.h"
#import "AFNetworking.h"
#import "PetRanking.h"



@interface TamagochiNetworking : NSObject

@property (nonatomic, strong) NSString *serverURL;
@property (nonatomic, strong) NSString *unique_code;

@end

@implementation TamagochiNetworking : NSObject

-(id)init
{
    self = [super init];
    if (self)
    {
        _serverURL = @"http://tamagotchi.herokuapp.com/pet";
        _unique_code = @"lv3503";

    }
    return self;
}

-(void)test0
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"foo": @"bar"};
    [manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


-(void)test1
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://echo.jsontest.com/key/value/one/two"
      parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if ([responseObject isKindOfClass:[NSArray class]])
         {
             NSArray *responseArray = responseObject;
             /* do something with responseArray */
             [self processArray:responseArray];
         }
         else if ([responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary *responseDict = responseObject;
             /* do something with responseDict */
             [self processDictionary:responseDict];
         }
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [self handleError:error];
     }
     ];
}


-(void)test2
{
    
}

-(BOOL)uploadServerWithPetInformation
//Updates the server with the status
{
    /*
     "code": "1234",
     "name":"panchito",
     "energy":100,
     "level": 0,
     "experience":15
    */
    TamagochiPet *pet = [TamagochiPet sharedInstance];
    
    NSString *code       = _unique_code;
    NSString *name       = [pet getName];
    NSString *energy     = [NSString stringWithFormat:@"%0.0f", [pet getEnergy] ];
    NSString *level      = [NSString stringWithFormat:@"%d", [pet getLevel] ];
    NSString *experience = [NSString stringWithFormat:@"%0.0f", [pet getExperience] ];
    
    NSDictionary *parameters = [[NSMutableDictionary alloc] initWithObjects:@[code,name,energy,level,experience]
                                                                    forKeys:@[@"code",@"name",@"energy",@"level",@"experience"] ];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];

    [manager POST : _serverURL
       parameters : parameters
          success : ^(AFHTTPRequestOperation *operation,NSError *error){NSLog(@"SUCCESS");}//[self getSuccessHandler]
          failure : ^(AFHTTPRequestOperation *operation,NSError *error){NSLog(@"ERROR %@",error);}//[self getErrorHandler]];
     ];
    return YES;
    
}


-(BOOL)downloadPetFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"Sending GET....");
    [manager GET:[NSString stringWithFormat:@"%@/%@",_serverURL,_unique_code]
      parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if ([responseObject isKindOfClass:[NSArray class]])
         {
             NSLog(@"PROBLEMA: SE DEVOLVIO ARRAY, SE ESPERABA DICTIONARY");
         }
         else if ([responseObject isKindOfClass:[NSDictionary class]])
         {
             TamagochiPet *pet = [TamagochiPet sharedInstance];
             [pet setFromDictionary: responseObject];

             [[NSNotificationCenter defaultCenter] postNotificationName:@"PET_DOWNLOAD_SUCCESS" object:nil];
             
         }
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {


     }
     ];
    NSLog(@"GET REQUEST COMPLETED!");
    return YES;
}



-(void)downloadPetFromServerWithSuccess:(void (^)())success
                                  failure:(void (^)())failure
{
    //(void (^)(AFHTTPRequestOperation *operation, id responseObject))
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"Sending GET....");
    [manager GET:[NSString stringWithFormat:@"%@/%@",_serverURL,_unique_code]
      parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(success)
         {
             success();
         }
         if ([responseObject isKindOfClass:[NSArray class]])
         {
             NSLog(@"PROBLEMA: SE DEVOLVIO ARRAY, SE ESPERABA DICTIONARY");
         }
         else if ([responseObject isKindOfClass:[NSDictionary class]])
         {
             TamagochiPet *pet = [TamagochiPet sharedInstance];
             [pet setFromDictionary: responseObject];
             

         }
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         if(failure)
         {
             failure();
         }

     }
     ];
    NSLog(@"GET REQUEST COMPLETED!");

}




-(void)processDictionary:(NSDictionary *) aResponse
{
    NSString * value = [aResponse valueForKey:@"key"];
    [self alertWithMessage:value];
    
}


-(void)processArray:(NSArray *) aResponse
{
    
}

-(void)alertWithMessage:(NSString *) message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"AFNetworking" message:message delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

-(void)handleError:(NSError *) anError
{
    
}


-(void)downloadPetsArrayFromServerWithSuccess:(void (^)())success
                                failure:(void (^)())failure
{
    //(void (^)(AFHTTPRequestOperation *operation, id responseObject))
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"Sending GET....");
    [manager GET:[NSString stringWithFormat:@"%@/%@",_serverURL,@"all"]
      parameters:nil
     
         success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         if(success) //si el parametro success esta seteado...
         {
             success(); //ejecuto esto (un bloque)

         if ([responseObject isKindOfClass:[NSArray class]])
            {
                NSLog(@"ARRAY DESCARGADO CON %d ELEMENTOS",[responseObject count]);
                PetRanking *ranking = [PetRanking sharedInstance];
                [ranking addPetsInArray:responseObject];
            }
         }
         else if ([responseObject isKindOfClass:[NSDictionary class]])
         {
              NSLog(@"PROBLEMA: SE DEVOLVIO DICTIONARY, SE ESPERABA UN ARRAY");
             if(failure) //si el parametro failure esta seteado...
             {
                 failure(); //ejecuto esto (un bloque)
             }

         }
     }
     
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         if(failure) //si el parametro failure esta seteado...
         {
             failure(); //ejecuto esto (un bloque)
         }
         
     }
     ];
    NSLog(@"GET REQUEST COMPLETED!");
    
}




@end