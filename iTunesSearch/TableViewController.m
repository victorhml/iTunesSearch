//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Ebook.h"
#import "Entidades/Podcast.h"
#import "Entidades/Musica.h"
#import "Detalhes.h"



@interface TableViewController () {
    NSArray *midias;
    NSArray *mid;
//    NSString *strSearch;
}

@end

@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
    [_button setTitle: NSLocalizedString(@"Search", @"Botão")forState:UIControlStateNormal];
    self.navigationController.navigationBar.translucent = NO;
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [midias count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[midias objectAtIndex:section]count];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
            
case 0: return @"Movie";
case 1: return @"Book";
case 2: return @"Podcast";
case 3: return @"Music";
    }
    return @"oi";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    mid = [[NSArray alloc] initWithArray:[midias objectAtIndex:indexPath.section]];
    
    Filme *filme;
    Ebook *ebook;
    Podcast *podcast;
    Musica *musica;
    
    long row = [indexPath row];
    
    switch (indexPath.section) {
        case 0:{
            filme = [mid objectAtIndex:row];
            [celula.nome setText:filme.nome];
            [celula.tipo setText:@"Movie"];
            [celula.genero setText:filme.genero];
            [celula.preco setText:[NSString stringWithFormat: @"US$ %@", filme.preco]];
            [celula.duracao setText:[self formatInterval:[NSString stringWithFormat: @"%@", filme.duracao]]];
            NSURL *urlf = [NSURL URLWithString:filme.imgUrl];
            NSData *imgDataf = [NSData dataWithContentsOfURL:urlf];
            UIImage *imgf = [UIImage imageWithData:imgDataf];
            [celula.imageView setImage:imgf];
        }
            break;
        case 1:{
            ebook = [mid objectAtIndex:row];
            [celula.nome setText:ebook.nomeb];
            [celula.tipo setText:@"Book"];
            [celula.genero setText:ebook.generob];
            [celula.preco setText:[NSString stringWithFormat: @"US$ %@", ebook.precob]];
            NSURL *urlb = [NSURL URLWithString:ebook.imgUrlb];
            NSData *imgDatab = [NSData dataWithContentsOfURL:urlb];
            UIImage *imgb = [UIImage imageWithData:imgDatab];
            [celula.imageView setImage:imgb];
        }
            break;
        case 2:{
            podcast = [mid objectAtIndex:row];
            [celula.nome setText:podcast.nomep];
            [celula.tipo setText:@"Podcast"];
            [celula.genero setText:podcast.generop];
            [celula.preco setText:[NSString stringWithFormat: @"US$ %@", podcast.precop]];
            [celula.duracao setText:[self formatInterval:[NSString stringWithFormat: @"%@", podcast.duracaop]]];
            NSURL *urlp = [NSURL URLWithString:podcast.imgUrlp];
            NSData *imgDatap = [NSData dataWithContentsOfURL:urlp];
            UIImage *imgp = [UIImage imageWithData:imgDatap];
            [celula.imageView setImage:imgp];
        }
            break;
        case 3:{
            musica = [mid objectAtIndex:row];
            [celula.nome setText:musica.nomem];
            [celula.tipo setText:@"Music"];
            [celula.genero setText:musica.generom];
            [celula.preco setText:[NSString stringWithFormat: @"US$ %@", musica.precom]];
            [celula.duracao setText:[self formatInterval:[NSString stringWithFormat: @"%@", musica.duracaom]]];
            NSURL *urlm = [NSURL URLWithString:musica.imgUrlm];
            NSData *imgDatam = [NSData dataWithContentsOfURL:urlm];
            UIImage *imgm = [UIImage imageWithData:imgDatam];
            [celula.imageView setImage:imgm];
        }
            break;
        default:
            break;
    }
    
    return celula;
}

- (NSString *) formatInterval: (NSString *) time{
    NSTimeInterval interval;
    if([time doubleValue]){
        interval = [time doubleValue];
    }
    else {
        interval = 0.0;
    }
    unsigned long milliseconds = interval;
    unsigned long seconds = milliseconds / 1000;
    milliseconds %= 1000;
    unsigned long minutes = seconds / 60;
    seconds %= 60;
    unsigned long hours = minutes / 60;
    minutes %= 60;
    
    NSMutableString * result = [NSMutableString new];
    
    if(hours)
        [result appendFormat: @"%lu:", hours];
    
    [result appendFormat: @"%lu:", minutes];
    [result appendFormat: @"%lu", seconds];
    
    return result;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Detalhes *det = [[Detalhes alloc]init];
    det.row = [indexPath row];
    det.section = [indexPath section];
    [[self navigationController]pushViewController:det animated:YES];
}
- (IBAction)button:(id)sender {
    _txtSearch=_searchBar.text;
    _txtSearch=[_txtSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    iTunesManager *itunes =[iTunesManager sharedInstance];
    midias = [itunes buscarMidias:_txtSearch];
    [self.tableview reloadData];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_searchBar resignFirstResponder];
}

@end
