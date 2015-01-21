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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int itemsCount=0;
    MPMediaQuery *everything = [[MPMediaQuery alloc] init];
    NSLog(@"Logging items from a generic query...");
    NSArray *itemsFromGenericQuery = [everything items];
    for (MPMediaItem *item in itemsFromGenericQuery) {

            NSString *itemType = [item valueForProperty:MPMediaItemPropertyMediaType];
            int TypeValue = [[item valueForProperty:MPMediaItemPropertyMediaType] intValue];

            NSString *itemTitle = [item valueForProperty: MPMediaItemPropertyTitle];

            NSString *itemBookmarkTime = [item valueForProperty:MPMediaItemPropertyBookmarkTime];

            //NSTimeInterval *Bookmark = item.bookmarkTime;
            NSString *itemPlaybackDuration = [item valueForProperty:MPMediaItemPropertyPlaybackDuration];
            NSString *itemPlayCount = [item valueForProperty:MPMediaItemPropertyPlayCount];
            itemsCount++;
            NSLog (@"\nType:%@ Title:%@ Bookmark:%@ Duration:%@ PlayCount:%@",itemType, itemTitle, itemBookmarkTime
                   ,itemPlaybackDuration,itemPlayCount);
        }
    NSLog(@"Number of items: %d",itemsCount);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
