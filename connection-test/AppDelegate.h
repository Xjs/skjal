//
//  AppDelegate.h
//  ConnectionTest
//
//  Created by Matt Long on 11/24/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Connection/Connection.h>

@protocol AbstractConnectionProtocol;

@interface AppDelegate : NSObject {
	IBOutlet NSTextField *hostNameField;
	IBOutlet NSTextField *usernameField;
	IBOutlet NSTextField *passwordField;
	IBOutlet NSTextField *baseDirField;
	IBOutlet NSTextView *log;
	IBOutlet NSTextField *status;
	
	CKAbstractConnection <CKConnection> *con;
	
	BOOL isConnected;
}

- (IBAction) connect:(id)sender;
- (IBAction) disConnect:(id)sender;

- (void)connection:(CKAbstractConnection *)aConn didConnectToHost:(NSString *)host error:(NSError *)error;
- (void)connection:(CKAbstractConnection *)aConn didDisconnectFromHost:(NSString *)host;
- (void)connection:(CKAbstractConnection *)aConn didReceiveContents:(NSArray *)contents ofDirectory:(NSString *)dirPath error:(NSError *)error;

@end
