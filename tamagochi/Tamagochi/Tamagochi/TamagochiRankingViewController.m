//
//  TamagochiRankingViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/29/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiRankingViewController.h"
#import "TamagochiNetworking.h"
#import "TamagochiUITableViewCell.h"
#import "PetRanking.h"
#import "TamagochiRankingTableViewCell.h"

@interface TamagochiRankingViewController ()


@end

@implementation TamagochiRankingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.



    
    /*
     TamagochiNetworking *tn = [[TamagochiNetworking alloc] init];
     //BOOL result = [tn downloadPetFromServer];
    
    TamagochiRankingViewController * __weak weakerSelf = self;
    
    [tn downloadPetsArrayFromServerWithSuccess:^{[weakerSelf petRankingDownloadSuccess];}
                                 failure:^{[weakerSelf petRankingDownloadFailure];}];
     */
    
    [_tablaRanking registerNib:[UINib nibWithNibName:@"TamagochiRankingTableViewCell" bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:@"cellIdRanking"];
    
    [_tablaRanking reloadData];
    
}

-(void)petRankingDownloadSuccess
{
    [_tablaRanking registerNib:[UINib nibWithNibName:@"TamagochiRankingTableViewCell" bundle:[NSBundle mainBundle]]
       forCellReuseIdentifier:@"cellIdRanking"];
    
    [_tablaRanking reloadData];
    
}

-(void)petRankingDownloadFailure
{
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There was an error downloading the ranking" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //_foodCollection = [[TamagochiFoodCollection alloc] init];
    }
    return self;
}


//Delegate: Implemento el protocolo de UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[PetRanking sharedInstance] count];
}



//Delegate: Implemento el protocolo de UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Intentamos recuperar una celda ya creada.
    TamagochiRankingTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdRanking"];
    if (cell == nil) {
        //Si la celda no existe, la creamos.
        cell = [[TamagochiRankingTableViewCell alloc] init];
    }
    //Configurar la celda con los datos del objeto que corresponda mostrar en esta fila

    [cell configurarParaMascota:indexPath.row enPetRanking:[PetRanking sharedInstance] ];
    return cell;
}


//Delegate: Implemento el protocolo de UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86.0f;
}

//Delegate: Implemento el protocolo de UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
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
