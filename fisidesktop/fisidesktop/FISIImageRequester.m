#import "FISIImageRequester.h"

@implementation FISIImageRequester

- (id)init {
    self = [super init];
    
    if (self) {
        NSURL *appSupportDir = [[NSFileManager defaultManager] URLForDirectory:NSApplicationSupportDirectory
                                                                      inDomain:NSUserDomainMask
                                                             appropriateForURL:nil
                                                                        create:YES
                                                                         error:nil];
        _imageDirectory = [appSupportDir URLByAppendingPathComponent:@"FISI"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtURL:_imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];

        _i = 0;
    }
    
    return self;
}

- (void)refresh {
    NSData *imageData = [self requestImage];
    if (imageData) {
        
        NSURL *imageURL = [self generateLocalImageURL];
        [imageData writeToURL:imageURL atomically:YES];
        [self setDesktopImage:imageURL fillColor:[self randomColor]];
        
    }
}

- (NSURL *)generateLocalImageURL {
    const NSUInteger imageCacheSize = 5;
    
    NSString *filename = [NSString stringWithFormat:@"%lu.png", (unsigned long) _i];
    NSURL *result = [_imageDirectory URLByAppendingPathComponent:filename];
    
    _i = (_i + 1) % imageCacheSize;
    
    return result;
}

- (NSColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 32 / 256.0 ) + 0.25;
    return [NSColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (NSData *)requestImage {
    const NSUInteger requestTimeout = 10;
    
//    NSURL *remoteImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:9292/png?%u", arc4random()]];
    NSURL *remoteImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://fisidesktop.herokuapp.com/png?%u", arc4random()]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteImageURL
                                             cachePolicy:NSURLCacheStorageNotAllowed
                                         timeoutInterval:requestTimeout];
    
    NSError *error = nil;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:nil
                                                          error:&error];
    
    if (error) {
        return nil;
    } else {
        return imageData;
    }
}

- (void)setDesktopImage:(NSURL *)url fillColor:(NSColor *)color {
    NSDictionary *options = @{ NSWorkspaceDesktopImageScalingKey: [NSNumber numberWithInt:NSImageScaleNone],
                               NSWorkspaceDesktopImageAllowClippingKey: @NO,
                               NSWorkspaceDesktopImageFillColorKey: color };
    
    [[NSWorkspace sharedWorkspace] setDesktopImageURL:url
                                            forScreen:[NSScreen mainScreen]
                                              options:options
                                                error:nil];
}

@end
