//
//  TamagochiFoodSelectionViewController.m
//  Tamagochi
//
//  Created by Lucas on 11/20/14.
//  Copyright (c) 2014 Lucas. All rights reserved.
//

#import "TamagochiFoodSelectionViewController.h"
#import "TamagochiFoodCollection.h"
#import "TamagochiUITableViewCell.h"

@interface TamagochiFoodSelectionViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tablaComida;
@property (strong, nonatomic) TamagochiFoodCollection *foodCollection;


@end

@implementation TamagochiFoodSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tablaComida registerNib:[UINib nibWithNibName:@"TamagochiUITableViewCell" bundle:[NSBundle mainBundle]]
       forCellReuseIdentifier:@"cellId"];
    
    [_tablaComida reloadData];
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
        _foodCollection = [[TamagochiFoodCollection alloc] init];
    }
    return self;
}


//Delegate: Implemento el protocolo de UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.foodCollection count];
}

//Delegate: Implemento el protocolo de UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Intentamos recuperar una celda ya creada.
     TamagochiUITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        //Si la celda no existe, la creamos.
        cell = [[TamagochiUITableViewCell alloc] init];
    }
    //Configurar la celda con los datos del objeto que corresponda mostrar en esta fila
    [cell configurarParaComida:indexPath.row enColeccionDeComida:self.foodCollection];
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
    TamagochiFood * comida = [self.foodCollection getFoodById:indexPath.row];
    [self.delegate foodSelected:comida];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
