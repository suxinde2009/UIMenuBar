/*
 The MIT License (MIT)
 
 Copyright (c) 2013 SuXinDe (Email: suxinde2009@126.com)
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import "UIMenuBarItem.h"
#import <QuartzCore/QuartzCore.h>

@interface UIMenuBarItem ()

- (void)setup;
- (void)layOutSubviews;

@end

@implementation UIMenuBarItem

@synthesize title = _title;
@synthesize image = _image;
@synthesize action = _action;
@synthesize containView = _containView;
@synthesize sizeValue = _sizeValue;

- (id)initWithTitle:(NSString *)title
             target:(id)target
              image:(UIImage *)image
             action:(SEL)action
{
    if(self = [super init]){
        
        _title = [[NSString stringWithFormat:@"%@", title] retain];
        _image = [[UIImage imageWithCGImage:image.CGImage] retain];
        _action = action;
        _target = [target retain];
        
        _containView = [[UIControl alloc] initWithFrame:CGRectZero];
        [_containView addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        _imageView = [[UIImageView alloc] initWithImage:image];

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        _titleLabel.numberOfLines = 1;
        _titleLabel.font = [UIFont systemFontOfSize:13.f];
        _titleLabel.text = title;
        
        [_containView addSubview:_imageView];
        [_containView addSubview:_titleLabel];
        
        _sizeValue = ([UIScreen mainScreen].bounds.size.width - 40.0f)/3.0f;
        
        [self setup];
        
    }
    return self;
}

- (void)setup
{
    _containView.backgroundColor = [UIColor clearColor];
    
    [_containView addTarget:self
                     action:@selector(addHighlight)
           forControlEvents: UIControlEventTouchDown];
    
    [_containView addTarget:self
                     action:@selector(removeHighlight)
           forControlEvents: UIControlEventTouchCancel | UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    
    [self layOutSubviews];
    
}

- (void)addHighlight
{
    _containView.backgroundColor = [UIColor colorWithRed:1. green:.5 blue:0. alpha:.8];
}

- (void)removeHighlight
{
    _containView.backgroundColor = [UIColor clearColor];
}



- (void)layOutSubviews
{
    _containView.frame = CGRectMake(0, 0, _sizeValue, _sizeValue);
    //_containView.layer.borderWidth = 1.0f;
    //_containView.layer.borderColor = [[UIColor orangeColor] CGColor];
    _imageView.center = CGPointMake(_containView.center.x,
                                    _containView.center.y-10.f);
    
    _titleLabel.frame = CGRectMake(2,
                                   _containView.bounds.size.height-25.0f,
                                   _containView.bounds.size.width-4,
                                   25.0f);
    
}


- (void)dealloc
{
    [_title release], _title = nil;
    [_image release], _image = nil;
    [_target release], _target = nil;
    [_containView release], _containView = nil;
    [_imageView release], _imageView = nil;
    [_titleLabel release], _titleLabel = nil;
    [super dealloc];
}

@end
