/*
	INTERFACE.C
	Thursday, December 30, 1993 6:56:22 PM
	Mac specific code.....

	Friday, July 8, 1994 2:32:44 PM (alain)
		All old code in here is obsolete. This now has interface for the top-level
		interface (Begin Game, etcÉ)
	Saturday, September 10, 1994 12:45:48 AM  (alain)
		the interface gutted again. just the stuff that handles the menu though, the rest stayed
		the same.
	Thursday, June 8, 1995 2:56:16 PM (ryan)
		Pillaged, raped, & burned. (in that order)

Jan 30, 2000 (Loren Petrich):
	Added some typecasts
	Removed some "static" declarations that conflict with "extern"
	Surrounded choose_saved_game_to_load with "extern "C""

Feb. 4, 2000 (Loren Petrich):
	Changed halt() to assert(false) for better debugging

Feb. 9, 2000 (Loren Petrich):
	Changed NUMBER_OF_INTRO_SCREENS to 3
	Changed NUMBER_OF_CREDIT_SCREENS to Hamish Sinclair's favorite number
	
	Fixed multiple-clicks-necessary problem for too few screens.
	Was in next_game_state(); set game_state.phase (countdown value) to zero.
	
Feb 19, 2000 (Loren Petrich):
	Set the single-player color to the player color set in the preferences,
	for the benefit of chase-cam users.

Mar 5, 2000 (Loren Petrich):
	Added reset_screen() when starting a game, so that extravision
	will not be persistent.

May 13, 2000 (Loren Petrich):
	Added Rhys Hill's fix for problems with quitting OpenGL

Aug 12, 2000 (Loren Petrich):
	Using object-oriented file handler

Aug 24, 2000 (Loren Petrich):
	Added source selector to calculate_picture_clut(), in order to better deal with
	object-oriented file handlers
*/

// NEED VISIBLE FEEDBACK WHEN APPLETALK IS NOT AVAILABLE!!!

#include "cseries.h" // sorry ryan, nov. 4
#include <string.h>
#include <stdlib.h>
#include <limits.h>

#ifdef PERFORMANCE
#include <perf.h>

extern TP2PerfGlobals perf_globals;
#endif

#include "map.h"
#include "interface.h"
#include "player.h"
#include "screen_drawing.h"
#include "mysound.h"
#include "fades.h"
#include "game_window.h"
#include "game_errors.h"
#include "music.h"
#include "images.h"
#include "screen.h"
#include "network.h"
#include "vbl.h"
#include "shell.h"
#include "preferences.h"
#include "FileHandler.h"

/* Change this when marathon changes & replays are no longer valid */
#define RECORDING_VERSION 0

#include "screen_definitions.h"
#include "interface_menus.h"

// LP addition: getting OpenGL rendering stuff
#include "render.h"
#include "OGL_Render.h"

#ifdef env68k
	#pragma segment shell
#endif

/* ------------- enums */

/* ------------- constants */
#define DISPLAY_PICT_RESOURCE_TYPE 'PICT'
#define CLOSE_WITHOUT_WARNING_DELAY (5*TICKS_PER_SECOND)

// LP change:
#define NUMBER_OF_INTRO_SCREENS (3)
/*
#ifdef DEBUG
	#define NUMBER_OF_INTRO_SCREENS (0)
#else
	#ifdef DEMO
		#define NUMBER_OF_INTRO_SCREENS (2)
	#else
		#define NUMBER_OF_INTRO_SCREENS (1)
	#endif
#endif
*/
#define INTRO_SCREEN_DURATION (215) // fudge to align with sound

#ifdef DEMO
#define INTRO_SCREEN_TO_START_SONG_ON (1)
#else
#define INTRO_SCREEN_TO_START_SONG_ON (0)
#endif

#define INTRO_SCREEN_BETWEEN_DEMO_BASE (INTRO_SCREEN_BASE+1) /* +1 to get past the powercomputing */
#define NUMBER_OF_INTRO_SCREENS_BETWEEN_DEMOS (1)
#define DEMO_INTRO_SCREEN_DURATION (10*TICKS_PER_SECOND)

#define TICKS_UNTIL_DEMO_STARTS (30*TICKS_PER_SECOND)

#define NUMBER_OF_PROLOGUE_SCREENS 0
#define PROLOGUE_DURATION (10*TICKS_PER_SECOND)

#define NUMBER_OF_EPILOGUE_SCREENS 1
#define EPILOGUE_DURATION (INDEFINATE_TIME_DELAY)

// LP change:
#define NUMBER_OF_CREDIT_SCREENS 7
// #define NUMBER_OF_CREDIT_SCREENS 1
#define CREDIT_SCREEN_DURATION (15*60*TICKS_PER_SECOND)

#define NUMBER_OF_CHAPTER_HEADINGS 0
#define CHAPTER_HEADING_DURATION (7*MACHINE_TICKS_PER_SECOND)

#if defined(DEBUG) || !defined(DEMO)
#define NUMBER_OF_FINAL_SCREENS 0
#else
#define NUMBER_OF_FINAL_SCREENS 1
#endif
#define FINAL_SCREEN_DURATION (INDEFINATE_TIME_DELAY)

/* ------------- structures */
struct game_state {
	short state;
	short flags;
	short user;
	long phase;
	long last_ticks_on_idle;
	short current_screen;
	bool suppress_background_tasks;
	bool current_netgame_allows_microphone;
	short main_menu_display_count; // how many times have we shown the main menu?
};

struct screen_data {
	short screen_base;
	short screen_count;
	long duration;
};

