//
//  AppDelegate.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "AppDelegate.h"
#import "TamagochiWelcomeViewController.h"
#import "TamagochiSelectNameViewController.h"
#import "TamagochiNetworking.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    TamagochiWelcomeViewController* home = [[TamagochiWelcomeViewController alloc] initWithNibName:@"TamagochiWelcomeViewController" bundle:nil];
    UINavigationController* navControllerHome = [[UINavigationController alloc] initWithRootViewController:home];
    
    [self.window setRootViewController:navControllerHome];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes: (UIUserNotificationTypeAlert |UIUserNotificationTypeBadge | UIUserNotificationTypeSound) categories:nil]];
        }
        else
        {
            
            
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                                               UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)];
             
 
        }
    #else
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound)];
    #endif
    
    /*
    UILocalNotification *localNotif =
    [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotif)
    {
        NSString *itemName = [localNotif.userInfo objectForKey:@"UnaClave"];
        // custom method here...
        //[viewController displayItem:itemName];
        application.applicationIconBadgeNumber = localNotif.applicationIconBadgeNumber-1;
    }
     */
    
    [Parse setApplicationId:@"guhchukKgURzzZVCHBFOxyD35VHeMQm3EUZEdJvD"
                  clientKey:@"SnnbrQ9yOemJspA7LRt1MCACFFUYNkbQ1k2IM1vH"];
    
    
    
    return YES;
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"Successfully got a push token: %@", deviceToken);
    //Este token es el que utilizara nuestro servidor para enviarnos pushes remotas :).
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];

    [currentInstallation saveInBackground];
    
    //PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:@"PeleaDeMascotas" forKey:@"channels"];
    [currentInstallation saveInBackground];
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed to register for push notifications! Error was: %@", [error localizedDescription]);
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{

    NSString *remoteCode = [userInfo objectForKey:@"code"];
    if (remoteCode == nil) { remoteCode = @""; }
    NSString *remoteName = [userInfo objectForKey:@"name"];
    if (remoteName == nil) { remoteName = @""; }
    NSString *remoteLevel = [userInfo objectForKey:@"name"];
    if (remoteLevel == nil) { remoteLevel = @""; }
    NSString *remoteEnergy = [userInfo objectForKey:@"name"];
    if (remoteEnergy == nil) { remoteEnergy = @""; }
    NSString *remoteExperience = [userInfo objectForKey:@"name"];
    if (remoteExperience == nil) { remoteExperience = @""; }
    
    NSString *mensaje = [NSString stringWithFormat:@"La mascota %@ del usuario %@ esta ahora en nivel %@",remoteName,remoteCode,remoteLevel];
    //Recepcion de notificacion remota en foreground
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerta" message:mensaje delegate:self cancelButtonTitle:@"Esto es guerra!" otherButtonTitles: nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
