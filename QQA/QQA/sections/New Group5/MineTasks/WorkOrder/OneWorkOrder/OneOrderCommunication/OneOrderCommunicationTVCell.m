//
//  OneOrderCommunicationTVCell.m
//  QQA
//
//  Created by wang huiming on 2018/8/16.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "OneOrderCommunicationTVCell.h"
#import "OneOrderCommunication.h"
@implementation OneOrderCommunicationTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addAllViews];
    }
    return self;
}

-(void)addAllViews{
    _peopleImageView = [UIImageView new];
    [self.contentView addSubview:_peopleImageView];
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, iphoneWidth - 100, 60)];
    [self.contentView addSubview:self.contentLabel];
    _describeLabel = [UILabel new];
    _describeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_describeLabel];
}

-(void)setOneOrderCommunication:(OneOrderCommunication *)oneOrderCommunication{
    NSURL * url = [NSURL URLWithString:oneOrderCommunication.img];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImagePeople", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        // 异步下载图片
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            _peopleImageView.image = img;
        });
    });
    self.describeLabel.text = oneOrderCommunication.describe;
    self.contentLabel.text = oneOrderCommunication.content;
    self.contentLabel.font = [UIFont systemFontOfSize:18];
    self.contentLabel.numberOfLines = 0;//表示label可以多行显示
    self.contentLabel.textColor = [UIColor blackColor];
    CGSize sourceSize = CGSizeMake(iphoneWidth - 120, 2000);
    CGRect targetRect = [self.contentLabel.text boundingRectWithSize:sourceSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.contentLabel.font} context:nil];
    if (CGRectGetHeight(targetRect) < 60) {
        _contentLabel.frame = CGRectMake(100, 5, iphoneWidth - 120, 60);
        _peopleImageView.frame = CGRectMake(12.5, 12.5, 75, 75);
        _describeLabel.frame = CGRectMake(100, 70, iphoneWidth - 100, 25);
    }else{
        _contentLabel.frame = CGRectMake(100, 5, iphoneWidth - 120, CGRectGetHeight(targetRect));
        _peopleImageView.frame = CGRectMake(12.5, (CGRectGetHeight(targetRect) - 40 ) / 2, 75, 75);
        _describeLabel.frame = CGRectMake(100, CGRectGetHeight(targetRect) + 10, iphoneWidth - 100, 25);
    }
    _peopleImageView.layer.cornerRadius = _peopleImageView.frame.size.width / 2;
    _peopleImageView.layer.masksToBounds = YES;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