/* -------------- constants */
struct screen_data display_screens[]= {
	{ INTRO_SCREEN_BASE, NUMBER_OF_INTRO_SCREENS, INTRO_SCREEN_DURATION },
	{ MAIN_MENU_BASE, 1, 0 },
	{ CHAPTER_SCREEN_BASE, NUMBER_OF_CHAPTER_HEADINGS, CHAPTER_HEADING_DURATION },
	{ PROLOGUE_SCREEN_BASE, NUMBER_OF_PROLOGUE_SCREENS, PROLOGUE_DURATION },
	{ EPILOGUE_SCREEN_BASE, NUMBER_OF_EPILOGUE_SCREENS, EPILOGUE_DURATION },
	{ CREDIT_SCREEN_BASE, NUMBER_OF_CREDIT_SCREENS, CREDIT_SCREEN_DURATION},
	{ INTRO_SCREEN_BETWEEN_DEMO_BASE, NUMBER_OF_INTRO_SCREENS_BETWEEN_DEMOS, DEMO_INTRO_SCREEN_DURATION },
	{ FINAL_SCREEN_BASE, NUMBER_OF_FINAL_SCREENS, FINAL_SCREEN_DURATION }
};

#if 0
struct chapter_screen_sound_data {
	short level;
	short sound_code;
};

struct chapter_screen_sound_data chapter_screen_sounds[]=
{
	{0, _snd_chapter1},
	{1, _snd_chapter2},
	{2, _snd_chapter3}
};
#define NUMBER_OF_CHAPTER_SCREEN_SOUNDS (sizeof(chapter_screen_sounds)/sizeof(chapter_screen_sounds[1]))
#endif

/* -------------- local globals */
static struct game_state game_state;
static FileSpecifier DraggedReplayFile;
static bool interface_fade_in_progress= false;
static short interface_fade_type;
static short current_picture_clut_depth;
static struct color_table *animated_color_table= NULL;
static struct color_table *current_picture_clut= NULL;

/* -------------- externs */
extern short interface_bit_depth;
extern short bit_depth;

/* ----------- prototypes/PREPROCESS_MAP_MAC.C */
extern bool load_game_from_file(FileSpecifier& File);
extern bool choose_saved_game_to_load(FileSpecifier& File);

/* ---------------------- prototypes */
static void display_credits(void);
static void draw_button(short index, bool pressed);
static void handle_replay(bool last_replay);
static bool begin_game(short user, bool cheat);
static void start_game(short user, bool changing_level);
// LP: "static" removed
void handle_load_game(void);
static void handle_save_film(void);
static void finish_game(bool return_to_main_menu);
static void handle_network_game(bool gatherer);
static void next_game_screen(void);
static void handle_interface_menu_screen_click(short x, short y, bool cheatkeys_down);

static void display_introduction(void);
static void display_loading_map_error(void);
static void display_quit_screens(void);
static void	display_screen(short base_pict_id);
static void display_introduction_screen_for_demo(void);
static void display_epilogue(void);

static void force_system_colors(void);
static bool point_in_rectangle(short x, short y, screen_rectangle *rect);

static void start_interface_fade(short type, struct color_table *original_color_table);
static void update_interface_fades(void);
static void interface_fade_out(short pict_resource_number, bool fade_music);
static bool can_interface_fade_out(void);
static void transfer_to_new_level(short level_number);
static void try_and_display_chapter_screen(short level, bool interface_table_is_valid, bool text_block);

#ifdef DEBUG
static struct screen_data *get_screen_data(
	short index)
{
	assert(index>=0 && index<NUMBER_OF_SCREENS);
	return display_screens+index;
}
#else
#define get_screen_data(index) (display_screens+(index))
#endif

/* ---------------------- code begins */
void initialize_game_state(
	void)
{
	game_state.state= _display_intro_screens;
	game_state.user= _single_player;
	game_state.flags= 0;
	game_state.current_screen= 0;
	game_state.suppress_background_tasks= true;
	game_state.main_menu_display_count= 0;

	toggle_menus(false);

	display_introduction();
}

void force_game_state_change(
	void)
{
	game_state.phase= 0;

	return;
}

bool player_controlling_game(
	void)
{
	bool player_in_control= false;

	assert(game_state.state==_game_in_progress || game_state.state==_switch_demo);
	
	if(game_state.user==_single_player || game_state.user==_network_player)
	{
		player_in_control= true;
	}
	
	return player_in_control;
}

void toggle_suppression_of_background_tasks(
	void)
{
	game_state.suppress_background_tasks= !game_state.suppress_background_tasks;
}

void set_game_state(
	short new_state)
{
	short old_state= game_state.state;

	switch(old_state)
	{
		case _game_in_progress:
			switch(new_state)
			{
				case _display_epilogue:
					game_state.state= _begin_display_of_epilogue;
					game_state.phase= 0;
					break;
					
				case _close_game:
					finish_game(true);
					break;
					
				case _quit_game:
					finish_game(false);
					display_quit_screens();
					break;
					
				case _switch_demo:
					/* Because Alain's code calls us at interrupt level 1, */
					/*  we must defer processing of this message until idle */
					game_state.state= _switch_demo;
					game_state.phase= 0;
					break;
					
				case _revert_game:
					/* Because reverting a game in the middle of the update_world loop sounds */
					/*  sketchy, this is not done until idle time.. */
					game_state.state= new_state;
					game_state.phase= 0;
					break;

				case _change_level:
					game_state.state= new_state;
					game_state.phase= 0;
					break;
					
				default: 
					// LP change:
					assert(false);
					// halt();
					break;
			}
			break;

		default:
			game_state.state= new_state;
			break;
	}
}

short get_game_state(
	void)
{
	return game_state.state;
}

bool suppress_background_events(
	void)
{
	return game_state.suppress_background_tasks;
}

short get_game_controller(
	void)
{
	return game_state.user;
}

void set_change_level_destination(
	short level_number)
{
	assert(game_state.state== _change_level);
	game_state.current_screen= level_number;

	return;
}

static short get_difficulty_level(void)
{
	return player_preferences->difficulty_level;
}

extern bool load_and_start_game(FileSpecifier& File);

