//
//  BookWindowController.h
//  Find-Me
//
//  Created by Ankita Kalangutkar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HomeWindowController.h"

@interface BookWindowController : NSWindowController
@property (strong) IBOutlet NSDatePicker *datePickerField;

-(void) editfromWindow: (HomeWindowController *) sender;
- (IBAction)okClick:(NSButton *)sender;
@end
