//
//  BookWindowController.m
//  Find-Me
//
//  Created by Ankita Kalangutkar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import "BookWindowController.h"

@interface BookWindowController ()

@end

@implementation BookWindowController

-(void) awakeFromNib
{
    [self.datePickerField setDateValue:[NSDate date]];
}

-(void) editfromWindow: (HomeWindowController *) sender
{
    NSWindow *window = [self window];
    [NSApp beginSheet:window modalForWindow:[sender window] modalDelegate:nil didEndSelector:nil contextInfo:nil];
	[NSApp runModalForWindow:window];
	// sheet is up here...
	[NSApp endSheet:window];
	[window orderOut:self];
}

- (IBAction)okClick:(NSButton *)sender
{
    [NSApp stopModal];
}

@end
