//
//  myViewController.h
//  STegdeINC
//
//  Created by Lion User on 3/25/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "configurationViewController.h"
#import "groupsCell.h"

@interface myViewController : UIViewController

- (IBAction)configurationPressed:(id)sender;
@property (strong,nonatomic) NSMutableArray *groups;


@end
