//
//  HomeWindowController.m
//  Find-Me
//
//  Created by Ankita Kalangutkar on 25/10/13.
//  Copyright (c) 2013 CCI. All rights reserved.
//

#import "HomeWindowController.h"
#import "BookWindowController.h"
#import "Detail.h"
#import "Common.h"

#define kKeyListDeviceId			@"device_id"
#define kKeyListDeviceName			@"device_name"
#define kKeyListEmployeeName		@"emp_name"
#define kKeyListBookedEmployeeName	@"booked_emp_name"

@interface HomeWindowController ()
@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic,strong) BookWindowController *bookWindowController;
@property (strong) IBOutlet NSTextField *deviceID;
@property (strong) IBOutlet NSTextField *deviceName;
@property (strong) IBOutlet NSTextField *empName;
@property (strong) IBOutlet NSButton *logOutBtn;

@property (strong) IBOutlet NSView *customView;

- (IBAction)refreshClick:(NSButton *)sender;
- (IBAction)bookClick:(NSButton *)sender;
- (IBAction)logoutClick:(NSButton *)sender;

@end

@implementation HomeWindowController

-(void) awakeFromNib
{
    self.objects = [[NSMutableArray alloc] init];
   // [self getData];
    [self getDeviceList];
    self.bookWindowController = [[BookWindowController alloc] initWithWindowNibName:@"BookWindowController"];
	
	Common *common = [[Common alloc] init];
}


- (void)tableViewSelectionDidChange:(NSNotification *)aNotification
{
    [self.customView setHidden:NO];
    NSInteger selectedRow = [self.tableView selectedRow];
    if (selectedRow >= 0 && self.objects.count > selectedRow) {
        Detail * detail = [[Detail alloc] init];
        detail = [self.objects objectAtIndex:selectedRow];
        [self.deviceID setStringValue:detail.deviceID];
        [self.deviceName setStringValue:detail.deviceName];
        [self.empName setStringValue:detail.emp_name];
		
		
		if([detail.emp_name isEqualToString:@""])
		{
			[self.logOutBtn setHidden:YES];
		}
		else
		{
			[self.logOutBtn setHidden:NO];
		}
    }
}

# pragma mark - process webservice
- (void) getDeviceList
{
	NSURL *url = [[NSURL alloc] initWithString:@"http://findme.hackaton.ccigoa/findMe.php?funcName=getDeviceList"];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) processJson:(NSArray *)resultArray
{
	[self.objects removeAllObjects];
	
	for(NSDictionary *dict in resultArray)
	{
		Detail *detail = [[Detail alloc] init];
        
		detail.deviceID = [dict objectForKey:kKeyListDeviceId];
		detail.deviceName = [dict objectForKey:kKeyListDeviceName];
		detail.bookedEmpName = [dict objectForKey:kKeyListBookedEmployeeName];
        detail.emp_name = [dict objectForKey:kKeyListEmployeeName];

		[self.objects addObject:detail];
		[self.arrayController addObject:detail];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	NSError *error;
	//NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
	[self processJson:result];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{}



# pragma mark - Button Clicks
- (IBAction)refreshClick:(NSButton *)sender
{
    [self.customView setHidden:YES];
}

- (IBAction)bookClick:(NSButton *)sender
{
    [self.bookWindowController editfromWindow:self];
}

- (IBAction)logoutClick:(NSButton *)sender
{
}


@end
