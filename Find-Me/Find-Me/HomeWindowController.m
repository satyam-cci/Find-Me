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


#define kLan @"en0"
#define kWifi @"en1"

@interface HomeWindowController ()
@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic,strong) BookWindowController *bookWindowController;
@property (strong) IBOutlet NSTextField *deviceID;
@property (strong) IBOutlet NSTextField *deviceName;
@property (strong) IBOutlet NSTextField *empName;
@property (strong) IBOutlet NSButton *logOutBtn;

@property (strong) IBOutlet NSView *customView;
@property (strong) NSString *mac_id;

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
	
	self.mac_id = [common getMacAddress:kLan];
	NSLog(@"Mac adresss %@",self.mac_id);
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

# pragma mark - process webservice get
- (void) getDeviceList
{
	NSURL *url = [[NSURL alloc] initWithString:@"http://findme.hackaton.ccigoa/findMe.php?funcName=getDeviceList"];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void) processJson:(NSArray *)resultArray
{

	[self.arrayController removeObjects:self.objects];
		[self.objects removeAllObjects];
	
	for(NSDictionary *dict in resultArray)
	{
		Detail *detail = [[Detail alloc] init];
        
		detail.deviceID = [dict objectForKey:kKeyListDeviceId];
		detail.deviceName = [dict objectForKey:kKeyListDeviceName];
		detail.bookedEmpName = [dict objectForKey:kKeyListBookedEmployeeName];
        detail.emp_name = [dict objectForKey:kKeyListEmployeeName];
		detail.status = @"AVAILABLE";
		
//		if([detail.emp_name isEqualToString:@""])
//		{
//			detail.status = @"AVAILABLE";
//		}
//		else
		
		if(![detail.emp_name isEqualToString:@""])
		{
			detail.status = @"BEING USED";
		}
		else if(![detail.bookedEmpName isEqualToString:@""])
		{
			detail.status = @"BOOKED";
		}

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

# pragma mark - process webservice Logout
-(void) sendDeviceDetails
{
    NSString * stringWithURL = [NSString stringWithFormat:@"http://findme.hackaton.ccigoa/findMe.php?funcName=logoutDeviceUser&device_id="];
    stringWithURL = [stringWithURL stringByAppendingString:self.deviceID.stringValue];
    
    NSURL *url = [[NSURL alloc] initWithString:stringWithURL];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


# pragma mark - Button Clicks
- (IBAction)refreshClick:(NSButton *)sender
{
    [self.customView setHidden:YES];    
    [self getDeviceList];

}

- (IBAction)bookClick:(NSButton *)sender
{
    [self.bookWindowController editfromWindow:self];
}

- (IBAction)logoutClick:(NSButton *)sender
{
    [self sendDeviceDetails];
}


@end
