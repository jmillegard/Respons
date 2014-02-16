//
//  AppDelegate.m
//  Respons
//
//  Created by Johannes Fag on 2014-02-16.
//  Copyright (c) 2014 maadi. All rights reserved.
//

#import "AppDelegate.h"
#import <Quartz/Quartz.h>
#import <AppKit/AppKit.h>

#import "SCEvents.h"
#import "SCEvent.h"

static NSString *SCEventsDownloadsDirectory = @"Downloads";

@implementation AppDelegate {
    FSEventStreamRef stream;
}

@synthesize webView = _webView;
@synthesize urlButton = _urlButton;
@synthesize urlField  = _urlField;
@synthesize textView = _textView;



- (void)awakeFromNib{
    [self.webView setPattern:[NSImage imageNamed:@"pattern3"]];
    [self.webView setApplicationNameForUserAgent: @"Safari"];
    [self.webView setWantsLayer:YES];
    self.webView.layer.masksToBounds   = YES;
    self.webView.layer.borderWidth = .5f;
    self.webView.layer.borderColor = [NSColor blackColor].CGColor;

    
    [self.settingView.layer setCornerRadius:5.0];
    
    NSImageView * view = [[NSImageView alloc] initWithFrame:CGRectMake(90, 90, 3000, 3000)];
    
    NSImage * img = [NSImage imageNamed:@"bg"];
    
    [self.urlButton setTarget:self];
    [self.urlButton setAction:@selector(updateURL)];

    if(img)
    {
        [view setImage:img];
    }
    
    //[[self.window contentView] addSubview:view];
    
    [[self.webView preferences] setDefaultFontSize: 16];
    
    [self.webView setMainFrameURL:@"http://www.mwi.se"];

    [self.webView setPostsBoundsChangedNotifications:YES];
    
    [self.webView setPostsFrameChangedNotifications:YES];
    
    [self.webView scrollToEndOfDocument:nil];
    
    
    
    // a register for those notifications on the content view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(boundDidChange:)
                                                 name:NSViewFrameDidChangeNotification
                                               object:self.webView];
    
    NSImage * aImage = [NSImage imageNamed:@"iphonesvart"];
    
    if(aImage)
    {
        [self.myImageView setImage:aImage];
    }
    
    [self.white setTarget:self];
    [self.white setAction:@selector(changeToWhite)];
    
    [self.radioBlack setTarget:self];
    [self.radioBlack setAction:@selector(changeToBlack)];
    
   
    
    
}

- (void)boundDidChange:(NSNotification *)notification {
    // get the changed content view from the notification
    //NSClipView *changedContentView=[notification object];
    
    NSLog(@"bound did change");
}

- (IBAction)closeButton:(id)sender {
    NSLog(@"close button");
}

- (NSString *) getHeader: (NSString *) url {
    
    NSString * metahead = @"";
    
    NSURL *theURL = [NSURL URLWithString:url];
    
    NSString * html = @"";
    
    NSError* error = nil;
    NSString* text = [NSString stringWithContentsOfURL:theURL encoding:NSASCIIStringEncoding error:&error];
    if( text )
    {
        html = text;
    }
    else
    {
        NSLog(@"Error = %@", error);
    }
    
    
    NSError *error2 = nil;

    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error2];
    
    if (error) {
        NSLog(@"Error: %@", error);
    }
    
    HTMLNode *bodyNode = [parser head];
    
    NSArray *inputNodes = [bodyNode findChildTags:@"meta"];
    
    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"name"] isEqualToString:@"viewport"]) {
            NSLog(@"%@", [inputNode getAttributeNamed:@"content"]); //Answer to first question
            
            metahead = [inputNode getAttributeNamed:@"content"];
        }
    }
    
    return text;
    
    
}

- (IBAction)toggleJavascript:(id)sender {
    NSLog(@"relax");
    
    NSString * size = [self.webView stringByEvaluatingJavaScriptFromString:@"document.body;"];
    
    NSLog(@"storlek %@", size);
    

}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    NSLog(@"Did finish load");
}

- (IBAction)updateLocalPath:(id)sender {
    
    NSString * path = [self.localPathField stringValue];
    [self setupEventListener: path];
}

- (void) updateURL {
    
    NSLog(@"button clicked");
    NSString * url = [self.urlField stringValue];
    [self.webView setApplicationNameForUserAgent: @"Safari"];
    [self.webView setMainFrameURL:url];
    
    
    
    NSString * meta = [self getHeader:url];
    
    [self.textView setString:meta];
    
    
    
}

- (void) changeToWhite {
    NSImage * aImage = [NSImage imageNamed:@"iphonevit"];
    
    if(aImage)
    {
        [self.myImageView setImage:aImage];
    }
}

- (void) changeToBlack {
    NSImage * aImage = [NSImage imageNamed:@"iphonesvart"];
    
    if(aImage)
    {
        [self.myImageView setImage:aImage];
    }
}

/**
 * Sets up the event listener using SCEvents and sets its delegate to this controller.
 * The event stream is started by calling startWatchingPaths: while passing the paths
 * to be watched.
 */
- (void)setupEventListener: (NSString *) path
{
	if (_events) return;
	
    _events = [[SCEvents alloc] init];
    
    [_events setDelegate:self];
    

    NSMutableArray *paths = [NSMutableArray array];
    NSMutableArray *excludePaths = [NSMutableArray array];
    
    [paths addObject:NSHomeDirectory()];
    [excludePaths addObject:[NSHomeDirectory() stringByAppendingString:path]];
    
    
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    [runloop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    [_events startWatchingPaths:excludePaths onRunLoop:runloop];
    
	// Display a description of the stream
	NSLog(@"%@", [_events streamDescription]);
}

/**
 * This is the only method to be implemented to conform to the SCEventListenerProtocol.
 * As this is only an example the event received is simply printed to the console.
 *
 * @param pathwatcher The SCEvents instance that received the event
 * @param event       The actual event
 */
- (void)pathWatcher:(SCEvents *)pathWatcher eventOccurred:(SCEvent *)event
{
    NSLog(@"%@", event);
    
    [self.webView reload:nil];
}



@end
