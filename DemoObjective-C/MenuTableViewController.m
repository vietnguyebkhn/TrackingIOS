//
//  MenuTableViewController.m
//  DemoObjective-C
//
//  Created by Nguyễn Việt on 11/3/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

#import "MenuTableViewController.h"
#import "MenuTableViewCell.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController {
    NSArray *menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"MenuTableViewCell"];
    menu = @[@"Thong tin ca nhan", @"Crash App", @"Gioi thieu", @"Thoat"];
   
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuTableViewCell" forIndexPath: indexPath];
    if (cell == nil) {
    cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuTableViewCell"];
    }
    cell.mLabel.text = menu[indexPath.row];
    
    return cell;
}



@end