bool load_and_start_game(FileSpecifier& File)
{
	bool success;
	
	hide_cursor();
	if(can_interface_fade_out()) 
	{
		interface_fade_out(MAIN_MENU_BASE, true);
	}
	success= load_game_from_file(File);
	if (success)
	{
		dynamic_world->game_information.difficulty_level= get_difficulty_level();
		start_game(_single_player, false);
	} else {
		/* We failed.  Balance the cursor */
		/* Should this also force the system colors or something? */
		show_cursor();
	}
	
	return success;
}

extern bool handle_open_replay(FileSpecifier& File);

bool handle_open_replay(FileSpecifier& File)
{
	DraggedReplayFile = File;
	
	return begin_game(_replay_from_file, false);
}

// Called from within update_world..
bool check_level_change(
	void)
{
	bool level_changed= false;

	if(game_state.state==_change_level)
	{
		transfer_to_new_level(game_state.current_screen);
		level_changed= true;
	}
	
	return level_changed;
}

void pause_game(
	void)
{
	stop_fade();
	darken_world_window();
	set_keyboard_controller_status(false);
#ifdef SDL
	show_cursor();
#endif
}

void resume_game(
	void)
{
#ifdef SDL
	hide_cursor();
#endif
	validate_world_window();
	set_keyboard_controller_status(true);
}

void draw_menu_button_for_command(
	short index)
{
	short rectangle_index= index-1+_new_game_button_rect;

	assert(get_game_state()==_display_main_menu);
	
	/* Draw it initially depressed.. */
	draw_button(rectangle_index, true);
#ifdef SDL
	SDL_Delay(1000 / 12);
#else
	uint32 initial_tick= machine_tick_count();
	while(machine_tick_count()-initial_tick<5) /* 1/12 second */
		;
#endif
	draw_button(rectangle_index, false);

	return;
}

void update_interface_display(
	void)
{
	struct screen_data *data;

	data= get_screen_data(game_state.state);
	
	/* Use this to avoid the fade.. */
	draw_full_screen_pict_resource_from_images(data->screen_base+game_state.current_screen);

	return;
}

void idle_game_state(
	void)
{
	short ticks_elapsed;
	
	ticks_elapsed= (machine_tick_count() - game_state.last_ticks_on_idle)/(MACHINE_TICKS_PER_SECOND/TICKS_PER_SECOND);
	if(ticks_elapsed || game_state.phase==0)
	{
		if(game_state.phase != INDEFINATE_TIME_DELAY)
		{
			game_state.phase-= ticks_elapsed;
		}
		
		/* Note that we still go through this if we have an indefinate phase.. */
		if(game_state.phase<=0)
		{
			switch(get_game_state())
			{
				case _display_quit_screens:
				case _display_intro_screens:
				case _display_prologue:
				case _display_epilogue:
				case _display_credits:
					next_game_screen();
					break;

				case _display_intro_screens_for_demo:
				case _display_main_menu:
					/* Start the demo.. */
					if(!begin_game(_demo, false))
					{
						/* This means that there was not a valid demo to play */
						game_state.phase= TICKS_UNTIL_DEMO_STARTS;
					}
					break;

				case _close_game:
					display_main_menu();
					break;

				case _switch_demo:
					/* This is deferred to the idle task because it */
					/*  occurs at interrupt time.. */
					switch(game_state.user)
					{
						case _replay:
							finish_game(true);
							break;
							
						case _demo:
							finish_game(false);
							display_introduction_screen_for_demo();
							break;
							
						default: 
							// LP change:
							assert(false);
							// halt();
							break;
					}
					break;
				
				case _display_chapter_heading:
					dprintf("Chapter heading...");
					break;

				case _quit_game:
					/* About to quit, but can still hit this through order of ops.. */
					break;

				case _revert_game:
					/* Reverting while in the update loop sounds sketchy.. */
					if(revert_game())
					{
						game_state.state= _game_in_progress;
						game_state.phase= 15*TICKS_PER_SECOND;
						game_state.last_ticks_on_idle= machine_tick_count();
						update_interface(NONE);
					} else {
						/* Give them the error... */
						display_loading_map_error();
						
						/* And finish their current game.. */
						finish_game(true);
					}
					break;
					
				case _begin_display_of_epilogue:
					finish_game(false);
					display_epilogue();
					break;

				case _game_in_progress:
					game_state.phase= 15*TICKS_PER_SECOND;
					game_state.last_ticks_on_idle= machine_tick_count();
					break;

				case _change_level:
				case _displaying_network_game_dialogs:
					break;
					
				default:
					// LP change:
					assert(false);
					// halt();
					break;
			}
		}
		game_state.last_ticks_on_idle= machine_tick_count();
	}

	/* if we?re not paused and there?s something to draw (i.e., anything different from
		last time), render a frame */
	if(game_state.state==_game_in_progress)
	{
		if (get_keyboard_controller_status() && (ticks_elapsed= update_world())!=0)
		{
			render_screen(ticks_elapsed);
		}
	} else {
		/* Update the fade ins, etc.. */
		update_interface_fades();
	}

	return;
}

void display_main_menu(
	void)
{
	game_state.state= _display_main_menu;
	game_state.current_screen= 0;
	game_state.phase= TICKS_UNTIL_DEMO_STARTS;
	game_state.last_ticks_on_idle= machine_tick_count();
	game_state.user= _single_player;
	game_state.flags= 0;
	
	display_screen(MAIN_MENU_BASE);
	
	/* Start up the song! */
	if(!music_playing() && game_state.main_menu_display_count==0)
	{
		queue_song(_introduction_song);
	}

	game_state.main_menu_display_count++;
}

