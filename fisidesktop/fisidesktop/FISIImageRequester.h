#import <AppKit/AppKit.h>

@interface FISIImageRequester : NSObject {
    
    NSURL *_imageDirectory;
    NSUInteger _i;
    
}

- (void)refresh;

@end