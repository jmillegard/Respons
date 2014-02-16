//
//  MainWindow.h
//  Respons
//
//  Created by Johannes Fag on 2014-02-16.
//  Copyright (c) 2014 maadi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MainWindow : NSWindow {
    NSPoint initialLocation;
}


@property (assign) NSPoint initialLocation;

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag;


@end
