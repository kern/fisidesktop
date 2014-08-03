#import "FISIAppDelegate.h"

@implementation FISIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    const int pollSeconds = 5 * 60;
    
    self.requester = [[FISIImageRequester alloc] init];
    [self.requester refresh];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:pollSeconds
                                             target:self.requester
                                           selector:@selector(refresh)
                                           userInfo:nil
                                            repeats:YES];
    
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)awakeFromNib {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [self.statusItem setMenu:self.menu];
    [self.statusItem setImage:[NSImage imageNamed:@"fisi"]];
    [self.statusItem setHighlightMode:YES];
}

- (IBAction)refreshClicked:(id)sender {
    [self.requester refresh];
}

@end