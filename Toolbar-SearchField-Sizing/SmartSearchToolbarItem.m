//
//  SmartSearchToolbarItem.m
//  Toolbar-SearchField-Sizing v5
//
//	See https://stackoverflow.com/a/68273182/43615
//
//  Created by Thomas Tempelmann on 06.07.21.
//

#import "SmartSearchToolbarItem.h"

#if __MAC_OS_X_VERSION_MAX_ALLOWED < 101600
@interface NSSearchToolbarItem : NSObject
- (instancetype)initWithItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier;
@end
#endif

@implementation SmartSearchToolbarItem

-(instancetype)initWithItemIdentifier:(NSToolbarItemIdentifier)itemIdentifier
{
	self = [super initWithItemIdentifier:itemIdentifier];	// this is necessary even if we won't use it, or we'll crash in Big Sur
	Class cls = NSClassFromString(@"NSSearchToolbarItem");
	if (cls) {
		self = (id) [[cls alloc] initWithItemIdentifier:itemIdentifier];
	}
	return self;
}

@end
