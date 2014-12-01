//
//  TamagochiSelectNameViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiSelectNameViewController.h"
#import "TamagochiStatusViewController.h"
#import "TamagochiPet.h"

@interface TamagochiSelectNameViewController ()
@property (nonatomic)NSString *petName;
@property int petTag;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *btnCiervo;

@property (strong, nonatomic) IBOutlet UIButton *btnGato;

@property (strong, nonatomic) IBOutlet UIButton *btnJirafa;

@property (strong, nonatomic) IBOutlet UIButton *btnLeon;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *petNameTextField;

@property (strong, nonatomic) IBOutlet UILabel *animalTypeLabel;


@end

@implementation TamagochiSelectNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.scrollView.contentOffset = CGPointMake(0.0f, 0.0f);
    //self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width * 1.5f, self.scrollView.contentSize.height);
    self.scrollView.contentSize = CGSizeMake(120,1700);
    self.petNameTextField.text = self.petName;

 
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchToStatusScreen:(id)sender {
    
    //Singleton: Obtengo la instancia de TamagochiPet y le paso el tag, para que se setee solo
    [[TamagochiPet sharedInstance] setTag:self.petTag];
    
    [[TamagochiPet sharedInstance] setName:self.petName];
    
    //TamagochiStatusViewController *home = [[TamagochiStatusViewController alloc] initWithNibName:@"TamagochiStatusViewController" bundle:nil petName:self.petName tagSelected:self.petTag];
    TamagochiStatusViewController *home = [[TamagochiStatusViewController alloc] initWithNibName:@"TamagochiStatusViewController" bundle:nil];    
    [self.navigationController pushViewController:home animated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petName:(NSString *)aString
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setPetName:aString];
    }
    return self;
}

- (IBAction)clickImagen:(id)sender {
    
    NSString *imageName = [self getImageNameByTag:[sender tag]];
    self.imageView.image = [UIImage imageNamed:imageName];
    self.petTag = [sender tag];
    
    self.animalTypeLabel.text = [self getAnimalTypeByTag:self.petTag];}





-(NSString *)getImageNameByTag:(long)tag
{
    NSString *imageName = @"";
    
    switch (tag) {
        case 0:
            imageName = @"ciervo_comiendo_1";
            break;
        case 1:
            imageName = @"gato_comiendo_1";
            break;
        case 2:
            imageName = @"jirafa_comiendo_1";
            break;
        case 3:
            imageName = @"leon_comiendo_1";
            break;
        default:
            imageName = @"";
            break;
    }
   return imageName;
    
}



-(NSString *)getAnimalTypeByTag:(long)tag
{
    NSString *imageName = @"";
    
    switch (tag) {
        case 0:
            imageName = @"Deer";
            break;
        case 1:
            imageName = @"Cat";
            break;
        case 2:
            imageName = @"Jiraph";
            break;
        case 3:
            imageName = @"Lion";
            break;
        default:
            imageName = @"Select";
            break;
    }
    return imageName;
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
