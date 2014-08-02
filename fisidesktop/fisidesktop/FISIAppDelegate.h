#import <Cocoa/Cocoa.h>

@interface FISIAppDelegate : NSObject <NSApplicationDelegate>

@property (weak, nonatomic) IBOutlet NSMenu *menu;
@property (strong, nonatomic) NSStatusItem *statusItem;

@end