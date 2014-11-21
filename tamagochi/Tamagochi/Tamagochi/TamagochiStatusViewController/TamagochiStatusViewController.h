//
//  TamagochiStatusViewController.h
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TamagochiFoodSelectionViewController.h"

@interface TamagochiStatusViewController : UIViewController<FoodProtocol>

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petName:(NSString *)aString tagSelected:(int)anInt;

@end
