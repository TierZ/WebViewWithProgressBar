//
//  WebProgressView.h
//  WebViewWithProgressBar
//
//  Created by CumminsTY on 2018/11/1.
//  Copyright © 2018 --. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
// MARK: 获取屏幕高度
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WebProgressView : UIView
@property (nonatomic, strong) UIColor * lineColor;
-(void)startLoadingAnimation;
-(void)endLoadingAnimation;
@end

NS_ASSUME_NONNULL_END
