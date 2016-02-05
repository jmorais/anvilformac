//
//  NVTableCellView.m
//  Anvil
//
//  Created by Elliott Kember on 16/09/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import "NVTableCellView.h"
#import "BFImage.h"
#import "NSButton+NSButton_Extensions.h"
#import "NSImage+Additions.h"

@interface NVTableCellView ()

@property BOOL mouseIsDown;

@end

@implementation NVTableCellView

- (void)awakeFromNib {

    // Initialization code here.
    self.backgroundStyle = NSBackgroundStyleLowered;
    
    if (self.isHammer) {
        
        [self.localLabel setText:@".dev.hammer"];
    }
        
    self.deleteButton.stringValue = @"";
    self.restartButton.stringValue = @"";
    
    
    self.restartButton.image = [NSImage imageNamed:@"restart"];
    self.deleteButton.image = [NSImage imageNamed:@"delete"];
    self.deleteButton.hoverImage = [NSImage imageNamed:@"deleteHover"];
    self.deleteButton.alternateImage = [NSImage imageNamed:@"deletePushed"];
    
    // TODO: Hover button. OMG.
    self.restartButton.alternateImage = [NSImage imageNamed:@"restartPushed"];
    self.restartButton.hoverImage = [NSImage imageNamed:@"restartHover"];
    self.restartButton.alternateImage = [NSImage imageNamed:@"restartPushed"];
    
    [self.restartButton setHidden:YES];
    [self.deleteButton setHidden:YES];
        
    [self.siteLabel setWidth];
    self.localLabel.frame = CGRectMake(self.siteLabel.frame.origin.x + self.siteLabel.frame.size.width -5,
                                       self.siteLabel.frame.origin.y,
                                       self.siteLabel.frame.size.width,
                                       self.siteLabel.frame.size.height);
    
    [self.restartButton setWantsLayer:YES];
    [self.deleteButton setWantsLayer:YES];
    [self.deleteButton setTransparent:NO];
    
    [self.siteLabel setEditable:YES];
    [self setupReallyDeleteButton];
}

- (void)setIsHammer:(BOOL)isHammer {
    
    _isHammer = isHammer;
    if (self.isHammer) {
        
        [self.localLabel setText:@".hammer.dev"];
    } else {
        
        [self.localLabel setText:@".dev"];
    }
}

- (void)setupReallyDeleteButton {
    
    if (!self.reallyDeleteButton.image) {
        NSImage *reallyDeleteButtonImage = [BFImage imageFrom:[NSImage imageNamed:@"deleteButton"] withDimensions:self.reallyDeleteButton.frame.size andInsets:BFEdgeInsetsMake(1.0, 10.0, 1.0, 10.0)];
        NSImage *reallyDeleteButtonAlternateImage = [BFImage imageFrom:[NSImage imageNamed:@"deleteButtonPushed"] withDimensions:self.reallyDeleteButton.frame.size andInsets:BFEdgeInsetsMake(1.0, 10.0, 1.0, 10.0)];
        
        [self.reallyDeleteButton.cell setImageScaling:NSImageScaleAxesIndependently];
        
        self.reallyDeleteButton.image = reallyDeleteButtonImage;
        self.reallyDeleteButton.alternateImage = reallyDeleteButtonAlternateImage;

        [self.reallyDeleteButton setTitle:@"Delete"];
        [self.reallyDeleteButton setAlternateTitle:@"Delete"];
        
        self.reallyDeleteButton.textOffset = 0.0;
    }
}

- (IBAction)didClickDeleteButton:(id)sender {
    
    NSInteger count = [[NSApp currentEvent] clickCount];
    
    // Double clicks. Pass the message through.
    if (count == 1) {
        [self showReallyDeleteButton];
    } else if (count == 2) {
        [self.reallyDeleteButton performClick:sender];
    }
}

- (void)showReallyDeleteButton {

    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.1];
    [[self.reallyDeleteButton animator] setHidden:NO];
    [NSAnimationContext endGrouping];
}

- (void)hideReallyDeleteButton {

    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.05];
    [self.reallyDeleteButton setHidden:YES];
    [NSAnimationContext endGrouping];
}

- (void)resizeSubviewsWithOldSize:(NSSize)oldSize {
    
    [self hideReallyDeleteButton];
    
    [self.siteLabel setWidth];
    self.localLabel.frame = CGRectMake(self.siteLabel.frame.origin.x + self.siteLabel.frame.size.width - 5,
                                       self.siteLabel.frame.origin.y,
                                       self.siteLabel.frame.size.width,
                                       self.siteLabel.frame.size.height);
    
    [self.localLabel sizeToFit];
    [self.siteLabel setEditable:YES];
    
    CGRect dirtyRect = self.frame;
    
    NSRect deleteButtonFrame = self.deleteButton.frame;
    
    int spaceBetweenDeleteButtonAndRight = 12;
    int spaceBetweenButtons = 5;
    
    self.deleteButton.frame = CGRectMake(dirtyRect.size.width - spaceBetweenDeleteButtonAndRight - deleteButtonFrame.size.width,
                                         deleteButtonFrame.origin.y,
                                         deleteButtonFrame.size.width,
                                         deleteButtonFrame.size.height);
    
    NSRect restartButtonFrame = self.restartButton.frame;
    self.restartButton.frame = CGRectMake(self.deleteButton.frame.origin.x - spaceBetweenButtons - restartButtonFrame.size.width,
                                          restartButtonFrame.origin.y,
                                          restartButtonFrame.size.width,
                                          restartButtonFrame.size.height);
    
    NSRect reallyDeleteButtonFrame = self.reallyDeleteButton.frame;
    self.reallyDeleteButton.frame = CGRectMake(dirtyRect.size.width - spaceBetweenDeleteButtonAndRight - reallyDeleteButtonFrame.size.width,
                                         reallyDeleteButtonFrame.origin.y,
                                         reallyDeleteButtonFrame.size.width,
                                         reallyDeleteButtonFrame.size.height);

}

