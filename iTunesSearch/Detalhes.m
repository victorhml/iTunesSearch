//
//  Detalhes.m
//  iTunesSearch
//
//  Created by Victor Lisboa on 13/03/15.
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


@interface Detalhes ()

@end

@implementation Detalhes

@synthesize row,section;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Detalhes";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    iTunesManager *im =[iTunesManager sharedInstance];
    id obje = [[im.midia objectAtIndex:section] objectAtIndex:row];

    
    switch (section) {
        case 0:{
            Filme *f = obje;
            [_nome setText:f.nome];
            [_tipo setText:@"Movie"];
            [_artista setText:f.artista];
            [_genero setText:f.genero];
            [_preco setText:[NSString stringWithFormat: @"US$ %@", f.preco]];
            [_pais setText:f.pais];
            [_imgUrl setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:f.imgUrl]]]];
        }
            break;
        case 1:{
            Ebook *b = obje;
            [_nome setText:b.nomeb];
            [_tipo setText:@"Book"];
            [_artista setText:b.artistab];
            [_genero setText:b.generob];
            [_pais setText:b.paisb];
            [_preco setText:[NSString stringWithFormat: @"US$ %@", b.precob]];
            [_imgUrl setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:b.imgUrlb]]]];
        }
            break;
        case 2:{
            Podcast *p = obje;
            [_nome setText:p.nomep];
            [_tipo setText:@"Podcast"];
            [_artista setText:p.artistap];
            [_genero setText:p.generop];
            [_preco setText:[NSString stringWithFormat: @"US$ %@", p.precop]];
            [_pais setText:p.paisp];
            [_imgUrl setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:p.imgUrlp]]]];
        }
            break;
        case 3:{
            Musica *m = obje;
            [_nome setText:m.nomem];
            [_artista setText:m.artistam];
            [_tipo setText:@"Music"];
            [_genero setText:m.generom];
            [_preco setText:[NSString stringWithFormat: @"US$ %@", m.precom]];
            [_pais setText:m.paism];
            [_imgUrl setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:m.imgUrlm]]]];
        }
            break;
        default:
            break;
            

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
}
@end
