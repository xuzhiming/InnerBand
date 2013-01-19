//
//  IBTargetAction.h
//  InnerBand
//
//  Created by John Blanco on 3/23/12.
//  Copyright (c) 2012 Rapture In Venice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBTargetAction : NSObject

#if __has_feature(objc_arc)
    @property (nonatomic, weak) id target;
#else
    @property (nonatomic, assign) id target;
#endif

@property (nonatomic, copy) NSString *action;

@end
