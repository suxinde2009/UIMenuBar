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

// UITabBar
// UIToolbar
// UINavigationBar

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIMenuBarItem.h"

@class UIMenuBar;

@protocol UIMenuBarDelegate <NSObject>
@optional
- (void)menuBar:(UIMenuBar *)menuBar didSelectAtIndex:(int)index;

@end

@interface UIMenuBar : UIView <UIScrollViewDelegate>//,UIAppearance>
{
@private
    id<UIMenuBarDelegate>  _delegate;
    NSMutableArray        *_items;
    UIMenuBarItem         *_selectedItem;
    UIColor               *_tintColor;
    
    NSInteger              _pages;                  
    UIScrollView          *_containerView;          
    UIPageControl         *_pageControl;            
    NSMutableArray        *_containerScrollViews;
    CGSize                 _originalSize;
    CGSize                 _halfOriginalSize;
}

@property (nonatomic, assign) id<UIMenuBarDelegate> delegate;     // weak reference. default is nil
@property (nonatomic, copy)   NSMutableArray       *items;
@property (nonatomic, assign) UIMenuBarItem        *selectedItem; // will show feedback based on mode. default is nil
@property (nonatomic, retain) UIColor              *tintColor;    // Default is black.

- (id)initWithFrame:(CGRect)frame items:(NSArray *)items;
- (void)setItems:(NSMutableArray *)items;
- (void)show;  
- (void)dismiss; 

@end
