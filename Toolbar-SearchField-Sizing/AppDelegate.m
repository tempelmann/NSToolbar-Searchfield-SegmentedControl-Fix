//
//  AppDelegate.m
//  Toolbar-SearchField-Sizing
//
//  Created by Thomas Tempelmann on 10.06.21.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)awakeFromNib {
	[NSUserDefaults.standardUserDefaults setBool:NO forKey:@"NSWindowSupportsAutomaticInlineTitle"];
}

@end
