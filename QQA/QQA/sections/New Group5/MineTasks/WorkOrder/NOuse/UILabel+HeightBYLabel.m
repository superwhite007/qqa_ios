//
//  UILabel+HeightBYLabel.m
//  QQA
//
//  Created by wang huiming on 2018/8/9.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "UILabel+HeightBYLabel.h"

@implementation UILabel (HeightBYLabel)
-(CGFloat)heightAboutCellLabel:(NSString *)labelContent font:(int)font labelWidth:(int)width{
    UILabel * label = [UILabel new];
    label.text = labelContent;
    label.font = [UIFont systemFontOfSize:font];
    label.numberOfLines = 0;//表示label可以多行显示
    label.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(width, 2000);
    CGRect targetRect = [label.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : label.font} context:nil];
    return CGRectGetHeight(targetRect) + 60;
}
@end
