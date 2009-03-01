//
//  AppDelegate.m
//  ConnectionTest
//
//  Created by Matt Long on 11/24/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <Connection/Connection.h>

@implementation AppDelegate

- (IBAction) connect:(id)sender;
{
	NSNumber *port = [NSNumber numberWithInt:21];
	NSError *err = nil;
	con = [[CKAbstractConnection connectionToHost:[hostNameField stringValue]
											port:port
										username:[usernameField stringValue]
										password:[passwordField stringValue]
										error:&err] retain];
	if (!con)
	{
		if (err)
		{
			[NSApp presentError:err];
		}
		return;
	}
	
	NSTextStorage *textStorage = [log textStorage];
	[textStorage setDelegate:self];		// get notified when text changes
	[con setTranscript:textStorage];	
	
	[con setDelegate:self];
	
	[status setStringValue:[NSString stringWithFormat:@"Connecting to: %@", [hostNameField stringValue]]];
	[con connect];
}

- (IBAction) disConnect:(id)sender;
{
	if( con )
	{
		[con disconnect];
	}
	
}
- (void)connection:(CKAbstractConnection *)aConn didConnectToHost:(NSString *)host error:(NSError *)error
{
	isConnected = YES;
	[status setStringValue:[NSString stringWithFormat:@"Connected to: %@", host]];

	NSString *dir = [[baseDirField stringValue] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if (dir && [dir length] > 0)
		[con changeToDirectory:[baseDirField stringValue]];
	[con directoryContents];
}

- (void)connection:(CKAbstractConnection *)aConn didDisconnectFromHost:(NSString *)host
{
	NSLog(@"didDisconnectfromHost");
	isConnected = NO;
	[status setStringValue:[NSString stringWithFormat:@"Disconnected from: %@", host]];

	[con release];
	con = nil;
}

- (void)connection:(CKAbstractConnection *)aConn didReceiveContents:(NSArray *)contents ofDirectory:(NSString *)dirPath moreComing:(BOOL)more
{
}

- (void)connection:(CKAbstractConnection *)aConn didReceiveContents:(NSArray *)contents ofDirectory:(NSString *)dirPath error:(NSError *)error
{
	NSLog(@"%@ %@", NSStringFromSelector(_cmd), dirPath);
	int i = 0;
	for (i=0; i < [contents count]; ++i) {
		id object = [contents objectAtIndex:i];
		[[[log textStorage] mutableString] appendFormat:@"%@\n", object];
	}
}

@end
