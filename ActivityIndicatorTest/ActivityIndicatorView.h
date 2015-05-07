//
//  ActivityIndicatorView.h
//  HubTest
//
//  Created by caoZhenWei on 15/5/5.
//  Copyright (c) 2015年 caoZhenWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityIndicatorView : UIView

- (id)initWithView:(UIView *)view;
- (void)startAnimating;
- (void)stopAnimating;

@end
