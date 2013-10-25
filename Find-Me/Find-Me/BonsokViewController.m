//
//  BonsokViewController.m
//  Find-Me
//
//  Created by Satyam Raikar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import "BonsokViewController.h"
#import "BookResponse.h"
#import "HomeWindowController.h"

@interface BonsokViewController ()
@property (nonatomic,strong) HomeWindowController *homeWindowController;

@end

@implementation BonsokViewController
@synthesize bonsokViewControllerDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) awakeFromNib
{
    [self.datePickerField setDateValue:[NSDate date]];
 	[super awakeFromNib];
}

-(void) editfromWindow: (HomeWindowController *) sender
{
	[self.datePickerField setDateValue:[NSDate date]];
	
  
}

- (IBAction)okClick:(NSButton *)sender
{
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM/dd/yyyy"];
	
	NSString *bookingDate = [formatter stringFromDate: [self.datePickerField dateValue]];
	
	NSString *urlStr = [NSString stringWithFormat:@"http://findme.hackaton.ccigoa/findMe.php?funcName=bookDevice&device_id=%@&mac_id=%@&booking_date=%@",self.deviceId, self.macId, bookingDate];
	NSLog(@"urlStr: %@",urlStr);
	
	NSURL *url = [[NSURL alloc] initWithString:urlStr];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];

	//self.homeWindowController.delegate = self;
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSError *error;
	
	NSString *resposeData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	[self.bonsokViewControllerDelegate bookedStatus:resposeData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{}


@end
