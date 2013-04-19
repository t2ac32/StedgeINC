//
//  myViewController.m
//  STegdeINC
//
//  Created by Lion User on 3/25/13.
//  Copyright (c) 2013 Lion User. All rights reserved.
//

#import "myViewController.h"

@interface myViewController ()

@end

@implementation myViewController
@synthesize groups;
NSMutableDictionary *datos;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    groups = [NSMutableArray new];
    [groups addObject:@"Oficina"];
    [groups addObject:@"Casa"];
    [groups addObject:@"Equipo Futbol"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [groups count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    groupsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
    cell.nameGroupLabel.text = [groups objectAtIndex:indexPath.row];
    [cell.editableImage setImage:[UIImage imageNamed:@"ver.jpeg"]];
    
    return cell;
}

/*-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGSize maxSize = CGSizeMake(200, 200);
    CGSize cellSize = [[text objectAtIndex:indexPath.row]
                       sizeWithFont:[UIFont systemFontOfSize:16]
                       constrainedToSize:maxSize
                       lineBreakMode:NSLineBreakByWordWrapping];
    return cellSize.height+40;
}*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alerta" message:[groups objectAtIndex:indexPath.row] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];}

- (IBAction)configurationPressed:(id)sender {
    configurationViewController *conf = [[configurationViewController alloc] init];
    conf = [self.storyboard instantiateViewControllerWithIdentifier:@"configuracionView"];
    conf.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:conf animated:YES completion:nil];
}
@end
