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

@interface TableViewController () {
    NSArray *midias;
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
    
    iTunesManager *itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:@"Apple"];
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
    self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableview.bounds.size.width, 15.f)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [midias count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
    Filme *filme = [midias objectAtIndex:indexPath.row];
    
    [celula.nome setText:filme.nome];
    [celula.tipo setText:@"Filme"];
    [celula.genero setText:filme.genero];
    [celula.preco setText:[NSString stringWithFormat: @"Preço: US$ %@", filme.preco]];
    [celula.duracao setText:[self formatInterval:[NSString stringWithFormat: @"%@", filme.duracao]]];
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
//    [result appendFormat: @"%2d",milliseconds];
    
    return result;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

//-(void)search{
//    iTunesManager *itunes =[iTunesManager sharedInstance];
//    midias = [itunes buscarMidias:strSearch];
//    [_tableview reloadData];
//}

//- (IBAction)button:(id)sender {
//    strSearch = _searchBar.text;
//    strSearch = [strSearch stringByReplacingOccurrencesOfString:@" " withString:@"+"];
//    [_searchBar resignFirstResponder];
//    [self search];
//}

- (IBAction)button:(id)sender {
    iTunesManager *itunes =[iTunesManager sharedInstance];
    midias = [itunes buscarMidias:_searchBar.text];
    [self.tableview reloadData];
}

@end
