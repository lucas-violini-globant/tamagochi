//
//  TamagochiMapViewController.h
//  Tamagochi
//
//  Created by Lucas on 12/2/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "TamagochiPet.h"

@interface TamagochiMapViewController : UIViewController<MKMapViewDelegate>

-(void)displayOnePet:(TamagochiPet *)aPet;

@end
