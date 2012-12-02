//
//  IBActionSheet.m
//  InnerBand
//
//  Created by John Blanco on 12/1/12.
//
//

#import "IBActionSheet.h"

@implementation IBActionSheet

- (id)initWithTitle:(NSString *)title cancelBlock:(void (^)(void))cancelBlock actionBlock:(void (^)(NSInteger))actionBlock cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    if ((self = [super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil])) {
        actionBlock_ = [actionBlock copy];
        cancelBlock_ = [cancelBlock copy];
    }

    return self;
}

#pragma mark -

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == self.cancelButtonIndex) {
        cancelBlock_();
    } else {
        actionBlock_(buttonIndex);
    }
}

@end
