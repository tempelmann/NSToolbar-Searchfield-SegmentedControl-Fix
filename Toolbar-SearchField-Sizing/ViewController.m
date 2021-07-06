//
//  ViewController.m
//  Toolbar-SearchField-Sizing
//
//	See https://stackoverflow.com/a/68273182/43615
//
//  Created by Thomas Tempelmann on 10.06.21.
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
	
	// Set up the toolbar
	self.view.window.toolbar = self.toolbar;
	
	// Set up the search field in the toolbar 
	if (@available(macOS 11.0, *)) {
		// no need to set the sizes here, and they lead to ugly warnings
	} else {
		// allow the search field use more of the available space
		self.searchToolbarItem.maxSize = NSMakeSize (250, self.searchToolbarItem.maxSize.height);
	}
	
	// Adjust any segmented controls in the toolbar for pre/post Big Sur width differences
	[self fixSegmentedToolbarItemWidths];
}

#pragma mark - IBActions

- (IBAction)customizeToolbar:(id)sender {
	[self.view.window.toolbar runCustomizationPalette:self];
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
	for (NSToolbarItem *item in self.view.window.toolbar.items) {
		if ([item.view isKindOfClass:NSSegmentedControl.class]) {
			[self sizeTofitToolbarItem:item];
		}
		[self.view.window.toolbar validateVisibleItems];
	}
}

- (void)sizeTofitToolbarItem:(NSToolbarItem*)item
{
	NSControl *control = (NSControl*)item.view;
	[control sizeToFit];
	if (@available(macOS 11.0, *)) {
		// no need to set the sizes here, and they lead to ugly warnings
	} else {
		NSRect frame = control.frame;
		item.minSize = NSMakeSize(frame.size.width+2, item.minSize.height);	// the toolbar item appears to always be 2 px wider than its content
		item.maxSize = item.minSize;
	}
}

@end
