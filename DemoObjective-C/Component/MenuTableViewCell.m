//
//  MenuTableViewCell.m
//  DemoObjective-C
//
//  Created by Nguyễn Việt on 11/3/18.
//  Copyright © 2018 Quynhbkhn. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell{
    NSArray *menuLb;
  //  NSArray *menuImage;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    menuLb = @[@"Thong tin ca nhan", @"Crash App", @"Gioi thieu", @"Thoat"];
    
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
