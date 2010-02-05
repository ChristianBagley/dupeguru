/* 
Copyright 2010 Hardcoded Software (http://www.hardcoded.net)

This software is licensed under the "HS" License as described in the "LICENSE" file, 
which should be included with this package. The terms are also available at 
http://www.hardcoded.net/licenses/hs_license
*/

#import "DetailsPanel.h"
#import "Utils.h"

@implementation DetailsPanel
- (id)initWithPy:(PyApp *)aPy
{
    self = [super initWithWindowNibName:@"DetailsPanel"];
    [self window]; //So the detailsTable is initialized.
    Class pyClass = [Utils classNamed:@"PyDetailsPanel"];
    py = [[pyClass alloc] initWithCocoa:self pyParent:aPy];
    return self;
}

- (void)dealloc
{
    [py release];
    [super dealloc];
}

- (void)refreshDetails
{
    [detailsTable reloadData];
}

- (void)toggleVisibility
{
    if ([[self window] isVisible]) {
        [[self window] close];
    }
    else {
        [self refreshDetails]; // selection might have changed since last time
        [[self window] orderFront:nil];
    }
}

/* NSTableView Delegate */
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [py numberOfRows];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)column row:(NSInteger)row
{
    return [py valueForColumn:[column identifier] row:row];
}

/* Python --> Cocoa */
- (void)refresh
{
    if ([[self window] isVisible]) {
        [self refreshDetails];
    }
}
@end
