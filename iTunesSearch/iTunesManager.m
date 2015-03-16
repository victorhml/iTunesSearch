//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Entidades/Ebook.h"
#import "Entidades/Podcast.h"
#import "Entidades/Musica.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    NSMutableArray *ebooks = [[NSMutableArray alloc] init];
    NSMutableArray *podcasts = [[NSMutableArray alloc] init];
    NSMutableArray *musicas = [[NSMutableArray alloc] init];
    NSString *type;
    for (NSDictionary *item in resultados) {
        type = [item objectForKey:@"kind"];
        
        if ([type isEqualToString:@"feature-movie"]) {
            Filme *filme = [[Filme alloc] init];
            [filme setNome:[item objectForKey:@"trackName"]];
            [filme setTrackId:[item objectForKey:@"trackId"]];
            [filme setArtista:[item objectForKey:@"artistName"]];
            [filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [filme setGenero:[item objectForKey:@"primaryGenreName"]];
            [filme setPais:[item objectForKey:@"country"]];
            [filme setPreco:[item objectForKey:@"trackPrice"]];
            [filme setImgUrl:[item objectForKey:@"artworkUrl60"]];
            [filmes addObject:filme];
        }
        else if ([type isEqualToString:@"ebook"]){
            Ebook *ebook = [[Ebook alloc] init];
            [ebook setNomeb:[item objectForKey:@"trackName"]];
            [ebook setTrackIdb:[item objectForKey:@"trackId"]];
            [ebook setArtistab:[item objectForKey:@"artistName"]];
            [ebook setGenerob:[item objectForKey:@"primaryGenreName"]];
            [ebook setPrecob:[item objectForKey:@"trackPrice"]];
            [ebook setImgUrlb:[item objectForKey:@"artworkUrl60"]];
            [ebook setPaisb:[item objectForKey:@"country"]];
            [ebooks addObject:ebook];
        }
        else if ([type isEqualToString:@"podcast"]){
            Podcast *podcast = [[Podcast alloc] init];
            [podcast setNomep:[item objectForKey:@"trackName"]];
            [podcast setTrackIdp:[item objectForKey:@"trackId"]];
            [podcast setArtistap:[item objectForKey:@"artistName"]];
            [podcast setDuracaop:[item objectForKey:@"trackTimeMillis"]];
            [podcast setGenerop:[item objectForKey:@"primaryGenreName"]];
            [podcast setPaisp:[item objectForKey:@"country"]];
            [podcast setPrecop:[item objectForKey:@"trackPrice"]];
            [podcast setImgUrlp:[item objectForKey:@"artworkUrl60"]];
            [podcasts addObject:podcast];
        }
        else if ([type isEqualToString:@"song"]){
            Musica *musica = [[Musica alloc] init];
            [musica setNomem:[item objectForKey:@"trackName"]];
            [musica setTrackIdm:[item objectForKey:@"trackId"]];
            [musica setArtistam:[item objectForKey:@"artistName"]];
            [musica setDuracaom:[item objectForKey:@"trackTimeMillis"]];
            [musica setGenerom:[item objectForKey:@"primaryGenreName"]];
            [musica setPaism:[item objectForKey:@"country"]];
            [musica setPrecom:[item objectForKey:@"trackPrice"]];
            [musica setImgUrlm:[item objectForKey:@"artworkUrl60"]];
            [musicas addObject:musica];
        }
    }
    NSArray *mid = [[NSArray alloc]initWithObjects: filmes, ebooks, podcasts, musicas, nil];
    return mid;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