void do_menu_item_command(
	short menu_id,
	short menu_item,
	bool cheat)
{
	switch(menu_id)
	{
		case mGame:
			switch(menu_item)
			{
				case iPause:
					switch(game_state.user)
					{
						case _single_player:
						case _replay:
							if (get_keyboard_controller_status())
							{
								pause_game();
							}
							else
							{
								resume_game();
							}
							break;
						
						case _demo:
							finish_game(true);
							break;
							
						case _network_player:
							break;
							
						default:
							// LP change:
							assert(false);
							// halt();
							break;
					}
					break;

				case iSave:
					switch(game_state.user)
					{
						case _single_player:
#if 0
							save_game();
							validate_world_window();
#endif
							break;
						
						case _demo:
						case _replay:
							finish_game(true);
							break;
							
						case _network_player:
							break;
							
						default:
							// LP change:
							assert(false);
							// halt();
							break;
					}
					break;
					
				case iRevert:
					/* Not implemented.. */
					break;
					
				case iCloseGame:
				case iQuitGame:
					{
						bool really_wants_to_quit= false;
					
						switch(game_state.user)
						{
							case _single_player:
								if(PLAYER_IS_DEAD(local_player) || 
									dynamic_world->tick_count-local_player->ticks_at_last_successful_save<CLOSE_WITHOUT_WARNING_DELAY)
								{
									really_wants_to_quit= true;
								} else {
									pause_game();
									show_cursor();
									really_wants_to_quit= quit_without_saving();
									hide_cursor();
									resume_game();
								}
								break;
							
							case _demo:
							case _replay:
							case _network_player:
								really_wants_to_quit= true;
								break;
								
							default:
								// LP change:
								assert(false);
								// halt();
								break;
						}
	
						if(really_wants_to_quit)
						{
							// Rhys Hill fix for crash when quitting OpenGL
#ifdef HAVE_OPENGL
							if (!OGL_IsActive())
#endif HAVE_OPENGL
							render_screen(0); /* Get rid of hole.. */
/* If you want to quit on command-q while in the game.. */
#if 0
							if(menu_item==iQuitGame)
							{
								set_game_state(_quit_game);
							} else
#endif
							set_game_state(_close_game);
						}
					}
					break;
					
				default:
					// LP change:
					assert(false);
					// halt();
					break;
			}
			break;
			
		case mInterface:
			switch(menu_item)
			{
				case iNewGame:
					begin_game(_single_player, cheat);
					break;
		
				case iJoinGame:
#ifdef mac
					if (system_information->machine_has_network_memory)
					{
						handle_network_game(false);
					}
					else
					{
						alert_user(infoError, strERRORS, notEnoughNetworkMemory, 0);
					}
#else
					handle_network_game(false);
#endif
					break;
		
				case iGatherGame:
#ifdef mac
					if (system_information->machine_has_network_memory)
					{
						handle_network_game(true);
					}
					else
					{
						alert_user(infoError, strERRORS, notEnoughNetworkMemory, 0);
					}
#else
					handle_network_game(true);
#endif
					break;
					
				case iLoadGame:
					handle_load_game();
					break;
		
				case iReplayLastFilm:
				case iReplaySavedFilm:
					handle_replay(menu_item==iReplayLastFilm);
					break;
					
				case iCredits:
					display_credits();
					break;
					
				case iPreferences:
					do_preferences();
					game_state.phase= TICKS_UNTIL_DEMO_STARTS;
					game_state.last_ticks_on_idle= machine_tick_count();
					break;
					
				case iCenterButton:
					break;
					
				case iSaveLastFilm:
					handle_save_film();
					break;
		
				case iQuit:
					display_quit_screens();
					break;
		
				default:
					// LP change:
					assert(false);
					// halt();
					break;
			}
			break;

		default:
			// LP change:
			assert(false);
			// halt();
			break;
	}
}

void portable_process_screen_click(
	short x,
	short y,
	bool cheatkeys_down)
{
	switch(get_game_state())
	{
		case _game_in_progress:
		case _begin_display_of_epilogue:
		case _change_level:
		case _displaying_network_game_dialogs:
			break;

		case _display_intro_screens_for_demo:
			/* Get out of user mode. */
			display_main_menu();
			break;
			
		case _display_quit_screens:
		case _display_intro_screens:
		case _display_chapter_heading:
		case _display_prologue:
		case _display_epilogue:
		case _display_credits:
			/* Force the state change next time through.. */
			force_game_state_change();
			break;
			
		case _quit_game:
		case _close_game:
		case _switch_demo:	
			break;
	
		case _display_main_menu:
			handle_interface_menu_screen_click(x, y, cheatkeys_down);
			break;
		
		default:
			// LP change:
			assert(false);
			// halt();
			break;
	}

	return;
}

bool enabled_item(
	short item)
{
	bool enabled= true;

	switch(item)
	{
		case iNewGame:
		case iLoadGame:
		case iPreferences:
		case iReplaySavedFilm:
		case iCredits:
		case iQuit:
			break;

		case iCenterButton:
			enabled= false;
			break;
			
		case iReplayLastFilm:
		case iSaveLastFilm:
			enabled= has_recording_file();
			break;

		case iGatherGame:
		case iJoinGame:
			enabled= networking_available();
			break;
			
		default:
			// LP change:
			assert(false);
			// halt();
			break;
	}
	
	return enabled;
}

void paint_window_black(
	void)
{
	_set_port_to_screen_window();
	_erase_screen(_black_color);
	_restore_port();

	return;
}

/* --------------------- static code */

static void display_introduction(
	void)
{
	struct screen_data *screen_data= get_screen_data(_display_intro_screens);

	paint_window_black();
	game_state.state= _display_intro_screens;
	game_state.current_screen= 0;
	if (screen_data->screen_count)
	{
		if (game_state.state==_display_intro_screens && game_state.current_screen==INTRO_SCREEN_TO_START_SONG_ON)
		{
			queue_song(_introduction_song);
		}

		game_state.phase= screen_data->duration;
		game_state.last_ticks_on_idle= machine_tick_count();
		display_screen(screen_data->screen_base);
	}
	else
	{
		display_main_menu();
	}
}

