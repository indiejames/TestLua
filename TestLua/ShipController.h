//
//  ShipController.h
//  TestLua
//
//  Created by James Norton on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipController : NSObject {
    float x;
    float y;
    float speed;
    NSString *name;
}

@property (readonly) float x;
@property (readonly) float y;
@property (readonly) NSString *name;

-(id) initWithX:(float)x Y:(float)y Speed:(float)speed Name:(NSString *)name;
-(IBAction)pressLeftButton;
-(IBAction)pressRightButton;
-(IBAction)pressTopButton;
-(IBAction)pressBottomButton;

@end

