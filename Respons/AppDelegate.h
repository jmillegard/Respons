//
//  AppDelegate.h
//  Respons
//
//  Created by Johannes Fag on 2014-02-16.
//  Copyright (c) 2014 maadi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "LNClipView.h"
#import "HTMLNode.h"
#import "HTMLParser.h"
#import "MainWindow.h"
#import "SideView.h"
#import "SCEventListenerProtocol.h"


@interface AppDelegate : NSObject <NSApplicationDelegate, SCEventListenerProtocol>
{
	SCEvents *_events;
}

- (void)setupEventListener: (NSString *) path;

@property (strong) IBOutlet MainWindow *window;
@property (strong) IBOutlet LNWebView * webView;
@property (assign) IBOutlet NSImageView *myImageView;
@property (assign) IBOutlet SideView *settingView;
@property (assign) IBOutlet NSTextField *urlField;
@property (assign) IBOutlet NSTextField *localPathField;
@property (assign) IBOutlet NSButton * urlButton;
@property (assign) IBOutlet NSButton * localPathButton;
@property (assign) IBOutlet NSButtonCell * radioBlack;
@property (assign) IBOutlet NSButtonCell * white;

@property (assign) IBOutlet NSTextView * textView;

@property (assign) IBOutlet NSButton * closeButton;

- (IBAction)closeButton:(id)sender;

- (IBAction)updateLocalPath:(id)sender;

- (IBAction)toggleJavascript:(id)sender;

@end
