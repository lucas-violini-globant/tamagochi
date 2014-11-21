//
//  TamagochiFoodSelectionViewController.h
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TamagochiFood.h"

@protocol FoodProtocol <NSObject>

-(id)foodSelected:(TamagochiFood *)foodObject;

@end

@interface TamagochiFoodSelectionViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) id <FoodProtocol> delegate;
@end


