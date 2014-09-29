//
//  StevTableView.m
//  Stev_Framework
//
//  Created by 孙向前 on 14-5-20.
//  Copyright (c) 2014年 孙向前. All rights reserved.
//

#import "StevTableView.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "NetEngine.h"
#import "NSDictionary+expanded.h"

@interface StevTableView()<MJRefreshBaseViewDelegate>

@property (nonatomic,strong) MJRefreshHeaderView *headerView;
@property (nonatomic,strong) MJRefreshFooterView *footerView;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation StevTableView
- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initComponents];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initComponents];
    }
    
    return self;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    super.delegate = delegate;
}

- (void)setDataCount:(NSInteger)t_dataCount
{
    _dataCount = t_dataCount;
    if (_dataCount < RHTableView_PageSize){
        _footerView.delegate = nil;
        [_footerView setHidden:YES];
    }
}

- (void)initComponents
{
    self.urlString = @"";
    /* refresh header view init */
    _headerView = [[MJRefreshHeaderView alloc] initWithScrollView:self];
    _headerView.delegate = self;
    
    /* refresh footer view init */
    _footerView = [[MJRefreshFooterView alloc] initWithScrollView:self];
    _footerView.delegate = self;
    
    _curPage = 0;
    
}

- (void)reloadData
{
    [super reloadData];
    self.dataCount = [self.dataArray count];
}

- (void)showRefreshHeader
{
    _headerView.hidden = NO;
    _headerView.delegate = self;
}
- (void)hiddenRefreshHeader
{
    _headerView.hidden = YES;
    _headerView.delegate = nil;
}
- (void)showLoadmoreFooter
{
    _footerView.hidden = NO;
    _footerView.delegate = self;
}
- (void)hiddenLoadmoreFooter
{
    _footerView.hidden = YES;
    _footerView.delegate = nil;
}

- (void)refresh{
    _curPage = 0;
    [NetEngine createGetAction:[NSString stringWithFormat:self.urlString,[NSString stringWithFormat:@"%d",_curPage]]
                    parameters:nil
                      withMask:SVProgressHUDMaskTypeNone
                     withCache:NO
                  onCompletion:^(id resData, id resString, BOOL isCache) {
                        NSArray *temp = [resData valueForJSONKeys:@"Result",@"PagedList", nil];
                        if ([temp isKindOfClass:[NSArray class]]) {
                            if (temp && [temp count] > 0) {
                                self.dataArray = [NSMutableArray arrayWithArray:temp];
                                DLog(@"%@",self.dataArray);
                                //self.dataCount = [self.dataArray count];
                                [self reloadData];
                                isCache?nil:[self stopRefresh];
                            }
                        }
                    } onError:^(NSError *error) {
                        [self stopRefresh];
                    }];
   
}
- (void)stopRefresh
{
    [_headerView endRefreshing];
}
- (void)loadMore{
    _curPage++;
    [NetEngine createGetAction:[NSString stringWithFormat:self.urlString,[NSString stringWithFormat:@"%d",_curPage]]
                    parameters:nil
                      withMask:SVProgressHUDMaskTypeNone
                     withCache:NO
                  onCompletion:^(id resData, id resString, BOOL isCache) {
                        NSArray *temp = [resData valueForJSONKeys:@"Result",@"PagedList", nil];
                        if ([temp isKindOfClass:[NSArray class]]) {
                            if (temp && [temp count] > 0) {
                                [self.dataArray addObjectsFromArray:temp];
                                DLog(@"%@",self.dataArray);
                                [self reloadData];
                            } else {
                                if (_curPage > 1) {
                                    _curPage --;
                                }
                                [SVProgressHUD showErrorWithStatus:@"暂无数据"];
                            }
                            [self stopLoadMore];
                        }
                    } onError:^(NSError *error) {
                        if (_curPage > 1) {
                            _curPage --;
                        }
                        [self stopLoadMore];
                    }];
}

- (void)stopLoadMore{
    [_footerView endRefreshing];
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:1];
}

- (void)doneWithView:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isEqual:_headerView]) {
        [self refresh];
    } else {
        if (self.dataCount >= RHTableView_PageSize) {
            [self loadMore];
        }
    }
    
}

- (void)dealloc
{
    [_headerView free];
    [_footerView free];
}

@end
