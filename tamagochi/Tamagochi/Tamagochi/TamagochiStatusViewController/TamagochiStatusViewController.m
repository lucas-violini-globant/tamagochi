//
//  TamagochiStatusViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/18/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiStatusViewController.h"
#import "TamagochiFoodSelectionViewController.h"



@interface TamagochiStatusViewController ()

@property (nonatomic,strong) NSString *petName;
@property int imageTag;

@property (strong, nonatomic) IBOutlet UIImageView *petImage;

@property (strong, nonatomic) IBOutlet UILabel *petNameLabel;

@property (strong, nonatomic) IBOutlet UIImageView *foodImage;
@end

@implementation TamagochiStatusViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *imageName = [self getImageNameByTag:self.imageTag];
    self.petImage.image = [UIImage imageNamed:imageName];
    self.petNameLabel.text = self.petName;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil petName:(NSString *)aString tagSelected:(int)anInt
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setPetName:aString];
        self.imageTag = anInt;
        
    }
    
    return self;
    
}


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



//Pasa a la pantalla de seleccion de comida
- (IBAction)switchToFoodSelection:(id)sender {
    TamagochiFoodSelectionViewController *home = [[TamagochiFoodSelectionViewController alloc] initWithNibName:@"TamagochiFoodSelectionViewController" bundle:nil];
    [home setDelegate:self];
    [self.navigationController pushViewController:home animated:YES];
    
}



//Delegate: Implemento el metodo del protocolo FoodProtocol
//Se invoca cuando se ha seleccionado una comida
-(id)foodSelected:(TamagochiFood *)foodObject
{
    self.foodImage.image = [UIImage imageNamed:[foodObject getImageName]];
    return self;
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
