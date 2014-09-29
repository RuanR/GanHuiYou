//
//  XLCycleScrollView.m
//  CycleScrollViewDemo
//
//  Created by xie liang on 9/14/12.
//  Copyright (c) 2012 xie liang. All rights reserved.
//

#import "XLCycleScrollView.h"
@implementation XLCycleScrollView

@synthesize scrollView = _scrollView;
@synthesize pageControl = _pageControl;
@synthesize currentPage = _curPage;
/*
- (void)dealloc
{
    [_scrollView release];
    [_pageControl release];
    [_curViews release];
    [super dealloc];
}*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 10;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.hidesForSinglePage = YES;
        [self addSubview:_pageControl];
        
        _curPage = 0;
    }
    return self;
}

- (void)setDataource:(id<XLCycleScrollViewDatasource>)datasource
{
    _datasource = datasource;
    [self reloadData];
}

- (void)reloadData
{
    _curPage = 0;
    _totalPages = [_datasource xlscrollNumberOfPages:self];
    [_curViews removeAllObjects];
    _curViews = nil;
    if (_totalPages == 0) {
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
        _pageControl.numberOfPages = _totalPages;
        NSArray *subViews = [_scrollView subviews];
        if([subViews count] != 0) {
            [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        }
            if ([self.delegate respondsToSelector:@selector(updatePage:)]) {
                [self.delegate performSelector:@selector(updatePage:) withObject:nil];
            }
        return;
    }
    [_scrollView setContentOffset:CGPointZero];
    _scrollView.contentSize = CGSizeMake(self.bounds.size.width * MIN(_totalPages, 3), self.bounds.size.height);
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
}

- (void)loadData
{
    if (!_curViews) {
        _curViews = [[NSMutableArray alloc] init];
        [self getDisplayImagesWithCurpage:0];
    }
    _pageControl.currentPage = _curPage;
    
    //从scrollView上移除所有的subview
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    //[self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < MIN(_curViews.count, 3); i++) {
        UIView *v = [_curViews objectAtIndex:i];
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
//        [singleTap release];
       v.frame = CGRectOffset(v.bounds, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
    }
    if (_curPage==0||_curPage+1==_totalPages) {
        [_scrollView setContentOffset:CGPointMake(0, 0)];
    }else{
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }
    
    [self scrollbyself];
    
}

- (void)scrollbyself
{
    if (_enable) {
        
        
        [self scrollViewDidEndDecelerating:_scrollView ];
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width*2, 0) animated:YES];
        [self scrollViewDidScroll:_scrollView];
        
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [self scrollViewDidEndDecelerating:_scrollView ];
            
            double delayInSeconds = 2;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                
                [self scrollbyself];
                
                
            });
        });
    }
    else
    {
        double delayInSeconds = 5.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self scrollbyself];
        });
    }
    
}

- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
//    if (!_curViews) {
//        _curViews = [[NSMutableArray alloc] init];
//    }
    
    //[_curViews removeAllObjects];
    
    if(pre<_curPage)[_curViews addObject:[_datasource xlscroll:self pageAtIndex:pre]];
    [_curViews addObject:[_datasource xlscroll:self pageAtIndex:page]];
    if(last>_curPage)[_curViews addObject:[_datasource xlscroll:self pageAtIndex:last]];
}

- (int)validPageValue:(NSInteger)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [_delegate didClickPage:self atIndex:_curPage];
    }
    
}

- (void)setViewContent:(UIView *)view atIndex:(NSInteger)index
{
    if (index == _curPage) {
        [_curViews replaceObjectAtIndex:1 withObject:view];
        for (int i = 0; i < 3; i++) {
            UIView *v = [_curViews objectAtIndex:i];
            v.userInteractionEnabled = YES;
            UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                        action:@selector(handleTap:)];
            [v addGestureRecognizer:singleTap];
            //[singleTap release];
            v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
            [_scrollView addSubview:v];
        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int x = scrollView.contentOffset.x;
    if (!_totalPages) {
        return;
    }
    //往下翻一张
    if ((_curPage==0&&x >= W(self))||x >= (2*W(self))) {
        if (_curPage+2>=_totalPages) {
            int p = [self validPageValue:_curPage+1];
            if (p>_curPage) {
                _curPage = p;
                _pageControl.currentPage = p;
            }
        }else{
        _curPage = [self validPageValue:_curPage+1];
        _pageControl.currentPage = _curPage;

        if(x >= (2*W(self)))[_curViews removeObjectAtIndex:0];
        int last = [self validPageValue:_curPage+1];
        [_curViews addObject:[_datasource xlscroll:self pageAtIndex:last]];
        [self loadData];
        }
    }
    
    //往上翻
    if((_curPage+1==_totalPages&&x<=W(self))||x <= 0) {
        if (_curPage<=1||_curPage==_totalPages-1) {
            int p = [self validPageValue:_curPage-1];
            if (p<_curPage) {
                _curPage = p;
                _pageControl.currentPage = p;
                if (_curViews.count==3&&_curPage<=1) {
                    [_curViews removeLastObject];
                }
            }
        }else{
            
        _curPage = [self validPageValue:_curPage-1];
        _pageControl.currentPage = _curPage;
        int pre = [self validPageValue:_curPage-1];
        [_curViews removeLastObject];
        [_curViews insertObject:[_datasource xlscroll:self pageAtIndex:pre] atIndex:0];
        [self loadData];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    if (_curPage>=0&&_curPage<_totalPages) {
        if ([self.delegate respondsToSelector:@selector(updatePage:)]) {
            [self.delegate performSelector:@selector(updatePage:) withObject:I2N(_pageControl.currentPage)];
        }
    }

    //[_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:NO];
}

@end
