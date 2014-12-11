//
//  TamagochiContactsViewController.m
//  Tamagochi
//
//  Created by Lucas on 12/6/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiContactsViewController.h"
#import <AddressBookUI/AddressBookUI.h>
#import "TamagochiContactList.h"
#import "ContactTableViewCell.h"

@interface TamagochiContactsViewController ()

@property (nonatomic,strong) TamagochiContactList *contacts;

@property (strong, nonatomic) IBOutlet UITableView *contactos;
@end

@implementation TamagochiContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _contacts = [[TamagochiContactList alloc] init];
    [self accessContacts];
    [_contactos registerNib:[UINib nibWithNibName:@"ContactTableViewCell" bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:@"cellIdContact"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.contacts = [[TamagochiContactList alloc] init];
    }
    return self;
}

#pragma mark - Acceso a lista de contactos

-(void)accessContacts
{
    
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    if (status == kABAuthorizationStatusDenied) {
        // if you got here, user had previously denied/revoked permission for your
        // app to access the contacts, and all you can do is handle this gracefully,
        // perhaps telling the user that they have to go to settings to grant access
        // to contacts
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (error) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        if (addressBook) CFRelease(addressBook);
        return;
    }
    
    if (status == kABAuthorizationStatusNotDetermined) {
        
        // present the user the UI that requests permission to contacts ...
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (error) {
                NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
            }
            
            if (granted) {
                // if they gave you permission, then just carry on
                
                [self listPeopleInAddressBook:addressBook];
            } else {
                // however, if they didn't give you permission, handle it gracefully, for example...
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // BTW, this is not on the main thread, so dispatch UI updates back to the main queue
                    
                    [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                });
            }
            
            if (addressBook) CFRelease(addressBook);
        });
        
    } else if (status == kABAuthorizationStatusAuthorized) {
        [self listPeopleInAddressBook:addressBook];
        if (addressBook) CFRelease(addressBook);
    }
}

- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook
{
    NSInteger numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    
    //Elimino lo que haya, previo a levantar los contactos nuevamente...
    [self.contacts drop];
    
    //Itero sobre los contactos...
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        
        //Aca agrego TODOS los contactos a mi TamagochiContactList
        //Va iterando sobre cada item de la lista de contactos del iPhone
        //Uno por uno los va agregando al TamagochiContactList
        
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));

        
        NSString *company = CFBridgingRelease(ABRecordCopyValue(person,kABPersonOrganizationProperty));
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        NSString *phoneNumber = @"";
        CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
        if (numberOfPhoneNumbers > 0) {
             phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, 0));
            NSLog(@"  phone:%@", phoneNumber);
        }
        
        ABMultiValueRef emailAddresses = ABRecordCopyValue(person , kABPersonEmailProperty);
        NSString *emailAddress = @"";
        CFIndex numberOfEmailAddresses = ABMultiValueGetCount(emailAddresses);
        if (numberOfEmailAddresses > 0)
        {
            emailAddress = CFBridgingRelease(ABMultiValueCopyValueAtIndex(emailAddresses,0));
        }
        
        
        //Agrego los datos...
        [self.contacts addContactWithFirstName:firstName lastName:lastName phone:phoneNumber company:company email:emailAddress];
        NSLog(@"Name:%@ %@", firstName, lastName);
        
        NSLog(@"=============================================");
        CFRelease(phoneNumbers);
    }
    
    for (NSMutableDictionary *contact in self.contacts.local_array)
    {
        NSLog([contact valueForKey:@"first"],nil);
    }
}





#pragma mark - Metodos del protocolo para UITableView
//Delegate: Implemento el protocolo de UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.contacts count];    //return [[PetRanking sharedInstance] count];
}



//Delegate: Implemento el protocolo de UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Intentamos recuperar una celda ya creada.
    ContactTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdContact"];
    if (cell == nil) {
        //Si la celda no existe, la creamos.
        cell = [[ContactTableViewCell alloc] init];
    }
    
    //Configurar la celda con los datos del objeto que corresponda mostrar en esta fila
    [cell configureForContact:[self.contacts objectAtIndex:indexPath.row]];
    [cell setTableViewController:self];
    return cell;
}


//Delegate: Implemento el protocolo de UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118.0f;
}

//Delegate: Implemento el protocolo de UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