static void display_introduction_screen_for_demo(	
	void)
{
	struct screen_data *screen_data= get_screen_data(_display_intro_screens_for_demo);

	game_state.state= _display_intro_screens_for_demo;
	game_state.current_screen= 0;
	if(screen_data->screen_count)
	{
		game_state.phase= screen_data->duration;
		game_state.last_ticks_on_idle= machine_tick_count();
		display_screen(screen_data->screen_base);
	} else {
		display_main_menu();
	}
}

static void display_epilogue(
	void)
{
	queue_song(_introduction_song); // _epilogue_song
	
	{
		long ticks= machine_tick_count();
		
		do
		{
			music_idle_proc();
		}
		while (machine_tick_count()-ticks<10);
	}

	game_state.state= _display_epilogue;
	game_state.phase= 0;
	game_state.current_screen= 0;
	game_state.last_ticks_on_idle= machine_tick_count();
	
	hide_cursor();	
	try_and_display_chapter_screen(CHAPTER_SCREEN_BASE+99, true, true);
	show_cursor();
	
	return;
}

static void display_credits(
	void)
{
	if (NUMBER_OF_CREDIT_SCREENS)
	{
		struct screen_data *screen_data= get_screen_data(_display_credits);
		
		game_state.state= _display_credits;
		game_state.current_screen= 0;
		game_state.user= _single_player;
		game_state.flags= 0;

		game_state.phase= screen_data->duration;
		game_state.last_ticks_on_idle= machine_tick_count();
		display_screen(screen_data->screen_base);
	}
}

static void display_quit_screens(
	void)
{
	struct screen_data *screen_data= get_screen_data(_display_quit_screens);

	if(screen_data->screen_count)
	{
		game_state.state= _display_quit_screens;
		game_state.current_screen= 0;
		game_state.user= _single_player;
		game_state.flags= 0;
		game_state.phase= screen_data->duration;
		game_state.last_ticks_on_idle= machine_tick_count();
		
		display_screen(screen_data->screen_base);
	} else {
		/* No screens. */
		game_state.state= _quit_game;
		game_state.phase= 0;
	}
}

static void transfer_to_new_level(
	short level_number)
{
	struct entry_point entry;
	bool success= true;
	
	entry.level_number= level_number;

	/* Only can transfer if NetUnSync returns true */
	if(game_is_networked) 
	{
		if(NetUnSync()) 
		{
			success= true;
		} else {
			set_game_error(gameError, errUnsyncOnLevelChange);
			success= false;
		}
	}

	if(success)
	{
		set_keyboard_controller_status(false);
		if (!game_is_networked) try_and_display_chapter_screen(CHAPTER_SCREEN_BASE + level_number, true, false);
		success= goto_level(&entry, false);
		set_keyboard_controller_status(true);
	}
	
	if(success)
	{
		start_game(game_state.user, true);
	} else {
		display_loading_map_error();
		finish_game(true);
	}
	
	return;
}

/* The port is set.. */
static void draw_button(
	short index, 
	bool pressed)
{
	screen_rectangle *screen_rect= get_interface_rectangle(index);
	short pict_resource_number= MAIN_MENU_BASE + pressed;

	set_drawing_clip_rectangle(screen_rect->top, screen_rect->left, screen_rect->bottom,
		screen_rect->right);
	
	/* Use this to avoid the fade.. */
	draw_full_screen_pict_resource_from_images(pict_resource_number);

	set_drawing_clip_rectangle(SHRT_MIN, SHRT_MIN, SHRT_MAX, SHRT_MAX);

	return;
}
					
static void handle_replay( /* This is gross. */
	bool last_replay)
{
	bool success;
	
	if(!last_replay) force_system_colors();
	success= begin_game(_replay, !last_replay);
	if(!success) display_main_menu();
}