- (void)showControls {
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.1];
    [self.reallyDeleteButton setHidden:YES];
    if (self.showRestartButton) { // && ![self.restartButton isSpinning]) {
        [[self.restartButton animator] setHidden:NO];
    }
    
    if (!self.isHammer) {
        [[self.deleteButton animator] setHidden:NO];
    }
    [NSAnimationContext endGrouping];
}

- (void)hideControlsImmediately {
    
    [self.reallyDeleteButton setHidden:YES];
    [self.restartButton setHidden:YES];
    [self.deleteButton setHidden:YES];
}

- (void)hideControls {
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:0.05];
    [self.reallyDeleteButton setHidden:YES];
    [[self.restartButton animator] setHidden:YES];
    [[self.deleteButton animator] setHidden:YES];
    [NSAnimationContext endGrouping];
}

- (void)mouseEntered:(NSEvent *)theEvent {
    
    self.isHovered = YES;
    [self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)theEvent {
    
    self.isHovered = NO;
    [self setNeedsDisplay:YES];
}

- (void)mouseDown:(NSEvent *)theEvent {
    
    self.mouseIsDown = YES;
    [self setNeedsDisplay:YES];
    [super mouseDown:theEvent];
    self.mouseIsDown = NO;
    self.isHovered = NO;
}

- (void)mouseUp:(NSEvent *)theEvent {
    
    self.mouseIsDown = NO;
    [self setNeedsDisplay:YES];
    [super mouseUp:theEvent];
    self.mouseIsDown = NO;
}

- (void)drawRect:(NSRect)dirtyRect {
    
    self.localLabel.frame = CGRectMake(self.siteLabel.frame.origin.x + self.siteLabel.frame.size.width -5,
                                       self.siteLabel.frame.origin.y,
                                       self.siteLabel.frame.size.width,
                                       self.siteLabel.frame.size.height);

    [self.localLabel sizeToFit];
    [super drawRect:dirtyRect];

    NSRect bottomLineRectangle = [self frame];
    bottomLineRectangle.origin.y = 0;
    bottomLineRectangle.size.height = 1;
    
    NSRect topLineRectangle = [self frame];
    topLineRectangle.origin.y = topLineRectangle.size.height - 1.0;
    topLineRectangle.size.height = 1.0;
    
    if (self.mouseIsDown) {
    
        NSImage *image = [[NSImage imageNamed:@"RowBackgroundPushed.png"] stretchableImageWithEdgeInsets:BFEdgeInsetsMake(3.0, 1.0, 3.0, 1.0)];
        [image drawInRect:self.bounds fromRect:NSZeroRect operation:NSCompositeSourceOut fraction:1.0 respectFlipped:YES hints:nil];
        
        [[NSColor colorWithDeviceRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0] set];
        NSRectFill (bottomLineRectangle);
        
    } else {

        if (self.isHovered) {
            // White background.
            [[NSColor whiteColor] set];
            NSRectFill(self.bounds);
            
            if (self.darkTopBorder) {
                [[NSColor colorWithDeviceRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0] set];
                if (!self.hideTopBorder) {
                    NSRectFill(topLineRectangle);
                }
            }
        } else {
            
            if (self.darkTopBorder) {
                [[NSColor colorWithDeviceRed:236.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1.0] set];
            } else {
                [[NSColor colorWithDeviceRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.4] set];
            }
            
            if (!self.hideTopBorder) {
                NSRectFill(topLineRectangle);
            }
        }

        if (self.mouseIsDown) {
            [[NSColor colorWithDeviceRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0] set];
        } else {
            [[NSColor colorWithDeviceRed:225.0/255.0 green:225.0/255.0 blue:225.0/255.0 alpha:1.0] set];
        }
        
        if (!self.hideBottomBorder) {
            NSRectFill (bottomLineRectangle);
        }
    }

}

- (void)spinRestartButton {
    
    [self.restartButton showSpinnerFor:0.4];
    [self performSelector:@selector(hideControlsIfNotHovered:) withObject:nil afterDelay:0.4];
}

- (void)hideControlsIfNotHovered:(id)sender {
    
    if (!self.isHovered) {
        
        [self hideControls];
    }
}

@end
