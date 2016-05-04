//
//  GSBBubbleCell.h
//
//  Created by Gareth Bestor on 2/17/16.
//  Copyright (c) 2016 tiritea. All rights reserved.
//
// Note: set indentationLevel (and/or indentationWidth) to adjust RHS/LHS bubble indentation.
// If applicable, this will also indent the imageView appropriately.
//
// Usage:
//      [self.tableView registerClass:GSBBubbleCell.class forCellReuseIdentifier:@"BubbleCell"];
//      ...
//      GSBBubbleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BubbleCell"];
//      cell.bubbleStyle = GSBBubbleCellStyleLeft;
//      cell.indentationLevel = 1;
//      cell.textLabel = @"I love bubbles!";
//      cell.imageView.image = [UIImage imageNamed:@"bubbles.png"];
//

#import <UIKit/UIKit.h>

typedef enum {
    GSBBubbleCellStyleRight = 0, // default
    GSBBubbleCellStyleLeft
} GSBBubbleCellStyle;

@interface GSBBubbleCell : UITableViewCell
@property GSBBubbleCellStyle bubbleStyle;
@end