static bool begin_game(
	short user,
	bool cheat)
{
	short player_index;
	struct entry_point entry;
	struct player_start_data starts[MAXIMUM_NUMBER_OF_PLAYERS];
	struct game_data game_information;
	short number_of_players;
	bool success= true;
	bool is_networked= false;
	bool clean_up_on_failure= true;
	bool record_game= false;

	objlist_clear(starts, MAXIMUM_NUMBER_OF_PLAYERS);
	
	switch(user)
	{
		case _network_player:
			{
				game_info *network_game_info= (game_info *)NetGetGameData();
				number_of_players= NetGetNumberOfPlayers();

				for(player_index= 0; player_index<number_of_players; ++player_index)
				{
					player_info *player_information = (player_info *)NetGetPlayerData(player_index);
					starts[player_index].team = player_information->team;
					starts[player_index].color= player_information->color;
					starts[player_index].identifier = NetGetPlayerIdentifier(player_index);

					/* Copy and translate from pascal string to cstring */
					memcpy(starts[player_index].name, &player_information->name[1],
						player_information->name[0]);
					starts[player_index].name[player_information->name[0]]= 0;
				}

				game_information.game_time_remaining= network_game_info->time_limit;
				game_information.kill_limit= network_game_info->kill_limit;
				game_information.game_type= network_game_info->net_game_type;
				game_information.game_options= network_game_info->game_options;
				game_information.initial_random_seed= network_game_info->initial_random_seed;
				game_information.difficulty_level= network_game_info->difficulty_level;
				entry.level_number = network_game_info->level_number;
				entry.level_name[0] = 0;
	
				if (network_game_info->allow_mic)
				{
						
					install_network_microphone();
					game_state.current_netgame_allows_microphone= true;
				} else {
					game_state.current_netgame_allows_microphone= false;
				}

				is_networked= true;
				record_game= true;
			}
			break;

		case _replay_from_file:
		case _replay:
		case _demo:
			switch(user)
			{
				case _replay:
					{
						FileSpecifier ReplayFile;

						success= find_replay_to_use(cheat, ReplayFile);
						if(success)
						{
							success= setup_for_replay_from_file(ReplayFile, get_current_map_checksum());
						}
					} 
					break;
					
				case _demo:
					success= setup_replay_from_random_resource(get_current_map_checksum());
					break;

				case _replay_from_file:
					success= setup_for_replay_from_file(DraggedReplayFile, get_current_map_checksum());
					user= _replay;
					break;
					
				default:
					// LP change:
					assert(false);
					// halt();
					break;
			}
			
			if(success)
			{
				unsigned long unused1;
				short unused2;
			
				get_recording_header_data(&number_of_players, 
					&entry.level_number, &unused1, &unused2,
					starts, &game_information);

				entry.level_name[0] = 0;
//				header.game_information.game_options |= _overhead_map_is_omniscient;
				record_game= false;
			}
			break;
			
		case _single_player:
			if(cheat)
			{
				entry.level_number= get_level_number_from_user();
				if(entry.level_number==NONE) success= false; /* Cancelled */
			} else {
				entry.level_number= 0;
			}
	
			entry.level_name[0] = starts[0].identifier = 0;
			// LP change:
			// use player color in Preferences for single-player game
			starts[0].team = starts[0].color = player_preferences->color;
			// starts[0].team = starts[0].color = _red_team;
			strcpy(starts[0].name, "");
			game_information.game_time_remaining= LONG_MAX;
			game_information.kill_limit = 0;
			game_information.game_type= _game_of_kill_monsters;
			game_information.game_options= _burn_items_on_death|_ammo_replenishes|_weapons_replenish|_monsters_replenish;
			game_information.initial_random_seed= machine_tick_count();
			game_information.difficulty_level= get_difficulty_level();
			number_of_players= 1;
			record_game= true;
			break;
			
		default:
			// LP change:
			assert(false);
			// halt();
			break;
	}

	if(success)
	{
		if(record_game)
		{
			set_recording_header_data(number_of_players, entry.level_number, get_current_map_checksum(), 
				RECORDING_VERSION, starts, &game_information);
			start_recording();
		}
		
		hide_cursor();
		/* This has already been done to get to gather/join */
		if(can_interface_fade_out()) 
		{
			interface_fade_out(MAIN_MENU_BASE, true);
		}

		/* Try to display the first chapter screen.. */
		if (user != _network_player && user != _demo)
		{
			show_movie(entry.level_number);
			try_and_display_chapter_screen(CHAPTER_SCREEN_BASE + entry.level_number, false, false);
		}

		/* Begin the game! */
		success= new_game(number_of_players, is_networked, &game_information, starts, &entry);
		if(success)
		{
			start_game(user, false);
		} else {
			/* Stop recording.. */
			if(record_game)
			{
				stop_recording();
			}

			/* Show the cursor here on failure. */
			show_cursor();
		
			/* The only time we don't clean up is on the replays.. */
			if(clean_up_on_failure)
			{
				if (user==_network_player)
				{
					if(game_state.current_netgame_allows_microphone)
					{
						remove_network_microphone();
					}
					exit_networking();
				} else {
/* NOTE: The network code is now responsible for displaying its own errors!!!! */
					/* Give them the error... */
					display_loading_map_error();
				}

				/* Display the main menu on failure.... */
				display_main_menu();
			}
			set_game_error(systemError, errNone);
		}
	} else {
		/* This means that some weird replay problem happened: */
		/*  1) User cancelled */
		/*  2) Demos not present */
		/*  3) Error... */
		/* Either way, we eat them.. */
	}
	
	return success;
}

static void start_game(
	short user,
	bool changing_level)
{
	/* Change our menus.. */
	toggle_menus(true);
	
	// LP change: reset screen so that extravision will not be persistent
	if (!changing_level) reset_screen();

	enter_screen();

	// Screen should already be black! 
	validate_world_window();
	
	draw_interface();

#ifdef PERFORMANCE	
	PerfControl(perf_globals, true);
#endif

	game_state.state= _game_in_progress;
	game_state.current_screen= 0;
	game_state.phase= TICKS_PER_SECOND;
	game_state.last_ticks_on_idle= machine_tick_count();
	game_state.user= user;
	game_state.flags= 0;

	assert((!changing_level&&!get_keyboard_controller_status()) || (changing_level && get_keyboard_controller_status()));
	if(!changing_level)
	{
		set_keyboard_controller_status(true);
	} 
}

// LP: "static" removed
void handle_load_game(
	void)
{
	FileSpecifier FileToLoad;
	bool success= false;

	force_system_colors();
	if(choose_saved_game_to_load(FileToLoad))
	{
		if(!load_and_start_game(FileToLoad))
		{
			/* Reset the system colors, since the screen clut is all black.. */
			force_system_colors();
			display_loading_map_error();
		} else {
			success= true;
		}
	}

	if(!success) display_main_menu();
}

static void finish_game(
	bool return_to_main_menu)
{
	set_keyboard_controller_status(false);

#ifdef PERFORMANCE	
	PerfControl(perf_globals, false);
#endif
	/* Note that we have to deal with the switch demo state later because */
	/* Alain's code calls us at interrupt level 1. (so we defer it) */
	assert(game_state.state==_game_in_progress || game_state.state==_switch_demo || game_state.state==_revert_game || game_state.state==_change_level || game_state.state==_begin_display_of_epilogue);
	toggle_menus(false);

	set_fade_effect(NONE);
	exit_screen();

	/* Stop the replay */
	switch(game_state.user)
	{
		case _single_player:
		case _network_player:
			stop_recording();
			break;
			
		case _demo:
		case _replay:
			stop_replay();
			break;

		default:
			vhalt(csprintf(temporary, "What is user %d?", game_state.user));
			break;
	}

	/* Fade out! (Pray) */ // should be interface_color_table for valkyrie, but doesn't work.
	full_fade(_cinematic_fade_out, interface_color_table);
	paint_window_black();
	full_fade(_end_cinematic_fade_out, interface_color_table);

	show_cursor();

	leaving_map();

	/* Get as much memory back as we can. */
	free_and_unlock_memory(); // this could call free_map.. 
	unload_all_collections();
	unload_all_sounds();
	
	if (game_state.user==_network_player)
	{
		if(game_state.current_netgame_allows_microphone)
		{
			remove_network_microphone();
		}
		NetUnSync(); // gracefully exit from the game

		/* Don't update the screen, etc.. */
		game_state.state= _displaying_network_game_dialogs;

		force_system_colors();
		display_net_game_stats();
		exit_networking();
	}
	
	if(return_to_main_menu) display_main_menu();
}

