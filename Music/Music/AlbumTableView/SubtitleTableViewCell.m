//
// Created by Daniel Burkle on 6/9/17.
// Copyright (c) 2017 National Information Solutions Cooperative. All rights reserved.
//

#import "SubtitleTableViewCell.h"

@implementation SubtitleTableViewCell

- (instancetype)init
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SubtitleTableView"];
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    return self;
}

@end