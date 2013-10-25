//
//  BonsokViewController.h
//  Find-Me
//
//  Created by Satyam Raikar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HomeWindowController.h"

@protocol BonsokViewControllerDelegate <NSObject>

-(void)bookedStatus:(NSString *)status;

@end

@interface BonsokViewController : NSViewController <BonsokViewControllerDelegate>
@property (strong) IBOutlet NSDatePicker *datePickerField;
@property (strong) NSString *deviceId;
@property (strong) NSString *macId;

@property (nonatomic,strong) id <BonsokViewControllerDelegate> bonsokViewControllerDelegate;
//-(void) editfromWindow: (HomeWindowController *) sender;
- (IBAction)okClick:(NSButton *)sender;

@end
