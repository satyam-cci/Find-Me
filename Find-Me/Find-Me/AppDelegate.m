//
//  AppDelegate.m
//  Find-Me
//
//  Created by Satyam Raikar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeWindowController.h"

@interface AppDelegate ()
@property (nonatomic,strong) HomeWindowController *homeWindowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.homeWindowController = [[HomeWindowController alloc] initWithWindowNibName:@"HomeWindowController"];
    [self.homeWindowController showWindow:self];
}

@end
