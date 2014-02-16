//
//  SideView.m
//  Respons
//
//  Created by Johannes Fag on 2014-02-16.
//  Copyright (c) 2014 maadi. All rights reserved.
//

#import "SideView.h"

@implementation SideView

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:0.8] set];
    
    NSColor * bg = [NSColor colorWithCalibratedRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    
    [bg setFill];
    
    NSRectFill(dirtyRect);
    
    self.wantsLayer            = YES;
    self.layer.frame           = self.frame;
    self.layer.masksToBounds   = YES;
    self.layer.opacity = 0.97f;

    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [NSColor grayColor].CGColor;
}

@end
