#import "NVBackgroundView.h"
#import "NSImage+Additions.h"
#import "BFImage.h"

#define FILL_OPACITY 1.0f
#define STROKE_OPACITY 1.0f

#define LINE_THICKNESS 1.0f
#define CORNER_RADIUS 10.0f

#define SEARCH_INSET 10.0f

#pragma mark -

@implementation NVBackgroundView

@synthesize arrowX = _arrowX;

#pragma mark -

- (id)init {
    
    self = [super init];
    if (self) {
        
        [self setWantsLayer:YES];
        [self.layer setMasksToBounds:YES];
        [self.layer setOpaque:YES];
        [self.layer setCornerRadius:4];
    }
    
    return self;
    
}

- (void)awakeFromNib {
    
    self.backgroundImage = [NSImage imageNamed:@"footer.png"];
    self.titlebarPointImageView.backgroundImage = [NSImage imageNamed:@"TitlebarPoint"];
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    
    [super resizeSubviewsWithOldSize:oldSize];
}

- (void)drawRect:(NSRect)dirtyRect {
    
    NSRect footerRect = NSMakeRect(0, 0, dirtyRect.size.width, 34);
    [self.backgroundImage drawInRect:footerRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
    
    NSRect contentRect = [self bounds];
    contentRect.origin.y = footerRect.size.height;
    contentRect.size.height -= footerRect.size.height;
    contentRect.size.height -= ARROW_HEIGHT;
    contentRect.size.height -= 10;
    [[NSColor colorWithDeviceRed:244.0/255.0 green:244.0/255.0 blue:244.0/255.0 alpha:1.0] set];
    
    NSRectFill(contentRect);
}

- (BOOL)mouseDownCanMoveWindow {
    
    return NO;
}

- (void)setArrowX:(NSInteger)value {
    
    _arrowX = value;
    [self setNeedsDisplay:YES];
}

@end
