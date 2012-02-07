//
//  ViewController.m
//  TestLua
//
//  Created by James Norton on 2/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "ShipController.h"



int luaopen_mylib(lua_State *L);

ShipController *playerShipController;
ShipController *enemyShipController;

static int player_ship_position(lua_State *L){
    lua_pushnumber(L, playerShipController.x);
    lua_pushnumber(L, playerShipController.y);
    
    return 2; 
}

static int press_right_button(lua_State *L){
    ShipController *sc = (ShipController *)lua_touserdata(L, 1);
    [sc pressRightButton];
    
    return 0;
}

static int press_left_button(lua_State *L){
    ShipController *sc = (ShipController *)lua_touserdata(L, 1);
    [sc pressLeftButton];
    
    return 0;
}

static int press_top_button(lua_State *L){
    ShipController *sc = (ShipController *)lua_touserdata(L, 1);
    [sc pressTopButton];
    
    return 0;
}

static int press_bottom_button(lua_State *L){
    ShipController *sc = (ShipController *)lua_touserdata(L, 1);
    [sc pressBottomButton];
    
    return 0;
}

static int get_ship_position(lua_State *L){
    ShipController *sc = (ShipController *)lua_touserdata(L, 1);
    
    // push x and y position on the stack
    lua_pushnumber(L, sc.x);
    lua_pushnumber(L, sc.y);
    
    // let the caller know how many results are available on the stack
    return 2;
}


static const struct luaL_Reg shiplib_f [] = {
    {"player_ship_position", player_ship_position},
    {"press_right_button", press_right_button},
    {"press_left_button", press_left_button},
    {"press_top_button", press_top_button},
    {"press_bottom_button", press_bottom_button},
    {"get_ship_position", get_ship_position},
    {NULL, NULL}
};

int luaopen_mylib (lua_State *L){
    
    luaL_register(L, "ship", shiplib_f);
    
    return 1;
}


@implementation ViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // create the ship for the player
    playerShipController = [[ShipController alloc] initWithX:100 Y:100 Speed:2.0 Name:@"player_ship"];

    enemyShipController = [[ShipController alloc] initWithX:105 Y:102 Speed:1.0 Name:@"enemy_ship"];
    
    // initialize Lua and our load our lua file
    L = luaL_newstate(); // create a new state structure for the interpreter
	luaL_openlibs(L); // load all the standard libraries into the interpreter
    
    lua_settop(L, 0);
    
    int err;    
	    
    NSString *luaFilePath = [[NSBundle mainBundle] pathForResource:@"enemy_ship" ofType:@"lua"];
    
    err = luaL_loadfile(L, [luaFilePath cStringUsingEncoding:[NSString defaultCStringEncoding]]);
	if (0 != err) {
        luaL_error(L, "cannot compile lua file: %s",
                   lua_tostring(L, -1));
		return;
	}
    
	
    err = lua_pcall(L, 0, 0, 0);
	if (0 != err) {
		luaL_error(L, "cannot run lua file: %s",
                   lua_tostring(L, -1));
		return;
	}
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runLoop:) userInfo:nil repeats:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


# pragma mark - Button actions
-(void) pressLeftButton:(id) sender {
    [playerShipController pressLeftButton];
}


-(void) pressRightButton:(id) sender {
    [playerShipController pressRightButton];
}

-(void) pressTopButton:(id) sender {
    [playerShipController pressTopButton];
}

-(void) pressBottomButton:(id) sender {
    [playerShipController pressBottomButton];
}

-(void)runLoop:(id)sender {
    
    
    // put the pointer to the lua function we want on top of the stack
    lua_getglobal(L,"process");
    
    lua_pushlightuserdata(L, enemyShipController);
    
    // call the function on the stack
    int err = lua_pcall(L, 1, 0, 0);
	if (0 != err) {
		luaL_error(L, "cannot run lua file: %s",
                   lua_tostring(L, -1));
		return;
	}
    
    NSLog(@"%@ at (%f,%f)", playerShipController.name, playerShipController.x, playerShipController.y);
    NSLog(@"%@ ship at (%f,%f)", enemyShipController.name, enemyShipController.x, enemyShipController.y);
}

@end
