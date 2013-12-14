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

#import "UIMenuBar.h"
#import <QuartzCore/QuartzCore.h>

#define kSemiModalAnimationDuration 0.3f

@interface UIMenuBar ()

- (void)_initCommonUI;
- (void)_resetSubViewsLayout;
- (void)_resetContainerViewLayout;
- (void)_presentModelView;
- (void)_dismissModalView;

@end


@implementation UIMenuBar

@synthesize delegate = _delegate;
@synthesize items = _items;
@synthesize selectedItem = _selectedItem;
@synthesize tintColor = _tintColor;

- (id)init
{
    self = [super init];
    if (self) {
        
        CGSize size = [[UIScreen mainScreen] applicationFrame].size;
        self.frame = CGRectMake(0, 0, size.width, size.height/2.);
        _items = [[NSMutableArray alloc] initWithCapacity:0];
        _containerScrollViews = [[NSMutableArray alloc] initWithCapacity:0];
        [self _initCommonUI];
        [self _resetSubViewsLayout];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame items:(NSArray *)items
{
    if(self = [super initWithFrame:frame]){
        _items = [[NSMutableArray alloc] initWithArray:items];
        _containerScrollViews = [[NSMutableArray alloc] initWithCapacity:0];
        [self _initCommonUI];
        [self _resetSubViewsLayout];
    }
    return self;
}


- (void)setItems:(NSMutableArray *)items
{
    for(UIMenuBarItem *item in _items){
        [item.containView removeFromSuperview];
    }
    
    [_items removeAllObjects];
    [_items addObjectsFromArray:items];
    
    [self _resetSubViewsLayout];
    
}

- (void)_initCommonUI
{
    _originalSize = self.frame.size;
    _halfOriginalSize = CGSizeMake(_originalSize.width, _originalSize.height/2.0f);
    
    self.backgroundColor = (_tintColor = [[UIColor colorWithRed:0. green:0. blue:0. alpha:.5] retain]);
    //self.backgroundColor = [UIColor blackColor];
    _pages = (_items.count / 6) + (_items.count % 6 == 0 ? 0 : 1);
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,
                                                                   self.bounds.size.height-20.f,
                                                                   self.bounds.size.width,
                                                                   20.0f)];
    _pageControl.numberOfPages = _pages;
    _pageControl.currentPage = 1;
    [_pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventValueChanged];
    _pageControl.backgroundColor =  [UIColor clearColor];
    [self addSubview:_pageControl];
    
    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    self.bounds.size.width,
                                                                    self.bounds.size.height - _pageControl.bounds.size.height)];
    _containerView.delegate = self;
    _containerView.pagingEnabled = YES;

    [self addSubview:_containerView];
    
    
}

- (void)_resetContainerViewLayout
{
    if(_items.count <= 3){
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                _halfOriginalSize.width,
                                _halfOriginalSize.height);
    }else {
        self.frame = CGRectMake(self.frame.origin.x,
                                self.frame.origin.y,
                                _originalSize.width,
                                _originalSize.height);
    }
    
    if(_pages > 1) {
        
        _pageControl.hidden = FALSE;
        _containerView.scrollEnabled = TRUE;
        _containerView.frame = CGRectMake(0,
                                          0,
                                          self.bounds.size.width,
                                          self.bounds.size.height - _pageControl.bounds.size.height);
    }else {
        
        _pageControl.hidden = TRUE;
        _containerView.scrollEnabled = FALSE;
        _containerView.frame = CGRectMake(0,
                                          0,
                                          self.bounds.size.width,
                                          self.bounds.size.height);
    }
    
    _containerView.contentSize = CGSizeMake(_pages * _containerView.bounds.size.width,
                                            _containerView.bounds.size.height);
}

