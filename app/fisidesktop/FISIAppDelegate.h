#import <Cocoa/Cocoa.h>
#import "FISIImageRequester.h"

@interface FISIAppDelegate : NSObject <NSApplicationDelegate>

@property (weak, nonatomic) IBOutlet NSMenu *menu;
@property (strong, nonatomic) NSStatusItem *statusItem;
@property (strong, nonatomic) FISIImageRequester *requester;

- (IBAction)refreshClicked:(id)sender;

@end