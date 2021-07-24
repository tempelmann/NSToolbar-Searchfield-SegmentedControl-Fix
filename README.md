# NSToolbar-Searchfield-SegmentedControl-Fix

Note: This is related to: https://stackoverflow.com/a/68273182/43615

This project offers a solution to two problems, both related to Toolbar changes in macOS 11 (Big Sur):

1. Problem: Using the new `NSSearchToolbarItem` requires the use of Xcode 12.5.1 or later. This solution provides a way to build apps with older Xcode version (tested with Xcode 10.1 on High Sierra).
2. Problem: Segmented Controls do not adjust their widths when used as Toolbar Items in macOS High Sierra (10.13) and earlier. This comes from the fact that they have different widths pre/post Big Sur.

The first problem is solved in "SmartSearchToolbarItem.m": By using the classic search field  by default, this proxy class replaces it with an instance of `NSSearchToolbarItem` when running on macOS 11 or later.

The second problem is solved by the function `fixSegmentedToolbarItemWidths`.

Feel free to use this code as you need, without restrictions.

If you know of issues and/or solutions, please contact me or offer a pull request. If you have a Swift version, please add that, too (do not replace the ObjC code, but rather add a separate target).

## Version history

- Original version: 10 June 21
- Updated on 24 July 21: Doesn't needlessly fix segmented control widths in 10.14 and 10.15 any more, which did also make them 2 pixels wider than they should be.
