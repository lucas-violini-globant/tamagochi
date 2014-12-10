//
//  ContactTableViewCell.h
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ContactTableViewCell : UITableViewCell<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *firstAndLastName;
@property (strong, nonatomic) IBOutlet UILabel *company;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *email;

-(void)configureForContact:(NSMutableDictionary *) aDictionary;
@end
