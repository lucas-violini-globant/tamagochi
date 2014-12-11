//
//  TamagochiMKMapAnnotation.m
//  Tamagochi
//
//  Created by Lucas on 12/2/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TamagochiPet.h"
#import <MapKit/MapKit.h>

@interface TamagochiMKMapAnnotation : NSObject
@property (nonatomic, copy) TamagochiPet *pet;

@end

@implementation TamagochiMKMapAnnotation : NSObject

-(id)initWithPet:(TamagochiPet *)aPet
{
    self = [super init];
    if (self)
    {
        _pet = aPet;
                
        //[self setCoordinate: CLLocationCoordinate2DMake([aPet getLatitude], [aPet getLongitude])];

    }
    return self;
}
@end

