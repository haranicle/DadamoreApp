//
//  Nums.m
//  DadamoreApp
//
//  Created by haranicle on 2014/11/07.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

#import "Nums.h"

@implementation Nums

@dynamic num;
@dynamic recordId;

- (NSString*)description {
    return [NSString stringWithFormat:@"(%@) %@\n", self.recordId, self.num];
}

@end
