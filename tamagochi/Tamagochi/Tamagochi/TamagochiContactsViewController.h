//
//  TamagochiContactsViewController.h
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@protocol SendEmailProtocol <NSObject>
-(id)sendEmailToAddress:(NSString*)emailAddress;
-(id)callToNumber:(NSString *)phoneNumber;
@end

@interface TamagochiContactsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@end
