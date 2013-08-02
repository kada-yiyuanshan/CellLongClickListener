//
//  ViewController.m
//  CellLongPress
//
//  Created by hcui on 13-8-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize table_View;
@synthesize array;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.array=[[NSMutableArray alloc] init];
    [self.array addObject:@"a"];
    [self.array addObject:@"b"];
    [self.array addObject:@"c"];
    [self.array addObject:@"e"];
    [self.array addObject:@"f"];
    [self.array addObject:@"g"];
    [self.array addObject:@"h"];
    [self.array addObject:@"i"];
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1.0; //按的时间
    lpgr.delegate = self;
    [self.table_View addGestureRecognizer:lpgr];
}
- (void) showMessageWithTitle: (NSString *) title message: (NSString *) message
{
    UIAlertView *messageView = [[UIAlertView alloc] initWithTitle: title
                                                           message: message
                                                          delegate: nil
                                                 cancelButtonTitle: NSLocalizedString(@"OK", @"")
                                                 otherButtonTitles: nil];
    [messageView show];
    
}
-(IBAction)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint p = [gestureRecognizer locationInView:self.table_View];
        
        NSIndexPath *indexPath = [self.table_View indexPathForRowAtPoint:p];
        if (indexPath == nil) {
        } else {
            UITableViewCell *cell = [self.table_View cellForRowAtIndexPath:indexPath];
            if (cell.isHighlighted) {
                [self showToastView];
            }
        }
    }
}
-(void)showToastView
{
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(0, yOffset, xWidth, yHeight)];
    poplistview.delegate = self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled =YES;
    [poplistview setTitle:@"Share to"];
    [poplistview show];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *TableSampleIdentifier=@"TableSampleIdentifier";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
    
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:TableSampleIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma toastview
#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];

    cell.textLabel.text=[self.array objectAtIndex:[indexPath row]];
    return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}
- (NSInteger)numberOfSectionsInListView:(UIPopoverListView *)popoverListView
{
    return 1;
}
#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@ : %d",[self.array objectAtIndex:[indexPath row]], indexPath.row);
    // your code here
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}


@end
