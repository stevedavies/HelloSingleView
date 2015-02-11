//
//  ViewController.m
//  HelloSingleView
//
//  Created by Steve Davies on 1/21/15.
//  Copyright (c) 2015 steve davies. All rights reserved.
//

#import "ViewController.h"
#import "MediaPlayer/MPMediaItem.h"
#import "MediaPlayer/MPMediaQuery.h"
#import "Mediaplayer/MPMediaPlaylist.h"
#import "MediaPlayer/MPMusicPlayerController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int itemsCount=0;
    int partiallyPlayedCount=0;
    
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    
    NSMutableArray *PlaylistItems= [[NSMutableArray alloc] init];
    //NSLog(@"Logging items from a generic query...");
    NSArray *itemsFromGenericQuery = [everything items];
    for (MPMediaItem *item in itemsFromGenericQuery) {

        NSString *itemTitle = [item valueForProperty: MPMediaItemPropertyTitle];
        NSString *itemBookmarkTime = [item valueForProperty:MPMediaItemPropertyBookmarkTime];
        double BookmarkValue = [itemBookmarkTime doubleValue];
        if (BookmarkValue>0)
        {
            //NSLog(@"Found Partially Played !! %@-%f",itemTitle,BookmarkValue);
            //partiallyPlayedCount++;
        };
        NSString *itemPlaybackDuration = [item valueForProperty:MPMediaItemPropertyPlaybackDuration];
        NSString *itemPlayCount = [item valueForProperty:MPMediaItemPropertyPlayCount];
        NSString *itemType = [item valueForProperty:MPMediaItemPropertyMediaType];
        NSString *itemAlbumTitle = [item valueForProperty:MPMediaItemPropertyAlbumTitle];
            int TypeValue = [[item valueForProperty:MPMediaItemPropertyMediaType] intValue];
        if(TypeValue == 2 & BookmarkValue>0) {
            //NSLog (@"\nType:%@ Title:%@-%@ Bookmark:%@ Duration:%@ PlayCount:%@",itemType, itemAlbumTitle, itemTitle, itemBookmarkTime,itemPlaybackDuration,itemPlayCount);
            //printf("\nType:%s Title:%s-%s Bookmark:%s Duration:%s PlayCount:%s",itemType, itemAlbumTitle, itemTitle, itemBookmarkTime,itemPlaybackDuration,itemPlayCount);
            printf("%s", [[NSString stringWithFormat:@"\nType:%@ Title:%@-%@ Bookmark:%@ Duration:%@ PlayCount:%@",itemType, itemAlbumTitle, itemTitle, itemBookmarkTime,itemPlaybackDuration,itemPlayCount] UTF8String]);
            // ADD itme to MutableArray here
            [PlaylistItems addObject:item];
            partiallyPlayedCount++;
        };
        
        //[PartiallyPlayedList MPMediaPlaylistPropertyName:@"Test"];
        itemsCount++;


        }

    // create a playlist here
    //PartiallyPlayedList
    MPMediaPlaylist *PartiallyPlayedList=[[MPMediaPlaylist alloc] initWithItems:PlaylistItems];

    NSLog(@"Number of items: %d",itemsCount);
    NSLog(@"Partially Palyed: %d", partiallyPlayedCount);
    
    // trying to save a playlist
    
    //NSArray* items = [MPMediaItemCollection items];
    
    NSMutableArray* listToSave = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (MPMediaItem *song in PlaylistItems) {
        
        NSNumber *persistentId = [song valueForProperty:MPMediaItemPropertyPersistentID];
        
        [listToSave addObject:persistentId];
        
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject: listToSave];
    
    //[[NSUserDefaults standardUserDefaults] setObject:data forKey:@"songsList"];
    
    //[[NSUserDefaults standardUserDefaults] synchronize];
    MPMusicPlayerController *myPlayer = [MPMusicPlayerController applicationMusicPlayer];
    [myPlayer setQueueWithItemCollection:PartiallyPlayedList];
    [myPlayer setShuffleMode: MPMusicShuffleModeSongs];
    [myPlayer play];
    [myPlayer stop];
    // trying to save a playlist
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
