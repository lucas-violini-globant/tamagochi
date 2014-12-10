//
//  ContactTableViewCell.h
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "TamagochiSelectNameViewController.h"
#import "TamagochiContactsViewController.h"

@interface ContactTableViewCell : UITableViewCell<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) TamagochiContactsViewController *tableViewController;

-(void)configureForContact:(NSMutableDictionary *) aDictionary;

@end
