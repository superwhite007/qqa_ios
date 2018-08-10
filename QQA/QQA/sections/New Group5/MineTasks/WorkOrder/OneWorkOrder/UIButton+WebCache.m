//
//  UIButton+WebCache.m
//  QQA
//
//  Created by wang huiming on 2018/8/10.
//  Copyright © 2018年 youth_huiming. All rights reserved.
//

#import "UIButton+WebCache.h"

@implementation UIButton (WebCache)
- (void)xr_setButtonImageWithUrl:(NSString *)urlStr {
    
    NSURL * url = [NSURL URLWithString:urlStr];
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    dispatch_async(xrQueue, ^{
        // 异步下载图片
        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        // 主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setImage:img forState:UIControlStateNormal];
        });
    });
    
}
@end
