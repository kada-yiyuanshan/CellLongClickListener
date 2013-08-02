//
//  ViewController.h
//  CellLongPress
//
//  Created by hcui on 13-8-2.
//  Copyright (c) 2013年 kada. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPopoverListView.h"

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIPopoverListViewDataSource, UIPopoverListViewDelegate>
{
    UITableView *table_View;
    NSMutableArray *array;
}
@property(retain,nonatomic) IBOutlet UITableView *table_View;
@property(retain,nonatomic) NSMutableArray *array;
@end
