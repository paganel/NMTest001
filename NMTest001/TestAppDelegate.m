//
//  NMTest001AppDelegate.m
//  NMTest001
//
//  Created by Nick Moore on 05/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestAppDelegate.h"

@implementation TestAppDelegate

- (IBAction)createNewWindow:(id)sender
{
    TestWindowController *windowController=[[TestWindowController alloc] initWithWindowNibName:@"Window"];
    [windowControllers addObject:windowController];
    [windowController showWindow:self];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    windowControllers=[NSMutableArray array];
    [self createNewWindow:self];
    prev_pid=-1;
    
    
    // Insert code here to initialize your application
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSLeftMouseDownMask|NSLeftMouseUpMask handler:^(NSEvent *event) {
        
        // get the UI Element at the mouse location
		NSPoint point=NSPointFromCGPoint(CGEventGetLocation((CGEventRef)NSMakeCollectable(CGEventCreate(NULL))));
        
        NMUIElement *const element=[NMUIElement elementAtLocation:point];        
        // only handle clicks on windows
        if ([[[element topLevelElement] role] isEqualToString:(NSString *)kAXWindowRole])
        {
            [windowControllers makeObjectsPerformSelector:@selector(handleNewElement:) withObject:element];
        }
    }];

}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{   
    return YES;
}

@end