static void handle_network_game(
	bool gatherer)
{
#ifdef mac
	bool successful_gather;
	
	force_system_colors();

	/* Don't update the screen, etc.. */
	game_state.state= _displaying_network_game_dialogs;
	if(gatherer)
	{
		successful_gather= network_gather();
	} else {
		successful_gather= network_join();
	}
	
	if (successful_gather)
	{
		begin_game(_network_player, false);
	} else {
		/* We must restore the colors on cancel. */
		display_main_menu();
	}
#else
	alert_user(infoError, strERRORS, networkNotSupportedForDemo, 0);
#endif
}

static void handle_save_film(
	void)
{
	force_system_colors();
	move_replay();
	display_main_menu();

	return;
}

static void next_game_screen(
	void)
{
	struct screen_data *data= get_screen_data(game_state.state);

	stop_interface_fade();
	if(++game_state.current_screen>=data->screen_count)
	{
		switch(game_state.state)
		{
			case _display_main_menu:
				/* Whoops.  didn't get it. */
				alert_user(fatalError, strERRORS, outOfMemory, 0);
				break;
				
			case _display_quit_screens:
				/* Fade out.. */
				interface_fade_out(data->screen_base+game_state.current_screen, true);
				game_state.state= _quit_game;
				break;
				
			default:
				display_main_menu();
				break;
		}
	} else {
		if(game_state.state==_display_intro_screens && 
			game_state.current_screen==INTRO_SCREEN_TO_START_SONG_ON)
		{
			queue_song(_introduction_song);
		}
		// LP addition: check to see if a picture exists before drawing it.
		// Otherwise, set the countdown value to zero.
		short pict_resource_number= data->screen_base+game_state.current_screen;
		if (images_picture_exists(pict_resource_number))
		{
			game_state.phase= data->duration;
			game_state.last_ticks_on_idle= machine_tick_count();
			display_screen(data->screen_base);
		}
		else
		{
			game_state.phase= 0;
			game_state.last_ticks_on_idle= machine_tick_count();
		}
	}
}

static void display_loading_map_error(	
	void)
{
	short error, type;

	/* Give them the error... */
	error= get_game_error(&type);
	if(type==gameError)
	{
		short string_id;
		
		switch(error)
		{
			case errServerDied:
				string_id= serverQuitInCooperativeNetGame;
				break;
			case errUnsyncOnLevelChange:
				string_id= unableToGracefullyChangeLevelsNet;
				break;
			
			case errMapFileNotSet:
			case errIndexOutOfRange:
			case errTooManyOpenFiles:
			case errUnknownWadVersion:
			case errWadIndexOutOfRange:
			default:
				string_id= badReadMapGameError;
				break;
		}
		alert_user(infoError, strERRORS, string_id, error);
	} else {
		alert_user(infoError, strERRORS, badReadMapSystemError, error);
	}
	set_game_error(systemError, errNone);
}

static void force_system_colors(
	void)
{
	if(can_interface_fade_out())
	{
		interface_fade_out(MAIN_MENU_BASE, true);
	}

	if(interface_bit_depth==8)
	{
		struct color_table *system_colors= build_8bit_system_color_table();

		assert_world_color_table(system_colors, (struct color_table *) NULL);

		delete system_colors;
	}
}

static void display_screen(
	short base_pict_id)
{
	short pict_resource_number= base_pict_id+game_state.current_screen;
	static bool picture_drawn= false;
	
	if (images_picture_exists(pict_resource_number))
	{
		stop_interface_fade();

		if(current_picture_clut)
		{
			interface_fade_out(pict_resource_number, false);
		}

		assert(!current_picture_clut);
		current_picture_clut= calculate_picture_clut(CLUTSource_Images,pict_resource_number);
		current_picture_clut_depth= interface_bit_depth;

		if(current_picture_clut)
		{
			/* slam the entire clut to black, now. */
			if (interface_bit_depth==8) 
			{
				assert_world_color_table(current_picture_clut, (struct color_table *) NULL);
			}

			full_fade(_start_cinematic_fade_in, current_picture_clut);

			draw_full_screen_pict_resource_from_images(pict_resource_number);
			picture_drawn= true;

			assert(current_picture_clut);	
			start_interface_fade(_long_cinematic_fade_in, current_picture_clut);
		}
	}
	
	if(!picture_drawn)
	{
dprintf("Didn't draw: %d;g", pict_resource_number);
		/* Go for the next one.. */
		next_game_screen();
	}
	
	return;
}

static bool point_in_rectangle(
	short x,
	short y,
	screen_rectangle *rect)
{
	bool in_rectangle= false;

	if(x>=rect->left && x<rect->right && y>=rect->top && y<rect->bottom)
	{
		in_rectangle= true;
	}

	return in_rectangle;
}

static void handle_interface_menu_screen_click(
	short x,
	short y,
	bool cheatkeys_down)
{
	short index;
	screen_rectangle *screen_rect;

	/* find it.. */
	for(index= _new_game_button_rect; index<NUMBER_OF_INTERFACE_RECTANGLES; ++index)
	{
		screen_rect= get_interface_rectangle(index);
		if(point_in_rectangle(x, y, screen_rect))
		{
			break;
		}
	}
	
	/* we found one.. */
	if(index!=NUMBER_OF_INTERFACE_RECTANGLES)
	{
		if(enabled_item(index-_new_game_button_rect+1))
		{
			bool last_state= true;

			stop_interface_fade();

			screen_rect= get_interface_rectangle(index);

			/* Draw it initially depressed.. */
			draw_button(index, last_state);
		
			while(mouse_still_down())
			{
				bool state;
				
				get_mouse_position(&x, &y);
				state= point_in_rectangle(x, y, screen_rect);
				
				if(state != last_state)
				{
					draw_button(index, state);
					last_state= state;
				}
			}

			/* Draw it unpressed.. */
			draw_button(index, false);
			
			if(last_state)
			{
				do_menu_item_command(mInterface, index-_new_game_button_rect+1, cheatkeys_down);
			}	
		}
	}

	return;
}

