//
//  ViewController.m
//  Toolbar-SearchField-Sizing
//
//	See https://stackoverflow.com/a/68273182/43615
//
//  Created by Thomas Tempelmann on 10 June 21.
//  Update by TT on 24 July 21: Fix for SegmentedControls is only needed on 10.13 and earlier systems
//

#import "ViewController.h"

@interface ViewController () <NSSearchFieldDelegate>
	@property (weak) IBOutlet NSToolbar *toolbar;
	@property (weak) IBOutlet NSSearchField *searchField;
	@property (weak) IBOutlet NSToolbarItem *searchToolbarItem;
@end

@implementation ViewController

- (void)viewWillAppear {
	[super viewWillAppear];
	
	// Set up the toolbar (needed because it's placed in the View's Scene instead of the Window's Scene for convenience)
	self.view.window.toolbar = self.toolbar;
	
	// Set up the search field in the toolbar 
	if (@available(macOS 11.0, *)) {
		// No need to set the max size here, and it would lead to ugly warnings in the log
	} else {
		// Let's allow the search field use more of the available space
		self.searchToolbarItem.maxSize = NSMakeSize (250, self.searchToolbarItem.maxSize.height);
	}
	
	if (@available(macOS 10.14, *)) {
		// No need to fix the segment sizes here, and they'd lead to ugly warnings in macOS 11 and later
	} else {
		// Adjust any segmented controls in the toolbar for pre/post High Sierra width differences
		[self fixSegmentedToolbarItemWidths];
	}
}

#pragma mark - IBActions

- (IBAction)customizeToolbar:(id)sender {	// this is useful for checking whether the fixes also work in the customization sheet
	[self.view.window.toolbar runCustomizationPalette:self];
}

- (IBAction)fixSegmentedControls:(id)sender {	// this allows you to test the fix on 10.14 and later to see its effect
	[self fixSegmentedToolbarItemWidths];
}

#pragma mark - NSSearchField handling

- (IBAction)search:(NSSearchField*)sender {
	NSLog(@"%s: %@", __func__, sender.stringValue);
}

- (void)searchFieldDidStartSearching:(NSSearchField *)sender {
	NSLog(@"%s", __func__);
}

- (void)searchFieldDidEndSearching:(NSSearchField *)sender {
	NSLog(@"%s", __func__);
}

#pragma mark - helper functions

- (void)fixSegmentedToolbarItemWidths // call this from `viewWillAppear`
{
	BOOL didChange = NO;
	for (NSToolbarItem *item in self.view.window.toolbar.items) {
		if ([item.view isKindOfClass:NSSegmentedControl.class]) {
			[self sizeTofitToolbarItem:item];
			didChange = YES;
		}
	}
	if (didChange) {
		[self.view.window.toolbar validateVisibleItems];
	}
}

- (void)sizeTofitToolbarItem:(NSToolbarItem*)item
{
	NSControl *control = (NSControl*)item.view;
	[control sizeToFit];
	NSRect frame = control.frame;
	const int padding = 2; // padding is 2 in 10.13 and is 0 in 10.14 and 10.15 (determined empirically)
	item.minSize = NSMakeSize(frame.size.width+padding, item.minSize.height);
	item.maxSize = item.minSize;
}

@end
