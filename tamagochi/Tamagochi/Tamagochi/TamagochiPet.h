//
//  TamagochiPet.h
//  Tamagochi
//
//  Created by Lucas on 11/24/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//


#import "TamagochiFood.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>
#import "TamagochiPersistenceHelper.h"
#import <UIKit/UIKit.h>

@interface TamagochiPet : NSManagedObject<NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *typeName;
@property int tagId;
@property (nonatomic, strong) NSArray *feedingImages;
@property (nonatomic, strong) NSArray *exercisingImages;
@property (nonatomic, strong) NSArray *exhaustedImages;
@property (nonatomic, strong) NSArray *exhaustedToNormalImages;
@property float energy;
@property float exerciseEnergyCost;
@property int level;
@property float experience;
//@property BOOL stateIsExercising;
//@property BOOL stateIsEating;
@property (nonatomic, strong) NSString *imageNameNormal;
@property (nonatomic, strong) NSString *imageNameExhausted;
@property (nonatomic, strong) NSString *imageNameCurrent;
@property (nonatomic, strong) NSString *uniqueCode;
@property  float position_lat;
@property  float position_lon;

-(void) configureWithTag:(int)someTag;

-(int) getTag;

-(void) setName:(NSString *)someName;

-(NSString *)getPetName;

-(NSString *)getName;

-(NSString *)getUniqueCode;

-(NSString *)getPetType;

-(int)getLevel;

-(float)getExperience;

-(NSArray *)getFeedingImagesArray;

-(NSArray *)getExercisingImagesArray;

-(NSArray *)getExhaustedImagesArray;

-(NSString *)getImage;

+ (instancetype) sharedInstance;

+ (instancetype) newInstance;

+(instancetype) newInstanceClean;

-(BOOL) eatFood:(TamagochiFood *) someFood;

-(BOOL) doneEating;

-(BOOL) isEating;

-(BOOL) exercise;

-(BOOL) doneExercising;

-(BOOL) isExercising;

-(float)getEnergy;

-(BOOL) canBeExercised;

-(BOOL) canBeFed;

-(BOOL) isExhausted;

-(BOOL)setFromDictionary:(NSDictionary *) aDictionary;

-(float)getLatitude;

-(float)getLongitude;

-(void)setLatitude:(float)latitude;

-(void)setLongitude:(float)longitude;

+(id)newInstanceAndInitWithDictionary:(NSDictionary *) aDictionary;

- (NSComparisonResult)compareLevel:(TamagochiPet *)otherObject;

- (void) saveData;

+(void)loadFromDataBaseByUniqueCode:(NSString *)unique_code;

-(void)saveToDataBase;

@end
