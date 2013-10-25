//
//  HomeWindowController.h
//  Find-Me
//
//  Created by Ankita Kalangutkar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JSON.h"
#import "BonsokViewController.h"


 

@interface HomeWindowController : NSWindowController <NSURLConnectionDelegate, NSURLConnectionDataDelegate>
@property (strong) IBOutlet NSTableView *tableView;
@property (strong) IBOutlet NSArrayController *arrayController;
@property (strong) IBOutlet NSTextField *responseLabel;
@end