- (void)_resetSubViewsLayout
{
    if(_items.count==0) return;
    
    _pages = (_items.count / 6) + (_items.count % 6 == 0 ? 0 : 1);
    _pageControl.numberOfPages = _pages;
    _pageControl.currentPage = 1;
    
    [self _resetContainerViewLayout];
    
    
    if(_containerScrollViews && _containerScrollViews.count > 0){
        for(UIView * view in _containerScrollViews){
            [view removeFromSuperview];
        }
        [_containerScrollViews removeAllObjects];
    }

    for(int page = 0; page < _pages; page ++){

        UIView* pageContent = [[UIView alloc] initWithFrame:CGRectMake(page * _containerView.bounds.size.width,
                                                                       0,
                                                                       _containerView.bounds.size.width,
                                                                       _containerView.bounds.size.height)];
                
        for(int index = (page * 6); index < (page * 6 + 6); index++) {

            if(index == _items.count) break;            
            UIMenuBarItem *item = (UIMenuBarItem *)[_items objectAtIndex:index];
            
            int relativeIndex = index - (page * 6);
            int row = relativeIndex/3 < 1? 0 : 1;
            int coloumn = (relativeIndex % 3);
            
            int width = self.frame.size.width/3.0f;
            int x = (width-item.sizeValue)/2.0f;
            
            int height = (_containerView.frame.size.height)/2.0f;
            int y = (height-item.sizeValue)/2.0f;

            item.containView.frame = CGRectMake(x+width*coloumn,
                                                y+row*height,
                                                item.sizeValue,
                                                item.sizeValue);
            
            [pageContent addSubview:item.containView];
        }
        

        [_containerScrollViews addObject:pageContent];
        [_containerView addSubview:pageContent];
        [pageContent release];
    }
}


- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
{
	CGPoint offset = aScrollView.contentOffset;
	_pageControl.currentPage = offset.x / _containerView.bounds.size.width;
}

- (void) pageTurn: (UIPageControl *) aPageControl
{
	int whichPage = aPageControl.currentPage;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.1f];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	_containerView.contentOffset = CGPointMake(_containerView.bounds.size.width * whichPage, 0.0f);
	[UIView commitAnimations];
}

- (void)setTintColor:(UIColor *)tintColor
{
    if(_tintColor){
        [_tintColor release];
        _tintColor = nil;
    }
    
    _tintColor = [tintColor retain];
    self.backgroundColor = _tintColor;
}

- (void)show
{
    [self _presentModelView];
}

- (void)dismiss
{
    [self _dismissModalView];
}


- (void)_presentModelView
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    NSLog(@"%@", keywindow);
    if (![keywindow.subviews containsObject:self]) {
        // Calulate all frames
        CGRect sf = self.frame;
        CGRect vf = keywindow.frame;
        CGRect f  = CGRectMake(0, vf.size.height-sf.size.height, vf.size.width, sf.size.height);
        CGRect of = CGRectMake(0, 0, vf.size.width, vf.size.height-sf.size.height);
        
        // Add semi overlay
        UIView * overlay = [[UIView alloc] initWithFrame:keywindow.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6]; 
        
        UIView* ss = [[UIView alloc] initWithFrame:keywindow.bounds];
        [overlay addSubview:ss];
        [keywindow addSubview:overlay];
        
        UIControl * dismissButton = [[UIControl alloc] initWithFrame:CGRectZero];
        [dismissButton addTarget:self action:@selector(_dismissModalView) forControlEvents:UIControlEventTouchUpInside];
        dismissButton.backgroundColor = [UIColor clearColor];
        dismissButton.frame = of;
        [overlay addSubview:dismissButton];
        
        // Begin overlay animation
        [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
            ss.alpha = 0.5;
        }];
        
        // Present view animated
        self.frame = CGRectMake(0, vf.size.height, vf.size.width, sf.size.height);
        [keywindow addSubview:self];
        self.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.layer.shadowOffset = CGSizeMake(0, -2);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowOpacity = 0.8;
        [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
            self.frame = f;
        }];
    }
}

- (void)_dismissModalView
{    
    UIWindow * keywindow = [[UIApplication sharedApplication] keyWindow];
    UIView * modal = [keywindow.subviews objectAtIndex:keywindow.subviews.count-1];
    UIView * overlay = [keywindow.subviews objectAtIndex:keywindow.subviews.count-2];
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
        modal.frame = CGRectMake(0, keywindow.frame.size.height, modal.frame.size.width, modal.frame.size.height);
    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
        [modal removeFromSuperview];
    }];
    
    // Begin overlay animation
    UIImageView * ss = (UIImageView*)[overlay.subviews objectAtIndex:0];
    [UIView animateWithDuration:kSemiModalAnimationDuration animations:^{
        ss.alpha = 1;
    }];
}


- (void)dealloc
{
    [_items release], _items = nil;
    [_tintColor release], _tintColor = nil;
    [_pageControl release], _pageControl = nil;
    [_containerView release], _containerView = nil;
    [_containerScrollViews release], _containerScrollViews = nil;
    
    [super dealloc];
}
@end

