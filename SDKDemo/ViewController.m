//
//  ViewController.m
//  SDKDemo
//
//  Created by Sean Ooi on 7/22/15.
//  Copyright (c) 2015 Yella Inc. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Ray SDK";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshView) name:notificationRefreshKey object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)refreshView {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self appDelegate].items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *dict = [self appDelegate].items[indexPath.row];
    if(dict) {
        RSDKBeacon *beacon = (RSDKBeacon *)dict[@"beacon"];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%hu-%hu", beacon.major, beacon.minor];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"RSSI %li", (long)beacon.rssi];
    }
    else {
        cell.textLabel.text = @"Some beacon";
        cell.detailTextLabel.text = @"I have no idea";
    }
    
    return cell;
}

@end
