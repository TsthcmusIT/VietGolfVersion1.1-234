//
//  MSCMoreOptionTableViewCell.m
//  VietGolfVN
//
//  Created by admin on 7/19/14.
//  Copyright (c) 2014 Nguyen Duy Thanh. All rights reserved.
//

#import "MSCMoreOptionTableViewCell.h"

@implementation MSCMoreOptionTableViewCell

@synthesize _CellScrollView, _MoreOptionButton, _BtnFavorited, _Delegate;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _MoreOptionButton = nil;
        _CellScrollView = nil;
        _BtnFavorited = [[UIButton alloc] initWithFrame:CGRectMake(260.0f, 5.0f, 25.0f, 25.0f)];
        _BtnFavorited.backgroundColor = [UIColor clearColor];
        [self addSubview:_BtnFavorited];
        [self setupMoreOption];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _MoreOptionButton = nil;
        _CellScrollView = nil;
        
        [self setupMoreOption];
    }
    return self;
}

-(void)dealloc {
    [self._CellScrollView.layer removeObserver:self forKeyPath:@"sublayers" context:nil];
}


////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject(NSKeyValueObserving)
////////////////////////////////////////////////////////////////////////

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"sublayers"]) {
        /*
         * Using '==' instead of 'isEqual:' to compare the layer's _Delegate and the cell's contentScrollView
         * because it must be the same instance and not an equal one.
         */
        if ([object isKindOfClass:[CALayer class]] && ((CALayer *)object).delegate == self._CellScrollView) {
            BOOL moreOptionDelteButtonVisiblePrior = (self._MoreOptionButton != nil);
            BOOL swipeToDeleteControlVisible = NO;
            for (CALayer *layer in [(CALayer *)object sublayers]) {
                /*
                 * Check if the view is the "swipe to delete" container view.
                 */
                NSString *name = NSStringFromClass([layer.delegate class]);
                if ([name hasPrefix:@"UI"] && [name hasSuffix:@"ConfirmationView"]) {
                    if (self._MoreOptionButton) {
                        swipeToDeleteControlVisible = YES;
                    }
                    else {
                        UIView *deleteConfirmationView = layer.delegate;
                        UITableView *tableView = [self tableView];
                        
                        // Try to get "Delete" backgroundColor from __Delegate
                        if ([self._Delegate respondsToSelector:@selector(tableView:backgroundColorForDeleteConfirmationButtonForRowAtIndexPath:)]) {
                            UIButton *deleteConfirmationButton = [self deleteButtonFromDeleteConfirmationView:deleteConfirmationView];
                            if (deleteConfirmationButton) {
                                UIColor *deleteButtonColor = [self._Delegate tableView:tableView backgroundColorForDeleteConfirmationButtonForRowAtIndexPath:[tableView indexPathForCell:self]];
                                if (deleteButtonColor)
                                {
                                    deleteConfirmationButton.backgroundColor = deleteButtonColor;
                                }
                            }
                        }
                        
                        // Try to get "Delete" titleColor from __Delegate
                        if ([self._Delegate respondsToSelector:@selector(tableView:titleColorForDeleteConfirmationButtonForRowAtIndexPath:)]) {
                            UIButton *deleteConfirmationButton = [self deleteButtonFromDeleteConfirmationView:deleteConfirmationView];
                            if (deleteConfirmationButton) {
                                UIColor *deleteButtonTitleColor = [self._Delegate tableView:tableView titleColorForDeleteConfirmationButtonForRowAtIndexPath:[tableView indexPathForCell:self]];
                                if (deleteButtonTitleColor) {
                                    for (UIView *label in deleteConfirmationButton.subviews) {
                                        if ([label isKindOfClass:[UILabel class]]) {
                                            [(UILabel*)label setTextColor:deleteButtonTitleColor];
                                            break;
                                        }
                                    }
                                }
                            }
                        }
                        
                        if ([self moreOptionButtonTitle]) {
                            self._MoreOptionButton = [[UIButton alloc] initWithFrame:CGRectZero];
                            [self._MoreOptionButton addTarget:self action:@selector(moreOptionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                            
                            // Set "More" button's numberOfLines to 0 to enable support for multiline titles.
                            self._MoreOptionButton.titleLabel.numberOfLines = 0;
                            
                            /*
                             * Get "More" title from __Delegate. Doesn't have to check if __Delegate responds
                             * because this must be otherwise the "if"-clause wouldn't have been entered.
                             */
                            [self setMoreOptionButtonTitle:[self._Delegate tableView:tableView titleForMoreOptionButtonForRowAtIndexPath:[tableView indexPathForCell:self]] inDeleteConfirmationView:deleteConfirmationView];
                            
                            // Try to get "More" titleColor from __Delegate
                            UIColor *titleColor = nil;
                            if ([self._Delegate respondsToSelector:@selector(tableView:titleColorForMoreOptionButtonForRowAtIndexPath:)]) {
                                titleColor = [self._Delegate tableView:tableView titleColorForMoreOptionButtonForRowAtIndexPath:[tableView indexPathForCell:self]];
                            }
                            if (titleColor == nil) {
                                titleColor = [UIColor whiteColor];
                            }
                            [self._MoreOptionButton setTitleColor:titleColor forState:UIControlStateNormal];
                            
                            // Try to get "More" backgroundColor from __Delegate
                            UIColor *backgroundColor = nil;
                            if ([self._Delegate respondsToSelector:@selector(tableView:backgroundColorForMoreOptionButtonForRowAtIndexPath:)]) {
                                backgroundColor = [self._Delegate tableView:tableView backgroundColorForMoreOptionButtonForRowAtIndexPath:[tableView indexPathForCell:self]];
                            }
                            if (backgroundColor == nil) {
                                backgroundColor = [UIColor lightGrayColor];
                            }
                            [self._MoreOptionButton setBackgroundColor:backgroundColor];
                            
                            // Add the "More" button to the cell's view hierarchy
                            [deleteConfirmationView addSubview:self._MoreOptionButton];
                        }
                        
                        break;
                    }
                }
            }
            if (moreOptionDelteButtonVisiblePrior && !swipeToDeleteControlVisible) {
                self._MoreOptionButton = nil;
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - private methods
////////////////////////////////////////////////////////////////////////

/*
 * Looks for a UIDeleteConfirmationButton in a given UIDeleteConfirmationView.
 * Returns nil if the button could not be found.
 */
-(UIButton *)deleteButtonFromDeleteConfirmationView:(UIView *)deleteConfirmationView {
    for (UIButton *deleteConfirmationButton in deleteConfirmationView.subviews) {
        NSString *name = NSStringFromClass([deleteConfirmationButton class]);
        if ([name hasPrefix:@"UI"] && [name rangeOfString:@"Delete"].length > 0 && [name hasSuffix:@"Button"]) {
            return deleteConfirmationButton;
        }
    }
    return nil;
}

-(void)moreOptionButtonPressed:(id)sender {
    if ([self._Delegate respondsToSelector:@selector(tableView:moreOptionButtonPressedInRowAtIndexPath:)]) {
        [self._Delegate tableView:[self tableView] moreOptionButtonPressedInRowAtIndexPath:[[self tableView] indexPathForCell:self]];
    }
}

-(UITableView *)tableView {
    UIView *tableView = self.superview;
    while(tableView) {
        if(![tableView isKindOfClass:[UITableView class]]) {
            tableView = tableView.superview;
        }
        else {
            return (UITableView *)tableView;
        }
    }
    return nil;
}

-(void)setMoreOptionButtonTitle:(NSString *)title inDeleteConfirmationView:(UIView *)deleteConfirmationView {
    [self._MoreOptionButton setTitle:title forState:UIControlStateNormal];
    [self._MoreOptionButton sizeToFit];
    
    CGRect moreOptionButtonFrame = CGRectZero;
    moreOptionButtonFrame.size.width = self._MoreOptionButton.frame.size.width + 30.0f;
    /*
     * Look for the "Delete" button to apply it's height also to the "More" button.
     * If it can't be found there is a fallback to the deleteConfirmationView's height.
     */
    UIButton *deleteConfirmationButton = [self deleteButtonFromDeleteConfirmationView:deleteConfirmationView];
    if (deleteConfirmationButton) {
        moreOptionButtonFrame.size.height = deleteConfirmationButton.frame.size.height;
    }
    
    if (moreOptionButtonFrame.size.height == 0.0f) {
        moreOptionButtonFrame.size.height = deleteConfirmationView.frame.size.height;
    }
    self._MoreOptionButton.frame = moreOptionButtonFrame;
    
    CGRect rect = deleteConfirmationView.frame;
    rect.origin.x -= self._MoreOptionButton.frame.size.width;
    rect.size.width += self._MoreOptionButton.frame.size.width;
    
    deleteConfirmationView.frame = rect;
}

-(void)setupMoreOption {
    /*
     * Look for UITableViewCell's scrollView.
     * Any CALayer found here can only be generated by UITableViewCell's
     * 'initWithStyle:reuseIdentifier:', so there is no way adding custom
     * sublayers before. This means custom sublayers are no problem and
     * don't break MSCMoreOptionTableViewCell's functionality.
     */
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.delegate isKindOfClass:[UIScrollView class]]) {
            _CellScrollView = (UIScrollView *)layer.delegate;
            _CellScrollView.showsVerticalScrollIndicator = NO;
            [_CellScrollView.layer addObserver:self forKeyPath:@"sublayers" options:NSKeyValueObservingOptionNew context:nil];
            break;
        }
    }
}

-(NSString *)moreOptionButtonTitle {
    UITableView *tableView = [self tableView];
    
    NSString *moreTitle = nil;
    if ([self._Delegate respondsToSelector:@selector(tableView:titleForMoreOptionButtonForRowAtIndexPath:)]) {
        moreTitle = [self._Delegate tableView:tableView titleForMoreOptionButtonForRowAtIndexPath:[tableView indexPathForCell:self]];
    }
    
    return moreTitle;
}

@end
