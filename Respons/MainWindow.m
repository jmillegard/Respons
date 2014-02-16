//
//  MainWindow.m
//  Respons
//
//  Created by Johannes Fag on 2014-02-16.
//  Copyright (c) 2014 maadi. All rights reserved.
//

#import "MainWindow.h"

@implementation MainWindow

@synthesize initialLocation = _initialLocation;


- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:flag];
    
    if ( self )
    {
        [self setStyleMask:NSBorderlessWindowMask];
        [self setOpaque:NO];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setMovableByWindowBackground:YES];
        [self setMovable:YES];
    }
    
    return self;
}



- (void) setContentView:(NSView *)aView
{
    aView.wantsLayer            = YES;
    aView.layer.frame           = aView.frame;
    aView.layer.cornerRadius    = 30.0;
    aView.layer.masksToBounds   = YES;
    
    
    [super setContentView:aView];
    
}

- (BOOL) canBecomeKeyWindow
{
    return YES;
}

- (BOOL) acceptsFirstResponder
{
    return YES;
}

- (NSTimeInterval)animationResizeTime:(NSRect)newWindowFrame
{
    return 0.1;
}

- (void)sendEvent:(NSEvent *)theEvent
{
    if([theEvent type] == NSKeyDown)
    {
        if([theEvent keyCode] == 36)
            return;
    }
    
    if([theEvent type] == NSLeftMouseDown)
        [self mouseDown:theEvent];
    else if([theEvent type] == NSLeftMouseDragged)
        [self mouseDragged:theEvent];
    
    [super sendEvent:theEvent];
}


- (void)mouseDown:(NSEvent *)theEvent
{    
    self.initialLocation = [theEvent locationInWindow];
}

@end
