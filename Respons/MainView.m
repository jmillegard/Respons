//
//  MainView.m
//  Respons
//
//  Created by Johannes Fag on 2014-02-16.
//  Copyright (c) 2014 maadi. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithCalibratedRed:0.1 green:0.1 blue:0.1 alpha:0] set];
    NSRectFill(dirtyRect);
}

@end
