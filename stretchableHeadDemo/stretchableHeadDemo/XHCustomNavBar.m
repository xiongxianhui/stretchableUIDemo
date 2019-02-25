//
//  XHCustomNavBar.m
//  stretchableHeadDemo
//
//  Created by Mr.xiong on 2019/2/25.
//  Copyright © 2019 xianhui. All rights reserved.
//

#import "XHCustomNavBar.h"

@interface XHCustomNavBar()
@property (nonatomic,strong)UILabel *titleLabel;
@end

@implementation XHCustomNavBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
       
        [self setupUI];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title {
    
    _titleLabel.text = title;
}

-(void)setTitleColor:(UIColor *)titleColor {
    
     _titleLabel.textColor = titleColor;
}

- (void)setupUI {
    
    _titleLabel = [[UILabel alloc] initWithFrame: self.frame];
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_titleLabel];
}
@end
