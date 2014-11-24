//
//  TamagochiStatusViewController.h
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "TamagochiFoodSelectionViewController.h"

@interface TamagochiStatusViewController : UIViewController<FoodProtocol, MFMailComposeViewControllerDelegate>

-(IBAction)sendEmail:(id)sender;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petName:(NSString *)aString tagSelected:(int)anInt;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;

-(NSArray *)getFeedingImageArrayByTag:(long)tag;
-(NSArray *)getFeedingImageArrayForCurrentPet;

@end