/* Note that this is modal. This sucks... */
static void try_and_display_chapter_screen(
	short pict_resource_number,
	bool interface_table_is_valid,
	bool text_block)
{
	/* If the picture exists... */
	if (scenario_picture_exists(pict_resource_number))
	{
		free_and_unlock_memory();
		
		/* This will NOT work if the initial level entered has a chapter screen, which is why */
		/*  we perform this check. (The interface_color_table is not valid...) */
		if(interface_table_is_valid)
		{
			full_fade(_cinematic_fade_out, interface_color_table);
			paint_window_black();
		}

		/* Fade the screen to black.. */
		assert(!current_picture_clut);
		current_picture_clut= calculate_picture_clut(CLUTSource_Scenario,pict_resource_number);
		current_picture_clut_depth= interface_bit_depth;
		
		if (current_picture_clut)
		{
			LoadedResource SoundRsrc;
#if defined(mac)
			SndChannelPtr channel= NULL;
			SndListHandle sound= NULL;
#endif

			/* slam the entire clut to black, now. */
			if (interface_bit_depth==8) 
			{
				assert_world_color_table(current_picture_clut, (struct color_table *) NULL);
			}
			full_fade(_start_cinematic_fade_in, current_picture_clut);

			/* Draw the picture */
			draw_full_screen_pict_resource_from_scenario(pict_resource_number);

			if (get_sound_resource_from_scenario(pict_resource_number,SoundRsrc))
			{
#if defined(mac)
				sound = SndListHandle(SoundRsrc.GetHandle());
				
				OSErr sound_error= SndNewChannel(&channel, 0, 0, (SndCallBackUPP) NULL);
					
				if (sound_error==noErr)
				{
					HLockHi((Handle)sound);
					SndPlay(channel, sound, true);
				}
#elif defined(SDL)
				play_sound_resource(SoundRsrc);
#endif
			}
			
			/* Fade in.... */
			assert(current_picture_clut);	
			full_fade(_long_cinematic_fade_in, current_picture_clut);
			
			scroll_full_screen_pict_resource_from_scenario(pict_resource_number, text_block);

			wait_for_click_or_keypress(text_block ? -1 : 10*MACHINE_TICKS_PER_SECOND);
			
			/* Fade out! (Pray) */
			interface_fade_out(pict_resource_number, false);
			
#if defined(mac)
			if (channel)
				SndDisposeChannel(channel, true);
#elif defined(SDL)
			stop_sound_resource();
#endif
		}
	}

	return;
}

/* ------------ interface fade code */
/* Be aware that we could try to change bit depths before a fade is completed. */
static void start_interface_fade(
	short type,
	struct color_table *original_color_table)
{
	hide_cursor();
	assert(!interface_fade_in_progress);
	animated_color_table= new color_table;
	obj_copy(*animated_color_table, *original_color_table);

	if(animated_color_table)
	{
		interface_fade_in_progress= true;
		interface_fade_type= type;

		explicit_start_fade(type, original_color_table, animated_color_table);
	}
}

static void update_interface_fades(
	void)
{
	bool still_fading= false;
	
	if(interface_fade_in_progress)
	{
		still_fading= update_fades();
		if(!still_fading)
		{
			stop_interface_fade();
		}
	}
	
	return;
}

void stop_interface_fade(
	void)
{
	if(interface_fade_in_progress)
	{
		stop_fade();
		interface_fade_in_progress= false;
		
		assert(animated_color_table);
		delete animated_color_table;

		if (interface_bit_depth==8) 
		{
			assert_world_color_table(current_picture_clut, (struct color_table *) NULL);
		}

		if(game_state.state==_display_main_menu)
		{
			/* This isn't a showcursor because of balancing problems (first time through..) */
			show_cursor();
		}
	}
}

/* Called right before we start a game.. */
void interface_fade_out(
	short pict_resource_number,
	bool fade_music)
{
	assert(current_picture_clut);
	if(current_picture_clut)
	{
		struct color_table *fadeout_animated_color_table;

		/* We have to check this because they could go into preferences and change on us, */
		/*  the evil swine. */
		if(current_picture_clut_depth != interface_bit_depth)
		{
			delete current_picture_clut;
			current_picture_clut= calculate_picture_clut(CLUTSource_Images,pict_resource_number);
			current_picture_clut_depth= interface_bit_depth;
		}
		
		hide_cursor();
			
		fadeout_animated_color_table= new color_table;
		obj_copy(*fadeout_animated_color_table, *current_picture_clut);

		if(fade_music) fade_out_music(MACHINE_TICKS_PER_SECOND/2);
		if (fadeout_animated_color_table)
		{
			explicit_start_fade(_cinematic_fade_out, current_picture_clut, fadeout_animated_color_table);
			while (update_fades()) music_idle_proc();

			/* Oops.  Founda  memory leak.. */
			delete fadeout_animated_color_table;
		}
		
		if(fade_music) 
		{
			while(music_playing()) music_idle_proc();

			/* and give up the memory */
			free_music_channel();
		}

		paint_window_black();
		full_fade(_end_cinematic_fade_out, current_picture_clut);

		/* Hopefully we can do this here.. */
		delete current_picture_clut;
		current_picture_clut= NULL;
	}

	return;
}

static bool can_interface_fade_out(
	void)
{
	return (current_picture_clut==NULL) ? false : true;
}

bool interface_fade_finished(
	void)
{
	return fade_finished();
}
