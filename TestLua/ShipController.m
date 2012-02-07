//
//  ShipController.m
//  TestLua
//
//  Created by James Norton on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShipController.h"

@implementation ShipController

@synthesize x, y, name;

-(id) initWithX:(float)_x Y:(float)_y Speed:(float)_s Name:(NSString *)_name{
    self = [super init];
    if (self) {
        x = _x;
        y = _y;
        speed = _s;
        name = _name;
        [name retain];
    }
    
    return self;
}

-(void) pressLeftButton {
    NSLog(@"Left button pressed for ship %@", self.name);
    x = x - speed;
}


-(void) pressRightButton {
    NSLog(@"Right button pressed for ship %@", self.name);
    x = x + speed;
}

-(void) pressTopButton {
    NSLog(@"Top button pressed for ship %@", self.name);
    y = y + speed;
}

-(void) pressBottomButton {
    NSLog(@"Bottom button pressed for ship %@", self.name);
    y = y - speed;
}





@end
