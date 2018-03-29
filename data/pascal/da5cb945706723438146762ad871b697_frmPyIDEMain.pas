{-----------------------------------------------------------------------------
 Unit Name: frmPyIDEMain
 Author:    Kiriakos Vlahos
 Date:      11-Feb-2005
 Purpose:   The main form of the Pytnon IDE
            Draws code from the SynEdit demos

            PyScripter was not designed to compete with other Python IDE tools
            but rather to serve the purpose of providing a strong scripting
            solution for Delphi Applications.  However it is a reasonably
            good stand-alone Python IDE.

 Features:  - Easy Integration with Delphi applications
            - Syntax Highlighting
            - Brace Highlighting
            - Python source code utilities ((un)tabify, (un)comment, (un)indent)
            - Code Explorer
            - File Explorer with filter
            - Easy configuration and browsing of the Python Path
            - Access to Python manuals through the Help menu
              and context sensitive help (press F1 on a Python keyword
              inside the editor)
            - Integrated Python Interpreter
              - Command History
                    - Alt-UP : previous command
                    - Alt-Down : next command
                    - Esc : clear command
              - Code Completion
              - Call Tips
            - Integrated Python Debugging
            - Debug Windows
              - Call Stack
              - Variables Window
              - Watches Window
              - BreakPoints Window
            - Editor Views
              - Disassembly
              - HTML Documentation
            - TODO list view
            - Find and Replace in Files
            - Parameterized Code Templates
            - Choice of Python version to run via command line parameters
            - Run Python Script externally (highly configurable)
            - External Tools (External run and caputure output)
            - Modern UI with docked forms and configurable look&feel (themes)
            - Persistent configurable IDE options

Limitations: Python scripts are executed in the main thread
             so it would be unwise to run multi-threaded
             scripts.  This is due to the fact that scripts
             may use wrapped Delphi objects which are not-
             thread safe.

 Credits:   Special thanks to the many great developers who,
            with their amazing work have made PyScripter
            possible.  PyScript makes use of the following
            components:
            - Python for Delphi (www.mmm-experts.com)
            - JVCL (jvcl.sf.net)
            - SynEdit (synedit.sf.net)
            - VirtualTreeView (www.delphi-gems.com)
            - VirtualShellTools (www.mustangpeak.net)
            - EC Software Help Suite (www.ec-software.com)
            - Syn Editor project (syn.sf.net)

 History:   v 1.1
            Improved Python Syntax highlighting
            HTML documentation and disassembly views (Tools, Source Views menu)
            TODO list view
            Find and Replace in Files
            Powerful parameter functionality (see parameters.txt)
            Parameterized Code Templates (Ctrl-J)
            Accept files dropped from Explorer
            File change notification
            sys.stdin and raw_input implemented
            Choice of Python version to run via command line parameters
            External Tools (External run and caputure output)
            Integration with Python tools such as PyLint
            Run Python Script externally (highly configurable)
            Persist and optionally reopen open files
            Bug fixes
 History:   v 1.2
            Updated the User Interface using Themes
            Messages History
            Previous/Next identifier reference (as in GExperts)
            Find Definition/Find references using BicycleRepairMan
            Find definition by clicking as in Delphi
            Reduced flicker on start and exit and somewhat on resizing**
            Converting line breaks (Windows, Unix, Mac)
            Detecting loading/saving UTF-8 encoded files
            Help file and context sensitive Help
            Check for updates

 History:   v 1.3
            Code completion in the editor (Press Ctrl+Space while or before typing a name)
            Parameter completion in the editor (Press Shift+Ctrl+Space)
            Find definition and find references independent of
              BicycleRepairMan and arguably faster and better
            Find definition by clicking works for imported modules and names
            Revamped Code Explorer Window featuring incremental search, properties,
              global variables, docstrings in hints etc.
            A new feature-rich Python code parser was developed for implementing the above
            Improved the Variable Windows
              shows interpreter globals when not debugging and Doc strings
            Improved code and parameter completion in the interactive interpreter
            Integrated regular expression tester
            Code and debugger hints
            Set the current directory to the path of the running script
            Added IDE option MaskFUPExceptions for resolving problems in importing Scipy
            Tested with FastMM4 for memory leaks etc. and fixed a couple of related bugs

            Note on Code and Parameter completion:
              The code and parameter completion should be one of the best you can
              find in any Python IDE.  However,if you find that code and parameter
              completion is not very accurate for certain modules and packages
              such as wxPython and scipy you can achieve near perfect completion
              if you add these packages to the IDE option "Special Packages"
              (comma separated text). By default it is set to "wx, scipy". Special
              packages are imported to the interpreter instead of scanning their
              source code.

 History:   v 1.5
          New Features
            Unit test integration (Automatic generation of tests, and testing GUI)
            Added highlighting of HTML, XML and CSS files
            Command line parameters for scripts run internally or debugged
            Conditional breakpoints
            Persistence of breakpoints, watches, bookmarks and file positions
            Save and restore IDE windows layouts
            Generate stack information when untrapped exceptions occur and give
              users the option to mail the generated report
            Running scripts does not polute the namespace of PyScripter
            Names in variables window are now sorted
            Allow only a single Instance of Pyscripter and open command line
              files of additional invocations at new tabs
            Interpreter window is now searchable
            Added option to File Explorer to browse the directory of the Active script
            New distinctive application icon thanks to Frank Mersmann and Tobias Hartwich
            IDE shortcut customization
            File Explorer autorefreshes
            Improved bracket highlighting
            Copy to Clipboard Breakpoins, Watches and Messages
            User customization (PyScripter.ini) is now stored in the user's
              Application Data direcrory to support network installations(breaking change)
              To restore old settings copy the ini file to the new location.
            Bug fixes
              Resolved problems with dropping files from File Explorer
              Restore open files options not taken into account
              Resolved problems with long Environment variables in Tools Configure
              Resolved problems with help files
              Reduced problems with running wxPython scripts
              Changing the Python Open dialog filter did not affect syntax highlighting
              CodeExplorer slow when InitiallyExpanded is set
              Help related issues
              Other fixes.

 History:   v 1.7.1
          New Features
            Unicode based editor and interactive interpreter
            Full support for Python source file encodings
            Support for Python v2.5 and Current User installations
            Check syntax as you type and syntax hints (IDE option)
            Tab indents and Shift-Tab unindents (Editor Options - Tab Indents)
            Editor Zoom in/out with keyboard Alt+- and Ctrl+mouse wheel
            Improved Debugger hints and completion in the interpreter
               work with expressions e.g. sys.path[1].
               for debugger expression hints place the cursor on ')' or ']'
            Improved activation of code/debugger hints
            IDE options to Clean up Interpreter namespace and sys.modules after run
            File Open can open multiple files
            Syntax highlighting scheme selection from the menu
            File filters for HTML, XML and CSS files can be customized
            Option to disable gutter Gradient (Editor Options - Gutter Gradient)
            Option to disable theming of text selection (Editor Options - theme selection)
            Option to hide the executable line marks.
            Active Line Color Editor option added.  Set to None to use default background
            Files submenu in Tabs popup for easy open file selection
            Add Watch at Cursor added to the Run menu and the Waches Window popup menu
            Pop up menu added to the External Process indicator to allow easy termination of such processes
            If the PyScripter.ini file exists in PyScripter directory it is used in preference to the User Directory
              in order to allow USB storage installations
            Editor options for each open file are persisted
            Improved speed of painting the Interpreter window
            Auto close brackets
            Interactive Interpreter Pop up menu with separately persisted Editor Options
            Toggle comment (Ctrl+^) in addition to comment/uncomment
            File Explorer improvements (Favourites, Create New Folder)
            File Templates
            Windows Explorer file association (installation and IDE option)
            Command line history
            Color coding of new and changed variables in the Variables Window
            Repeat scrolling of editor tabs
            Massively improved start up time
            Faster Python source file scanning
          Bug fixes
            Gutter glyphs painted when gutter is invisible
            Bracket highlighting related bugs
            Selecting whole lines by dragging mouse in the gutter sets breakpoint
            Speed improvements and bugfixes related to layouts
            Error in Variable Windows when showing dictionaries with non string keys
            File notification error for Novell network disks
            Wrong line number in External Run traceback message
            No horizontal scroll in output window
            Code completion Error with packages containing module with the same name
            Problems with sys.stdin.readline() and partial line output (stdout) statements
            Infinite loop when root of package is the top directory of a drive
            Infinite loop with cyclical Python imports

 History:   v 1.7.2
          New Features
            Store toolbar positions
            Improved bracket completion now also works with strings (Issue #4)
          Bug fixes
            Bracket highlighting with non default background
            Opening wrongly encoded UTF8 files results in empty module
            File Format (Line End) choice not respected
            Initial Empty module was not syntax highlighted
            Save As dialog had no default extension set
            Unit Testing broken (regression)
            Gap in the default tool bar (Issue #3)

 History:   v 1.8.6
          New Features
            Remote interpreter and debugger
            New debugger command: Pause
            Execute selection command added (Ctrl-F7)
            Interpreter command history improvements:
              - Delete duplicates
              - Filter history by typing the first few command characters
              - Up|Down keys at the prompt recall commands from history
            Code Explorer shows imported names for (from ... import) syntax (Issue 12)
            Improved sort order in code completion
            Save modified files dialog on exit
            Finer control on whether the UTF-8 BOM is written
              - Three file encodings supported (Ansi, UTF-8, UTF-8 without BOM)
            IDE option to detect UTF-8 encoding (useful for non-Python files)
            IDE options for default linebreaks and encoding for new files
            Warning when file encoding results in information loss
            IDE option to position the editor tabs at the top
            IDE window navigation shortcuts
            Pretty print intperpreter output option (on by default)
            Pyscripter is now Vista ready
            Docking window improvements
            PYTHONDLLPATH command line option so that Pyscripter can work with unregistered Python
            Watches Window: DblClick on empty space adds a watch, pressing Delete deletes (Issue 45)
            Wrapping in Search & Replace (Issue 38)
            New IDE Option "Save Environment Before Run"  (Issue 50)
            New IDE command Restore Editor pair to Maximize Editor (both work by double clicking  the Tabbar)
            New IDE Option "Smart Next Previous Tab" (z-Order) on by default (Issue 20)
            Word Wrap option exposed in Editor Options
            New File Reload command
            Import/Export Settings (Shortcuts, Highlighter schemes)
            New IDE option "Auto-reload changed files" on by default (Issue 25)
            New menu command to show/hide the menu bar.  The shortcut is Shift-F10 (Issue 63)
            New command line option --DPIAWARE (-D) to avoid scaling in VISTA high DPI displays (Issue 77)
            New command line option --NEWINSTANCE (-N) to start a new instance of PyScripter
            You can disable a breakpoint by Ctrl+Clicking in the gutter
          Bug fixes
            Shell Integration - Error when opening multiple files
            Configure External Run - ParseTraceback not saved properly
            Order of tabs not preserved in minimised docked forms
            sys.argv contained unicode strings instead of ansi strings
            Bug fixes and improvements in Editor Options Keystrokes tab (Issue 6)
            Better error handling of File Open and File Save
            Page Setup Header and Footer not saved  (Issue 7)
            Hidden Tabbed windows reappearing when restarting
            Duplicate two-key editor command not detected
            "Clean up namespace" and "Clean up sys modules" settings
              become effective after restarting PyScripter
            Exception when setting the Active Line Color in Editor Options dialog
            Raw_input does not accept unicode strings
            Error in docstring extraction (Issue 11)
            Fixed some problems with the toggle comment command
            Fixed rare bug in restoring layout
            Code tips wrong if comments are present among parameters (Issue 15)
            Notification of file changes can miss files (Issue 17)
            Certain syntax coloring options were not saved
            ToDo List did not support encoded files and unicode
            ToDo List did not support multiline comments (Issue 14)
            Fixed bug in IDE Shortcuts dialog
            Swapped the positions of the indent/dedent buttons (Issue 23)
            Syntax highlighter changes to the interpreter are not persisted
            Multiple target assignments are now parsed correctly
            Gutter gradient setting not saved
            Handling of string exceptions
            Disabling a breakpoint had no effect
            Issues 28, 39, 41, 46, 47, 48, 49, 52, 57, 65, 66, 71, 72, 74, 75, 76, 81 fixed

  Vista Compatibility issues (all resolved)
  -  Flip3D and Form preview (solved with LX)
  -  Dissapearring controls (solved with SpTXPLib)
  -  Dragging forms rectagle
  -  Flicker related to LockWindowsUpdate in loading layouts
  -  Common AVI not available
  -  Fonts
  -  VISTA compatible manifest

-----------------------------------------------------------------------------}
// DONE: bug in middle click
// DONE: Next/Previous Tab corrected
// DONE: Parameter completion performance issue
// TODO: GeneratorExit bug

// TODO: Merge find dialogs

// TODO: Post mortem debugging
// TODO: Customize Pyscripter with Setup python script run at startup

// TODO: Project Manager
// Bugs and minor features
// TODO: Internal Tool as in pywin
// TODO: Interpreter raw_input
// TODO: Improve parameter completion with an option to provide more help (docstring)
// TODO: Find module expert

// TODO: UML Editor View
// TODO: Refactorings using BRM

// TODO: Plugin architecture
// TODO Package as an Application Scripter Component

unit frmPyIDEMain;

{$I SynEdit.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Variants, dmCommands, ComCtrls, StdActns, ActnList, Menus, uEditAppIntfs,
  JvDockControlForm, JvDockVIDStyle, JvDockVSNetStyle, JvComponent,
  SynEditTypes, SynEditMiscClasses, SynEditRegexSearch, cPyBaseDebugger,
  cPyDebugger, ToolWin,  ExtCtrls, JvExComCtrls, JvAppStorage,
  JvAppIniStorage, JvExControls, JvLED, SynEdit, JvTabBar,
  JvDragDrop, TB2Dock, TB2Toolbar, TBX, TBXSwitcher, TB2Item,
  TBXStatusBars, JvmbTBXTabBarPainter, JvDockVSNETStyleTBX,
  TB2MRU, TBXExtItems,  JvPageList, cRefactoring, dlgCustomShortcuts,
  // Themes
  TBXNexosXTheme, TBXOfficeXPTheme, TBXAluminumTheme, TBXWhidbeyTheme,
  TBXOffice2003Theme, TBXOffice2007Theme, TBXLists, TB2ExtItems, JvDockTree,
  JvComponentBase, JvAppInst, uHighlighterProcs, cFileTemplates, TntForms,
  JvFormPlacement;

const
  WM_FINDDEFINITION  = WM_USER + 100;
  WM_CHECKFORUPDATES = WM_USER + 110;
  WM_UPDATEBREAKPOINTS  = WM_USER + 120;

type
  TPyIDEMainForm = class(TTntForm)
    DockServer: TJvDockServer;
    actlStandard : TActionList;
    actRun: TAction;
    actRunToCursor: TAction;
    actStepInto: TAction;
    actStepOver: TAction;
    actStepOut: TAction;
    actToggleBreakPoint: TAction;
    actClearAllBreakpoints: TAction;
    actCallStackWin: TAction;
    actVariablesWin: TAction;
    actBreakPointsWin: TAction;
    actWatchesWin: TAction;
    actDebugAbort: TAction;
    actMessagesWin: TAction;
    actDebug: TAction;
    actViewII: TAction;
    actViewCodeExplorer: TAction;
    AppStorage: TJvAppIniFileStorage;
    actFileNewModule: TAction;
    actFileOpen: TAction;
    actFileCloseAll: TAction;
    actFileExit: TAction;
    actViewStatusBar: TAction;
    actViewFileExplorer: TAction;
    BGPanel: TPanel;
    TabBar: TJvTabBar;
    CloseTimer: TTimer;
    actImportModule: TAction;
    JvDropTarget: TJvDropTarget;
    actViewToDoList: TAction;
    actSyntaxCheck: TAction;
    actViewFindResults: TAction;
    actViewOutput: TAction;
    actExternalRun: TAction;
    actExternalRunConfigure: TAction;
    TBXSwitcher: TTBXSwitcher;
    TBXDockTop: TTBXDock;
    MainMenu: TTBXToolbar;
    FileMenu: TTBXSubmenuItem;
    New1: TTBXItem;
    Open1: TTBXItem;
    N14: TTBXSeparatorItem;
    Close1: TTBXItem;
    CloseAll2: TTBXItem;
    N1: TTBXSeparatorItem;
    Save1: TTBXItem;
    SaveAs1: TTBXItem;
    SaveAll1: TTBXItem;
    N2: TTBXSeparatorItem;
    PageSetup1: TTBXItem;
    PrinterSetup1: TTBXItem;
    PrintPreview1: TTBXItem;
    Print1: TTBXItem;
    N4: TTBXSeparatorItem;
    N3: TTBXItem;
    EditMenu: TTBXSubmenuItem;
    Undo1: TTBXItem;
    Redo1: TTBXItem;
    N5: TTBXSeparatorItem;
    Cut1: TTBXItem;
    Copy1: TTBXItem;
    IDEOptions1: TTBXItem;
    Delete1: TTBXItem;
    SelectAll1: TTBXItem;
    N6: TTBXSeparatorItem;
    Parameters1: TTBXSubmenuItem;
    PageSetup2: TTBXItem;
    Insertmodifier1: TTBXItem;
    N16: TTBXSeparatorItem;
    Replaceparameter1: TTBXItem;
    CodeTemplate1: TTBXItem;
    SourceCode1: TTBXSubmenuItem;
    IndentBlock1: TTBXItem;
    DedentBlock1: TTBXItem;
    Commentout1: TTBXItem;
    abify1: TTBXItem;
    Untabify1: TTBXItem;
    SearchMenu: TTBXSubmenuItem;
    Find1: TTBXItem;
    FindNext1: TTBXItem;
    FindPrevious1: TTBXItem;
    Replace1: TTBXItem;
    N15: TTBXSeparatorItem;
    FindinFiles1: TTBXItem;
    N7: TTBXSeparatorItem;
    Replace2: TTBXItem;
    FindinFiles2: TTBXItem;
    N23: TTBXSeparatorItem;
    MatchingBrace1: TTBXItem;
    RunMenu: TTBXSubmenuItem;
    SyntaxCheck1: TTBXItem;
    ImportModule1: TTBXItem;
    N21: TTBXSeparatorItem;
    Run2: TTBXItem;
    N22: TTBXSeparatorItem;
    ExternalRun1: TTBXItem;
    ConfigureExternalRun1: TTBXItem;
    N8: TTBXSeparatorItem;
    Debug1: TTBXItem;
    RunToCursor1: TTBXItem;
    StepInto1: TTBXItem;
    StepOver1: TTBXItem;
    StepOut1: TTBXItem;
    AbortDebugging1: TTBXItem;
    N9: TTBXSeparatorItem;
    ogglebreakpoint1: TTBXItem;
    ClearAllBreakpoints1: TTBXItem;
    ToolsMenu: TTBXSubmenuItem;
    PythonPath1: TTBXItem;
    N13: TTBXSeparatorItem;
    ConfigureTools1: TTBXItem;
    N20: TTBXSeparatorItem;
    Options1: TTBXSubmenuItem;
    IDEOptions2: TTBXItem;
    EditorOptions1: TTBXItem;
    CustomizeParameters1: TTBXItem;
    CodeTemplates1: TTBXItem;
    ViewMenu: TTBXSubmenuItem;
    NextEditor1: TTBXItem;
    PreviousEditor1: TTBXItem;
    N10: TTBXSeparatorItem;
    oolbars1: TTBXSubmenuItem;
    StatusBar1: TTBXItem;
    InteractiveInterpreter1: TTBXItem;
    FileExplorer1: TTBXItem;
    CodeExplorer1: TTBXItem;
    actViewToDoList1: TTBXItem;
    FindinFilesResults1: TTBXItem;
    actViewOutput1: TTBXItem;
    DebugWindows1: TTBXSubmenuItem;
    CallStack1: TTBXItem;
    Variables1: TTBXItem;
    Breakpoints1: TTBXItem;
    Watches1: TTBXItem;
    Messages1: TTBXItem;
    HelpMenu: TTBXSubmenuItem;
    PythonPath2: TTBXItem;
    N18: TTBXSeparatorItem;
    PyScripter1: TTBXSubmenuItem;
    CustomParameters1: TTBXItem;
    ExternalTools1: TTBXItem;
    N17: TTBXSeparatorItem;
    About1: TTBXItem;
    MainToolBar: TTBXToolbar;
    TBXItem1: TTBXItem;
    TBXItem2: TTBXItem;
    TBXItem3: TTBXItem;
    TBXItem4: TTBXItem;
    TBXSeparatorItem1: TTBXSeparatorItem;
    TBXItem5: TTBXItem;
    TBXSeparatorItem2: TTBXSeparatorItem;
    TBXItem6: TTBXItem;
    TBXItem7: TTBXItem;
    TBXItem8: TTBXItem;
    TBXSeparatorItem3: TTBXSeparatorItem;
    TBXItem9: TTBXItem;
    TBXItem10: TTBXItem;
    TBXSeparatorItem4: TTBXSeparatorItem;
    TBXItem11: TTBXItem;
    TBXItem12: TTBXItem;
    TBXItem13: TTBXItem;
    TBXItem14: TTBXItem;
    TBXSeparatorItem5: TTBXSeparatorItem;
    TBXItem15: TTBXItem;
    DebugToolbar: TTBXToolbar;
    TBXItem16: TTBXItem;
    TBXSeparatorItem6: TTBXSeparatorItem;
    TBXItem22: TTBXItem;
    TBXItem21: TTBXItem;
    TBXItem20: TTBXItem;
    TBXItem18: TTBXItem;
    TBXItem19: TTBXItem;
    TBXItem17: TTBXItem;
    TBXSeparatorItem7: TTBXSeparatorItem;
    TBXItem24: TTBXItem;
    TBXItem23: TTBXItem;
    JvmbTBXTabBarPainter: TJvmbTBXTabBarPainter;
    ViewToolbar: TTBXToolbar;
    TBXSubmenuItem2: TTBXSubmenuItem;
    TBXDockLeft: TTBXDock;
    StatusBar: TTBXStatusBar;
    StatusLED: TJvLED;
    ExternalToolsLED: TJvLED;
    TBXDockRight: TTBXDock;
    TBXDockBottom: TTBXDock;
    JvDockVSNetStyleTBX: TJvDockVSNetStyleTBX;
    mnTools: TTBXSubmenuItem;
    TabBarPopupMenu: TTBXPopupMenu;
    New2: TTBXItem;
    NewModule2: TTBXItem;
    CloseAll1: TTBXItem;
    N12: TTBXSeparatorItem;
    EditorOptions2: TTBXItem;
    TBXMRUList: TTBXMRUList;
    TBXMRUListItem: TTBXMRUListItem;
    RecentSubmenu: TTBXSubmenuItem;
    EditorViewsMenu: TTBXSubmenuItem;
    EditorsPageList: TJvPageList;
    TBXSeparatorItem8: TTBXSeparatorItem;
    mnThemes: TTBXSubmenuItem;
    ViewToolbarVisibilityToggle: TTBXVisibilityToggleItem;
    EditorToolbar: TTBXToolbar;
    TBXItem27: TTBXItem;
    TBXItem28: TTBXItem;
    TBXSeparatorItem10: TTBXSeparatorItem;
    TBXItem30: TTBXItem;
    TBXSeparatorItem11: TTBXSeparatorItem;
    TBXItem31: TTBXItem;
    TBXItem32: TTBXItem;
    EditorToolbarVisibilityToggle: TTBXVisibilityToggleItem;
    TBXItem25: TTBXItem;
    TBXItem26: TTBXItem;
    actFindDefinition: TAction;
    TBXItem33: TTBXItem;
    TBXSeparatorItem9: TTBXSeparatorItem;
    TBXSubmenuItem3: TTBXSubmenuItem;
    TBXItem34: TTBXItem;
    TBXItem35: TTBXItem;
    TBXItem36: TTBXItem;
    TBXSeparatorItem12: TTBXSeparatorItem;
    TBXItem37: TTBXItem;
    TBXSeparatorItem13: TTBXSeparatorItem;
    actFindReferences: TAction;
    TBXItem38: TTBXItem;
    btnNext: TTBXSubmenuItem;
    btnPrevious: TTBXSubmenuItem;
    TBXSeparatorItem14: TTBXSeparatorItem;
    PreviousList: TTBXStringList;
    NextList: TTBXStringList;
    actBrowseBack: TAction;
    actBrowseForward: TAction;
    TBXItem39: TTBXItem;
    TBXItem40: TTBXItem;
    TBXSeparatorItem15: TTBXSeparatorItem;
    TBXItem41: TTBXItem;
    actViewRegExpTester: TAction;
    TBXItem42: TTBXItem;
    actCommandLine: TAction;
    TBXItem43: TTBXItem;
    TBXItem44: TTBXItem;
    TBXItem45: TTBXItem;
    actViewUnitTests: TAction;
    TBXItem46: TTBXItem;
    TBXSeparatorItem16: TTBXSeparatorItem;
    mnLayouts: TTBXSubmenuItem;
    mnLayOutSeparator: TTBXSeparatorItem;
    TBXSubmenuItem1: TTBXSubmenuItem;
    actLayoutSave: TAction;
    actLayoutsDelete: TAction;
    actLayoutDebug: TAction;
    TBXItem47: TTBXItem;
    TBXItem48: TTBXItem;
    TBXItem49: TTBXItem;
    mnMaximizeEditor: TTBXItem;
    TBXSeparatorItem17: TTBXSeparatorItem;
    actMaximizeEditor: TAction;
    TBXSeparatorItem18: TTBXSeparatorItem;
    TBXSubmenuItem4: TTBXSubmenuItem;
    TBXSeparatorItem19: TTBXSeparatorItem;
    mnNoSyntax: TTBXItem;
    actEditorZoomIn: TAction;
    actEditorZoomOut: TAction;
    TBXSeparatorItem20: TTBXSeparatorItem;
    TBXSeparatorItem21: TTBXSeparatorItem;
    mnSyntax: TTBXSubmenuItem;
    TBXItem50: TTBXItem;
    TBXItem51: TTBXItem;
    TBXSeparatorItem22: TTBXSeparatorItem;
    mnFiles: TTBXSubmenuItem;
    actAddWatchAtCursor: TAction;
    TBXItem52: TTBXItem;
    RunningProcessesPopUpMenu: TTBXPopupMenu;
    TBXItem29: TTBXItem;
    TBXSubmenuItem5: TTBXSubmenuItem;
    TBXSeparatorItem23: TTBXSeparatorItem;
    actNewFile: TAction;
    TBXItem53: TTBXItem;
    JvAppInstances: TJvAppInstances;
    TBXItem54: TTBXItem;
    TBXItem55: TTBXItem;
    TBXItem56: TTBXItem;
    actNavWatches: TAction;
    actNavBreakpoints: TAction;
    actNavInterpreter: TAction;
    actNavVariables: TAction;
    actNavCallStack: TAction;
    actNavMessages: TAction;
    actNavFileExplorer: TAction;
    actNavCodeExplorer: TAction;
    actNavTodo: TAction;
    actNavUnitTests: TAction;
    actNavOutput: TAction;
    actNavEditor: TAction;
    TBXSubmenuItem6: TTBXSubmenuItem;
    TBXItem57: TTBXItem;
    TBXSeparatorItem24: TTBXSeparatorItem;
    TBXItem58: TTBXItem;
    TBXItem59: TTBXItem;
    TBXItem60: TTBXItem;
    TBXItem62: TTBXItem;
    TBXItem63: TTBXItem;
    TBXSeparatorItem25: TTBXSeparatorItem;
    TBXItem64: TTBXItem;
    TBXItem65: TTBXItem;
    TBXItem66: TTBXItem;
    TBXItem67: TTBXItem;
    TBXItem68: TTBXItem;
    TBXItem69: TTBXItem;
    actDebugPause: TAction;
    TBXItem61: TTBXItem;
    TBXItem70: TTBXItem;
    mnPythonEngines: TTBXSubmenuItem;
    actPythonReinitialize: TAction;
    actPythonInternal: TAction;
    actPythonRemote: TAction;
    actPythonRemoteTk: TAction;
    actPythonRemoteWx: TAction;
    TBXItem71: TTBXItem;
    TBXItem72: TTBXItem;
    TBXItem73: TTBXItem;
    TBXItem74: TTBXItem;
    TBXItem75: TTBXItem;
    TBXSeparatorItem26: TTBXSeparatorItem;
    actExecSelection: TAction;
    TBXSeparatorItem27: TTBXSeparatorItem;
    TBXItem76: TTBXItem;
    actRestoreEditor: TAction;
    TBXItem77: TTBXItem;
    TBXSeparatorItem28: TTBXSeparatorItem;
    TBXItem78: TTBXItem;
    TBXItem79: TTBXItem;
    TBXItem80: TTBXItem;
    TBXSeparatorItem29: TTBXSeparatorItem;
    TBXSubmenuItem7: TTBXSubmenuItem;
    TBXItem81: TTBXItem;
    TBXItem82: TTBXItem;
    TBXSeparatorItem30: TTBXSeparatorItem;
    TBXItem83: TTBXItem;
    TBXItem84: TTBXItem;
    DebugtoolbarVisibilityToggle: TTBXVisibilityToggleItem;
    TBXVisibilityToggleItem1: TTBXVisibilityToggleItem;
    actViewMainMenu: TAction;
    TBXItem85: TTBXItem;
    actlImmutable: TActionList;
    actViewNextEditor: TAction;
    actViewPreviousEditor: TAction;
    JvFormStorage: TJvFormStorage;
    SeeMemu: TTBXSubmenuItem;
    miSearchPath: TTBXItem;
    miGotoActivePath: TTBXItem;
    procedure mnFilesClick(Sender: TObject);
    procedure actEditorZoomInExecute(Sender: TObject);
    procedure actEditorZoomOutExecute(Sender: TObject);
    procedure mnNoSyntaxClick(Sender: TObject);
    procedure mnSyntaxPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure actMaximizeEditorExecute(Sender: TObject);
    procedure actLayoutDebugExecute(Sender: TObject);
    procedure actLayoutsDeleteExecute(Sender: TObject);
    procedure actLayoutSaveExecute(Sender: TObject);
    procedure actViewUnitTestsExecute(Sender: TObject);
    procedure actCommandLineExecute(Sender: TObject);
    procedure JvAppInstancesCmdLineReceived(Sender: TObject; CmdLine: TStrings);
    procedure actViewRegExpTesterExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TabbarContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure actSyntaxCheckExecute(Sender: TObject);
    procedure actRunExecute(Sender: TObject);
    procedure actToggleBreakPointExecute(Sender: TObject);
    procedure actClearAllBreakpointsExecute(Sender: TObject);
    procedure actDebugExecute(Sender: TObject);
    procedure actStepIntoExecute(Sender: TObject);
    procedure actStepOverExecute(Sender: TObject);
    procedure actStepOutExecute(Sender: TObject);
    procedure actRunToCursorExecute(Sender: TObject);
    procedure actDebugAbortExecute(Sender: TObject);
    procedure actViewIIExecute(Sender: TObject);
    procedure actMessagesWinExecute(Sender: TObject);
    procedure actNextEditorExecute(Sender: TObject);
    procedure actPreviousEditorExecute(Sender: TObject);
    procedure actCallStackWinExecute(Sender: TObject);
    procedure actVariablesWinExecute(Sender: TObject);
    procedure actBreakPointsWinExecute(Sender: TObject);
    procedure actWatchesWinExecute(Sender: TObject);
    procedure actViewCodeExplorerExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actViewStatusBarExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actFileNewModuleExecute(Sender: TObject);
    procedure actFileOpenExecute(Sender: TObject);
    procedure actFileCloseAllExecute(Sender: TObject);
    procedure actViewFileExplorerExecute(Sender: TObject);
    procedure TabBarTabSelected(Sender: TObject; Item: TJvTabBarItem);
    procedure TabBarTabClosed(Sender: TObject; Item: TJvTabBarItem);
    procedure FormShortCut(var Msg: TWMKey; var Handled: Boolean);
    procedure CloseTimerTimer(Sender: TObject);
    procedure actImportModuleExecute(Sender: TObject);
    procedure JvDropTargetDragDrop(Sender: TJvDropTarget;
      var Effect: TJvDropEffect; Shift: TShiftState; X, Y: Integer);
    procedure actViewToDoListExecute(Sender: TObject);
    procedure actViewFindResultsExecute(Sender: TObject);
    procedure ExternalToolsUpdate(Sender: TObject);
    procedure actViewOutputExecute(Sender: TObject);
    procedure actExternalRunExecute(Sender: TObject);
    procedure actExternalRunConfigureExecute(Sender: TObject);
    procedure TBXMRUListClick(Sender: TObject; const Filename: String);
    procedure actFindDefinitionExecute(Sender: TObject);
    procedure actFindReferencesExecute(Sender: TObject);
    procedure PreviousListClick(Sender: TObject);
    procedure btnPreviousClick(Sender: TObject);
    procedure NextListClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    function ApplicationHelp(Command: Word; Data: Integer;
      var CallHelp: Boolean): Boolean;
    procedure FormShow(Sender: TObject);
    procedure actAddWatchAtCursorExecute(Sender: TObject);
    procedure actNewFileExecute(Sender: TObject);
    procedure actNavWatchesExecute(Sender: TObject);
    procedure actNavBreakpointsExecute(Sender: TObject);
    procedure actNavInterpreterExecute(Sender: TObject);
    procedure actNavVariablesExecute(Sender: TObject);
    procedure actNavCallStackExecute(Sender: TObject);
    procedure actNavMessagesExecute(Sender: TObject);
    procedure actNavFileExplorerExecute(Sender: TObject);
    procedure actNavCodeExplorerExecute(Sender: TObject);
    procedure actNavTodoExecute(Sender: TObject);
    procedure actNavUnitTestsExecute(Sender: TObject);
    procedure actNavOutputExecute(Sender: TObject);
    procedure actNavRETesterExecute(Sender: TObject);
    procedure actNavEditorExecute(Sender: TObject);
    procedure actDebugPauseExecute(Sender: TObject);
    procedure actPythonReinitializeExecute(Sender: TObject);
    procedure actPythonEngineExecute(Sender: TObject);
    procedure mnPythonEnginesPopup(Sender: TTBCustomItem; FromLink: Boolean);
    procedure actExecSelectionExecute(Sender: TObject);
    procedure TabBarMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabBarDblClick(Sender: TObject);
    procedure actRestoreEditorExecute(Sender: TObject);
    procedure actViewMainMenuExecute(Sender: TObject);
    procedure TntFormLXKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure miSearchPathClick(Sender: TObject);
  protected
    fCurrentLine : integer;
    fErrorLine : integer;
    fRefactoring : TBRMRefactor;
    fCurrentBrowseInfo : string;
    function DoCreateEditor: IEditor;
    function CmdLineOpenFiles(): boolean;
    procedure DebuggerBreakpointChange(Sender: TObject; Editor : IEditor; ALine: integer);
    procedure SetCurrentPos(Editor : IEditor; ALine: integer);
    procedure DebuggerCurrentPosChange(Sender: TObject);
    procedure UpdateStandardActions;
    procedure UpdateStatusBarPanels;
    procedure ApplicationOnIdle(Sender: TObject; var Done: Boolean);
    procedure ApplicationOnHint(Sender: TObject);
    procedure ApplcationOnShowHint(var HintStr: string; var CanShow: Boolean;
      var HintInfo: THintInfo);
    procedure WMFindDefinition(var Msg: TMessage); message WM_FINDDEFINITION;
    procedure WMUpdateBreakPoints(var Msg: TMessage); message WM_UPDATEBREAKPOINTS;
    procedure WMCheckForUpdates(var Msg: TMessage); message WM_CHECKFORUPDATES;
    procedure TBMThemeChange(var Message: TMessage); message TBM_THEMECHANGE;
    procedure TBXThemeMenuOnClick(Sender: TObject);
    procedure SyntaxClick(Sender : TObject);
    procedure SelectEditor(Sender : TObject);
  public
    PythonKeywordHelpRequested : Boolean;
    MenuHelpRequested : Boolean;
    ActionListArray : TActionListArray;
    Layouts : TStringList;
    zOrder : TList;
    zOrderPos : integer;
    zOrderProcessing : Boolean;
    procedure SaveEnvironment;
    procedure StoreApplicationData;
    procedure RestoreApplicationData;
    function DoOpenFile(AFileName: string; HighlighterName : string = '') : IEditor;
    function NewFileFromTemplate(FileTemplate : TFileTemplate) : IEditor;
    function GetActiveEditor : IEditor;
    procedure SaveFileModules;
    procedure UpdateDebugCommands(DebuggerState : TDebuggerState);
    function ShowFilePosition(FileName : string; Line, Offset : integer;
         ForceToMiddle : boolean = True) : boolean;
    procedure DebuggerStateChange(Sender: TObject; OldState,
      NewState: TDebuggerState);
    procedure DebuggerYield(Sender: TObject; DoIdle : Boolean);
    procedure DebuggerErrorPosChange(Sender: TObject);
    procedure PyIDEOptionsChanged;
    procedure SetupToolsMenu;
    procedure SetupLayoutsMenu;
    procedure SetupSyntaxMenu;
    procedure RunExternalTool(Sender : TObject);
    procedure LayoutClick(Sender : TObject);
    procedure LoadLayout(Layout : string);
    procedure SaveLayout(Layout : string);
    procedure WriteStatusMsg(S : String);
    function JumpToFilePosInfo(FilePosInfo : string) : boolean;
    procedure FindDefinition(Editor : IEditor; TextCoord : TBufferCoord;
      ShowMessages, Silent, JumpToFirstMatch : Boolean; var FilePosInfo : string);
    procedure AdjustBrowserLists(FileName: string; Line: Integer; Col: Integer;
      FilePosInfo: string);
    procedure ThemeEditorGutter(Gutter : TSynGutter);
    procedure FillTBXThemeMenu;
  end;

var
  PyIDEMainForm: TPyIDEMainForm;

implementation

uses
  frmPythonII, frmMessages, PythonEngine, frmEditor,
  frmCallStack, frmBreakPoints, frmVariables, frmWatches,
  frmCodeExplorer, frmFileExplorer, JclFileUtils, frmToDo,
  frmFindResults, cFindInFiles, uParams, cTools, cParameters,
  frmCommandOutput, JvCreateProcess, dlgToolProperties, uCommonFunctions,
  TBXThemes, SynHighlighterPython, SynEditHighlighter, VarPyth, SynRegExpr,
  JvJVCLUtils, DateUtils, cPythonSourceScanner, frmRegExpTester,
  StringResources, dlgCommandLine, frmUnitTests, cFilePersist, frmIDEDockWin,
  dlgPickList, VirtualTrees, VirtualExplorerTree, JvDockGlobals, Math,
  cCodeHint, dlgNewFile, SynEditTextBuffer, JclSysInfo, cPyRemoteDebugger,
  uSeeWork,
  uCmdLine;

{$R *.DFM}

{ TWorkbookMainForm }

function TPyIDEMainForm.DoCreateEditor: IEditor;
begin
  if GI_EditorFactory <> nil then begin
    Result := GI_EditorFactory.CreateTabSheet(EditorsPageList);
    Result.SynEdit.Assign(CommandsDataModule.EditorOptions);
  end else
    Result := nil;
end;

function TPyIDEMainForm.DoOpenFile(AFileName: string; HighlighterName : string = '') : IEditor;
begin
  Result := nil;
  AFileName := GetLongFileName(ExpandFileName(AFileName));
  if AFileName <> '' then begin
    // activate the editor if already open
    Assert(GI_EditorFactory <> nil);
    Result :=  GI_EditorFactory.GetEditorByName(AFileName);
    if Assigned(Result) then begin
      Result.Activate;
      Exit;
    end;
  end;
  // create a new editor, add it to the editor list, open the file
  Result := DoCreateEditor;
  if Result <> nil then begin
    try
      Result.OpenFile(AFileName, HighlighterName);
      TBXMRUList.Remove(AFileName);
      Result.Activate;
    except
      Result.Close;
      raise
    end;
    if (AFileName <> '') and (GI_EditorFactory.Count = 2) and
      (GI_EditorFactory.Editor[0].FileName = '') and
      not GI_EditorFactory.Editor[0].Modified
    then
      GI_EditorFactory.Editor[0].Close;
    if (AFileName = '') and (HighlighterName = 'Python') then
      TEditorForm(Result.Form).DefaultExtension := 'py';
  end;
end;

procedure TPyIDEMainForm.FormCreate(Sender: TObject);
Var
  TabHost : TJvDockTabHostForm;
  OptionsFileName: string;
begin
  // App Instances
  if not CmdLineReader.readFlag('NEWINSTANCE') then begin
    JvAppInstances.Active := True;
    JvAppInstances.Check;
  end;

  // Trying to reduce flicker!
  ControlStyle := ControlStyle + [csOpaque];
  BGPanel.ControlStyle := BGPanel.ControlStyle + [csOpaque];
  DockServer.LeftDockPanel.ControlStyle := DockServer.LeftDockPanel.ControlStyle + [csOpaque];
  DockServer.RightDockPanel.ControlStyle := DockServer.LeftDockPanel.ControlStyle + [csOpaque];
  DockServer.TopDockPanel.ControlStyle := DockServer.LeftDockPanel.ControlStyle + [csOpaque];
  DockServer.BottomDockPanel.ControlStyle := DockServer.LeftDockPanel.ControlStyle + [csOpaque];
  TabBar.ControlStyle := TabBar.ControlStyle + [csOpaque];
  StatusBar.ControlStyle := StatusBar.ControlStyle + [csOpaque];
  // so that it gets repainted when there are no open files and the theme changes
  EditorsPageList.ControlStyle := EditorsPageList.ControlStyle - [csOpaque];

  SetDesktopIconFonts(Self.Font);  // For Vista
  SetDesktopIconFonts(JvmbTBXTabBarPainter.Font);
  SetDesktopIconFonts(JvmbTBXTabBarPainter.SelectedFont);
  SetDesktopIconFonts(JvmbTBXTabBarPainter.DisabledFont);
  JvmbTBXTabBarPainter.DisabledFont.Color := clGrayText;
  SetDesktopIconFonts(TJvDockVSNETTabServerOption(JvDockVSNetStyleTBX.TabServerOption).ActiveFont);
  SetDesktopIconFonts(TJvDockVSNETTabServerOption(JvDockVSNetStyleTBX.TabServerOption).InactiveFont);
  TJvDockVSNETTabServerOption(JvDockVSNetStyleTBX.TabServerOption).InactiveFont.Color := 5395794;

  AddThemeNotification(Self);

  Layouts := TStringList.Create;
  Layouts.Sorted := True;
  Layouts.Duplicates := dupError;

  zOrder := TList.Create;

  // Application Storage
  OptionsFileName := ChangeFileExt(ExtractFileName(Application.ExeName), '.ini');
  if FileExists(ChangeFileExt(Application.ExeName, '.ini')) then begin
    AppStorage.Location := flExeFile;
    AppStorage.FileName := OptionsFileName;
  end else if FileExists(PathAddSeparator(GetAppdataFolder) + OptionsFileName) then begin
    AppStorage.Location := flUserFolder;
    AppStorage.FileName := OptionsFileName;
  end else  // default location
    AppStorage.FileName :=
      CommandsDataModule.UserDataDir + OptionsFileName;

  AppStorage.StorageOptions.StoreDefaultValues := False;

  // Create and layout IDE windows
  PythonIIForm := TPythonIIForm.Create(self);
  CallStackWindow := TCallStackWindow.Create(Self);
  VariablesWindow := TVariablesWindow.Create(Self);
  WatchesWindow := TWatchesWindow.Create(Self);
  BreakPointsWindow := TBreakPointsWindow.Create(Self);
  OutputWindow := TOutputWindow.Create(Self);
  MessagesWindow := TMessagesWindow.Create(Self);
  CodeExplorerWindow := TCodeExplorerWindow.Create(Self);
  FileExplorerWindow := TFileExplorerWindow.Create(Self);
  ToDoWindow := TToDoWindow.Create(Self);
  RegExpTesterWindow := TRegExpTesterWindow.Create(Self);
  UnitTestWindow := TUnitTestWindow.Create(Self);
  // FindInFilesExpert creates FindResultsWindow
  FindInFilesExpert := TFindInFilesExpert.Create;

  // Assign Debugger Events
  with PyControl do begin
    OnBreakpointChange := DebuggerBreakpointChange;
    OnCurrentPosChange := DebuggerCurrentPosChange;
    OnErrorPosChange := DebuggerErrorPosChange;
    OnStateChange := DebuggerStateChange;
    OnYield := DebuggerYield;
  end;

  // ActionLists
  SetLength(ActionListArray, 3);
  ActionListArray[0] := actlStandard;
  ActionListArray[1] := CommandsDataModule.actlMain;
  ActionListArray[2] := PythonIIForm.InterpreterActionList;

  // Read Settings from PyScripter.ini
  if FileExists(AppStorage.IniFile.FileName) then begin
    RestoreApplicationData;
    JvFormStorage.RestoreFormPlacement;
  end;

  // Note that the following will trigger the AppStorage to RestoreFormPlacement etc.
  // Otherwise this would have happened after exiting FormCreate when the Form is shown.
  AppStorage.ReadStringList('Layouts', Layouts, True);

  if AppStorage.PathExists('Layouts\Current\Forms') then begin
    //LoadDockTreeFromAppStorage(AppStorage, 'Layouts\Current')
    LoadLayout('Current');
  end else begin
    TBXSwitcher.Theme := 'Office 2003';
    TabHost := ManualTabDock(DockServer.LeftDockPanel, FileExplorerWindow, CodeExplorerWindow);
    DockServer.LeftDockPanel.Width := 200;
    ManualTabDockAddPage(TabHost, UnitTestWindow);
    ShowDockForm(FileExplorerWindow);

    TabHost := ManualTabDock(DockServer.BottomDockPanel, CallStackWindow, VariablesWindow);
    DockServer.BottomDockPanel.Height := 150;

    ManualTabDockAddPage(TabHost, WatchesWindow);
    ManualTabDockAddPage(TabHost, BreakPointsWindow);
    ManualTabDockAddPage(TabHost, OutputWindow);
    ManualTabDockAddPage(TabHost, MessagesWindow);
    ManualTabDockAddPage(TabHost, PythonIIForm);
    ShowDockForm(PythonIIForm);

    Application.ProcessMessages;
  end;

  Application.OnIdle := ApplicationOnIdle;
  Application.OnHint := ApplicationOnHint;
  Application.OnShowHint := ApplcationOnShowHint;

  // Create Refactoring Helper
  fRefactoring := TBRMRefactor.Create;

  UpdateDebugCommands(PyControl.DebuggerState);
  //  Editor Views Menu
  GI_EditorFactory.SetupEditorViewMenu;

  Update;
  SendMessage(EditorsPageList.Handle, WM_SETREDRAW, 0, 0);  // To avoid flicker
  try
    // Open Files on the command line
    CmdLineOpenFiles();

    // if there was no file on the command line try restoring open files
    if CommandsDataModule.PyIDEOptions.RestoreOpenFiles  and
       (GI_EditorFactory.GetEditorCount = 0)
    then
      TPersistFileInfo.ReadFromAppStorage(AppStorage, 'Open Files');

    // If we still have no open file then open an empty file
    if GI_EditorFactory.GetEditorCount = 0 then
      DoOpenFile('', 'Python');
  finally
    EditorsPageList.Visible := False;
    EditorsPageList.Visible := True;
    SendMessage(EditorsPageList.Handle, WM_SETREDRAW, 1, 0);
    EditorsPageList.Invalidate;
    if Assigned(GetActiveEditor()) then
      GetActiveEditor.Activate;
    // Start the Python Code scanning thread
    CodeExplorerWindow.WorkerThread.Resume;
  end;

  // To get round the XP drawing bug with ExternalToolLED
  StatusBar.DoubleBuffered := True;
  StatusBar.Top := Height - StatusBar.Height;  // make sure is shown at the bottom

  //Set the HelpFile
  Application.HelpFile := ExtractFilePath(Application.ExeName) + 'PyScripter.chm';
  Application.OnHelp := Self.ApplicationHelp;
end;

procedure TPyIDEMainForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if JvGlobalDockIsLoading then begin
    CanClose := False;
    CloseTimer.Enabled := True;
    Exit;
  end else if PyControl.DebuggerState <> dsInactive then begin
    if Windows.MessageBox(Handle,
      'A debugging session is in process.  Do you want to abort the session and Exit?',
       PChar(Application.Title), MB_ICONWARNING or MB_YESNO) = idYes then
    begin
      if (PyControl.DebuggerState = dsPaused) or
        (PyControl.ActiveDebugger is TPyInternalDebugger) then
      begin
        CanClose := False;
        PyControl.ActiveDebugger.Abort;
        CloseTimer.Enabled := True;
        Exit;
      end else begin
        PyControl.ActiveInterpreter.ReInitialize;
        CanClose := True
      end;
    end else begin  // idNo
       CanClose := False;
       Exit;
    end;
  end;

  if OutputWindow.JvCreateProcess.State <> psReady then
    if  MessageDlg('An External Tool is still running.  Do you want to terminate it and exit?',
        mtConfirmation, [mbYes, mbCancel], 0) = mrYes
    then begin
      OutputWindow.actToolTerminateExecute(Self);
      CanClose := True;
    end else
      CanClose := False;

  if GI_EditorFactory <> nil then
    CanClose := GI_EditorFactory.CanCloseAll;

  if CanClose then begin
    // Shut down CodeExplorerWindow Worker thread
    CodeExplorerWindow.ShutDownWorkerThread;

    // Disconnect ChangeNotify
    CommandsDataModule.JvChangeNotify.OnChangeNotify := nil;
    CommandsDataModule.JvChangeNotify.Active := False;

    // Close FileExplorer ChangeNotify Thread
    FileExplorerWindow.FileExplorerTree.TreeOptions.VETMiscOptions :=
      FileExplorerWindow.FileExplorerTree.TreeOptions.VETMiscOptions
          - [toChangeNotifierThread];

    // Disable CodeHint timer
    CodeHint.CancelHint;

    // Shut down help
    Application.OnHelp := nil;
    // QC25183
    try
      Application.HelpCommand(HELP_QUIT, 0);
    except
    end;

    VariablesWindow.ClearAll;
    UnitTestWindow.ClearAll;
    CallStackWindow.ClearAll;

    // Give the time to the treads to terminate
    Sleep(200);

    //  We need to do this here so that MRU and docking information are persisted
    SaveEnvironment;

    SendMessage(EditorsPageList.Handle, WM_SETREDRAW, 0, 0);  // To avoid flicker
    if GI_EditorFactory <> nil then
      GI_EditorFactory.CloseAll;
    SendMessage(EditorsPageList.Handle, WM_SETREDRAW, 1, 0);

    RemoveThemeNotification(Self);
  end;
end;

procedure TPyIDEMainForm.TabbarContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
Var
  Tab : TJvTabBarItem;
begin
  Tab := Tabbar.TabAt(MousePos.X, MousePos.Y);
  if Assigned(Tab) then
    Tab.Selected := True;
  Handled := False;
end;

procedure TPyIDEMainForm.actNavBreakpointsExecute(Sender: TObject);
begin
  ShowDockForm(BreakPointsWindow);
  BreakPointsWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavCallStackExecute(Sender: TObject);
begin
  ShowDockForm(CallStackWindow);
  CallStackWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavCodeExplorerExecute(Sender: TObject);
begin
  ShowDockForm(CodeExplorerWindow);
  CodeExplorerWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavEditorExecute(Sender: TObject);
Var
  Editor : IEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    Editor.Activate;
end;

procedure TPyIDEMainForm.actNavFileExplorerExecute(Sender: TObject);
begin
  ShowDockForm(FileExplorerWindow);
  FileExplorerWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavInterpreterExecute(Sender: TObject);
begin
  ShowDockForm(PythonIIForm);
  PythonIIForm.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavMessagesExecute(Sender: TObject);
begin
  ShowDockForm(MessagesWindow);
  MessagesWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavOutputExecute(Sender: TObject);
begin
  ShowDockForm(OutputWindow);
  OutputWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavRETesterExecute(Sender: TObject);
begin
  ShowDockForm(RegExpTesterWindow);
  RegExpTesterWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavTodoExecute(Sender: TObject);
begin
  ShowDockForm(ToDoWindow);
  ToDoWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavUnitTestsExecute(Sender: TObject);
begin
  ShowDockForm(UnitTestWindow);
  UnitTestWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavVariablesExecute(Sender: TObject);
begin
  ShowDockForm(VariablesWindow);
  VariablesWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNavWatchesExecute(Sender: TObject);
begin
  ShowDockForm(WatchesWindow);
  WatchesWindow.FormActivate(Sender);
end;

procedure TPyIDEMainForm.actNewFileExecute(Sender: TObject);
begin
  with TNewFileDialog.Create(Self) do begin
    if ShowModal = mrOK then begin
      NewFileFromTemplate(SelectedTemplate);
    end;
    Free;
  end;
end;

procedure TPyIDEMainForm.actNextEditorExecute(Sender: TObject);
Var
  TabBarItem : TJvTabBarItem;
begin
  if TabBar.Tabs.Count <= 1 then Exit;
  TabBarItem := nil;
  if CommandsDataModule.PyIDEOptions.SmartNextPrevPage then begin
    Repeat
      Inc(zOrderPos);
      if zOrderPos >= zOrder.Count then
        ZOrderPos := 0;
      while zOrderPos < zOrder.Count  do begin
        TabBarItem := zOrder[zOrderPos];
        if TabBar.Tabs.IndexOf(TabBarItem) < 0 then begin
          zOrder.Delete(zOrderPos);
          TabBarItem := nil;
        end else
          break;
      end;
    Until Assigned(TabBarItem) or (ZOrder.Count = 0);
    KeyPreview := True;
    zOrderProcessing := True;
  end else begin
    if Assigned(TabBar.SelectedTab) then
      TabBarItem := TabBar.SelectedTab.GetNextVisible
    else
      TabBarItem := TabBar.Tabs.Items[0];
  end;

  if not Assigned(TabBarItem) then
    TabBarItem := TabBar.Tabs.Items[0];
  if Assigned(TabBarItem) then
    TabBarItem.Selected := True;
end;

procedure TPyIDEMainForm.actPreviousEditorExecute(Sender: TObject);
Var
  TabBarItem : TJvTabBarItem;
begin
  if TabBar.Tabs.Count <= 1 then Exit;
  TabBarItem := nil;
  if CommandsDataModule.PyIDEOptions.SmartNextPrevPage then begin
    Repeat
      Dec(zOrderPos);
      if zOrderPos < 0 then
        zOrderPos := zOrder.Count - 1;
      while zOrderPos < zOrder.Count  do begin
        TabBarItem := zOrder[zOrderPos];
        if TabBar.Tabs.IndexOf(TabBarItem) < 0 then begin
          zOrder.Delete(zOrderPos);
          TabBarItem := nil;
        end else
          break;
      end;
    Until Assigned(TabBarItem) or (ZOrder.Count = 0);
    KeyPreview := True;
    zOrderProcessing := True;
  end else begin
    if Assigned(TabBar.SelectedTab) then
      TabBarItem := TabBar.SelectedTab.GetPreviousVisible
    else
      TabBarItem := TabBar.Tabs.Items[TabBar.Tabs.Count-1];
  end;
  if not Assigned(TabBarItem) then
    TabBarItem := TabBar.Tabs.Items[TabBar.Tabs.Count-1];
  if Assigned(TabBarItem) then
    TabBarItem.Selected := True;
end;

procedure TPyIDEMainForm.actPythonEngineExecute(Sender: TObject);
Var
  PythonEngineType : TPythonEngineType;
  Msg : string;
begin
  PythonEngineType := TPythonEngineType((Sender as TAction).Tag);
  PythonIIForm.SetPythonEngineType(PythonEngineType);
  case CommandsDataModule.PyIDEOptions.PythonEngineType of
    peInternal :  Msg := Format(SEngineActive, ['Internal','']);
    peRemote : Msg := Format(SEngineActive, ['Remote','']);
    peRemoteTk : Msg := Format(SEngineActive, ['Remote','(Tkinter) ']);
    peRemoteWx : Msg := Format(SEngineActive, ['Remote','(wxPython) ']);
  end;
  PythonIIForm.AppendText(WideLineBreak + Msg);
  PythonIIForm.AppendPrompt;
end;

procedure TPyIDEMainForm.actPythonReinitializeExecute(Sender: TObject);
begin
  if PyControl.DebuggerState <> dsInactive then begin
    if MessageDlg('The Python interpreter is busy.  Are you sure you want to terminate it?',
      mtWarning, [mbYes, mbNo], 0) = idNo then Exit;
  end;
  PyControl.ActiveInterpreter.ReInitialize;
end;

procedure TPyIDEMainForm.actSyntaxCheckExecute(Sender: TObject);
var
  ActiveEditor : IEditor;
begin
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;

  if InternalInterpreter.SyntaxCheck(ActiveEditor) then begin
    MessagesWindow.AddMessage(Format('Syntax of %s is OK!', [ActiveEditor.FileTitle]));
    ShowDockForm(MessagesWindow);
  end;
end;

procedure TPyIDEMainForm.actImportModuleExecute(Sender: TObject);
var
  ActiveEditor : IEditor;
begin
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;

  PyControl.ActiveInterpreter.ImportModule(ActiveEditor, True);

  MessagesWindow.AddMessage(Format('Module %s was imported successfully!', [ActiveEditor.FileTitle]));
  ShowDockForm(MessagesWindow);
end;

procedure TPyIDEMainForm.actToggleBreakPointExecute(Sender: TObject);
var
  ActiveEditor : IEditor;
begin
  ActiveEditor := GetActiveEditor;
  if Assigned(ActiveEditor) and ActiveEditor.HasPythonFile then
    PyControl.ToggleBreakpoint(ActiveEditor, ActiveEditor.SynEdit.CaretY);
end;

procedure TPyIDEMainForm.actClearAllBreakpointsExecute(Sender: TObject);
begin
  PyControl.ClearAllBreakpoints;
end;

procedure TPyIDEMainForm.actCommandLineExecute(Sender: TObject);
begin
  with TCommandLineDlg.Create(Self) do begin
    SynParameters.Text := CommandsDataModule.PyIDEOptions.CommandLine;
    cbUseCommandLine.Checked := CommandsDataModule.PyIDEOptions.UseCommandLine;
    if ShowModal = mrOk then begin
      CommandsDataModule.PyIDEOptions.CommandLine := SynParameters.Text;
      CommandsDataModule.PyIDEOptions.UseCommandLine := cbUseCommandLine.Checked;
    end;
  end;
end;

procedure TPyIDEMainForm.actRunExecute(Sender: TObject);
var
  ActiveEditor : IEditor;
begin
  Application.ProcessMessages;
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;

  if CommandsDataModule.PyIDEOptions.SaveFilesBeforeRun then
    SaveFileModules;
  if CommandsDataModule.PyIDEOptions.SaveEnvironmentBeforeRun then
    SaveEnvironment;

  PyControl.ActiveInterpreter.RunNoDebug(ActiveEditor);

  WriteStatusMsg('Script run OK');
  MessageBeep(MB_ICONASTERISK);
end;

procedure TPyIDEMainForm.actDebugExecute(Sender: TObject);
var
  ActiveEditor : IEditor;
begin
  Application.ProcessMessages;
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;

  if CommandsDataModule.PyIDEOptions.SaveFilesBeforeRun then
    SaveFileModules;
  if CommandsDataModule.PyIDEOptions.SaveEnvironmentBeforeRun then
    SaveEnvironment;

  PyControl.ActiveDebugger.Run(ActiveEditor);
end;

procedure TPyIDEMainForm.actDebugPauseExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.Pause;
end;

procedure TPyIDEMainForm.actStepIntoExecute(Sender: TObject);
var
  Editor : IEditor;
begin
  Editor := GetActiveEditor;
  if Assigned(Editor) then
    PyControl.ActiveDebugger.StepInto(Editor);
end;

procedure TPyIDEMainForm.actStepOverExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.StepOver;
end;

procedure TPyIDEMainForm.actStepOutExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.StepOut;
end;

procedure TPyIDEMainForm.actDebugAbortExecute(Sender: TObject);
begin
  PyControl.ActiveDebugger.Abort;
end;

procedure TPyIDEMainForm.actRunToCursorExecute(Sender: TObject);
var
  Editor : IEditor;
begin
  Editor := GetActiveEditor;
  PyControl.ActiveDebugger.RunToCursor(Editor, Editor.SynEdit.CaretY);
end;

procedure TPyIDEMainForm.DebuggerBreakpointChange(Sender: TObject; Editor : IEditor;
  ALine: integer);
begin
  PostMessage(Handle, WM_UPDATEBREAKPOINTS, 0, 0);
  if not Assigned(Editor) then Exit;
  if (ALine >= 1) and (ALine <= Editor.SynEdit.Lines.Count) then
  begin
    Editor.SynEdit.InvalidateGutterLine(ALine);
    Editor.SynEdit.InvalidateLine(ALine);
  end
  else
    Editor.SynEdit.Invalidate;
end;

procedure TPyIDEMainForm.UpdateDebugCommands(DebuggerState : TDebuggerState);
var
  Editor : IEditor;
  PyFileActive : boolean;
begin
  Editor := GetActiveEditor;
  PyFileActive := Assigned(Editor) and Editor.HasPythonFile;

  actSyntaxCheck.Enabled := PyFileActive and (DebuggerState = dsInactive);
  actRun.Enabled := PyFileActive and (DebuggerState = dsInactive);
  actExternalRun.Enabled := PyFileActive and (DebuggerState = dsInactive);
  actImportModule.Enabled := PyFileActive and (DebuggerState = dsInactive);
  actDebug.Enabled := not (DebuggerState in [dsRunning, dsRunningNoDebug])
                      and PyFileActive;
  actStepInto.Enabled := (DebuggerState = dsPaused) or
                         (PyFileActive and (DebuggerState = dsInactive));
  actStepOut.Enabled := DebuggerState = dsPaused;
  actStepOver.Enabled := DebuggerState = dsPaused;
  actDebugAbort.Enabled := DebuggerState in [dsPaused, dsRunning];
  actDebugPause.Enabled := DebuggerState = dsRunning;
  actRunToCursor.Enabled := (not (DebuggerState in [dsRunning, dsRunningNoDebug])) and
    PyFileActive and PyControl.IsExecutableLine(Editor, Editor.SynEdit.CaretY);
  actToggleBreakPoint.Enabled := PyFileActive;
  actClearAllBreakPoints.Enabled := PyFileActive;
  actAddWatchAtCursor.Enabled := PyFileActive;
  actExecSelection.Enabled := not (DebuggerState in [dsRunning, dsRunningNoDebug])
    and PyFileActive and Editor.SynEdit.SelAvail;
end;

procedure TPyIDEMainForm.SetCurrentPos(Editor : IEditor; ALine: integer);
Var
  ActiveEditor : IEditor;
begin
  ActiveEditor := GetActiveEditor;
  if not Assigned(ActiveEditor) then Exit;  //No editors!

  if (not Assigned(Editor) or (ActiveEditor = Editor)) and (fCurrentLine > 0) then
    // Remove possible current lines
    with ActiveEditor.SynEdit do begin
      InvalidateGutterLine(fCurrentLine);
      InvalidateLine(fCurrentLine);
    end;

  fCurrentLine := ALine;  // Store
  if not Assigned(Editor) then Exit;

  if Editor <> ActiveEditor then
    Editor.Activate;

  with Editor.SynEdit do begin
    if (ALine > 0) and (CaretY <> ALine) then begin
      CaretXY := BufferCoord(1, ALine);
      EnsureCursorPosVisible;
    end;
    InvalidateGutterLine(ALine);
    InvalidateLine(ALine);
  end;
end;

procedure TPyIDEMainForm.DebuggerCurrentPosChange(Sender: TObject);
begin
  if (PyControl.ActiveDebugger <> nil) and not PyControl.IsRunning then
    SetCurrentPos(PyControl.CurrentPos.Editor , PyControl.CurrentPos.Line)
  else
    SetCurrentPos(PyControl.CurrentPos.Editor, -1);
end;

procedure TPyIDEMainForm.DebuggerErrorPosChange(Sender: TObject);
{
  Invalidates old and/or new error line but does not Activate the Editor
}
var
  Editor : IEditor;
begin
  Editor := GetActiveEditor;
  if not Assigned(Editor) then Exit;  //No editors!

  if (not Assigned(PyControl.ErrorPos.Editor) or (PyControl.ErrorPos.Editor = Editor)) and
    (fErrorLine > 0)
  then
    // Remove possible error line
    Editor.SynEdit.InvalidateLine(fErrorLine);

  fErrorLine := PyControl.ErrorPos.Line;  // Store
  if (Editor = PyControl.ErrorPos.Editor) and (PyControl.ErrorPos.Line > 0) then
    Editor.SynEdit.InvalidateLine(PyControl.ErrorPos.Line);
end;

procedure TPyIDEMainForm.DebuggerStateChange(Sender: TObject; OldState,
  NewState: TDebuggerState);
var
  s: string;
begin
  case NewState of
    dsRunning,
    dsRunningNoDebug: begin
                        s := 'Running';
                        Screen.Cursor := crHourGlass;
                        StatusLED.ColorOn := clRed;
                      end;
    dsPaused: begin
                s := 'Paused';
                Screen.Cursor := crDefault;
                StatusLED.ColorOn := clRed;
                StatusLED.ColorOn := clYellow;
              end;
    dsInactive: begin
                 s := 'Ready';
                 Screen.Cursor := crDefault;
                 StatusLED.ColorOn := clLime;
               end;
  end;
  StatusLED.Hint := s;
  StatusBar.Panels[0].Caption := ' ' + s;
  StatusBar.Refresh;

  CallStackWindow.UpdateWindow(NewState);
  WatchesWindow.UpdateWindow(NewState);
  UpdateDebugCommands(NewState);
end;

procedure TPyIDEMainForm.DebuggerYield(Sender: TObject; DoIdle : Boolean);
begin
  Application.ProcessMessages;
  // HandleMessage calls Application.Idle which yields control to other applications
  if DoIdle then
    // HandleMessage calls Application.Idle which yields control to other applications
    // and calls CheckSynchronize which runs synchronized methods initiated in threads
    //Application.HandleMessage
    Application.DoApplicationIdle
  else
    CheckSynchronize;
end;

procedure TPyIDEMainForm.SaveFileModules;
var
  i : integer;
  FileCommands : IFileCommands;
begin
  for i := 0 to GI_EditorFactory.Count -1 do
    if (GI_EditorFactory[i].FileName <> '') and GI_EditorFactory[i].Modified then begin
      FileCommands := GI_EditorFactory[i] as IFileCommands;
      if Assigned(FileCommands) then
        FileCommands.ExecSave;
    end;
end;

procedure TPyIDEMainForm.ApplicationOnIdle(Sender: TObject; var Done: Boolean);
Var
  i : integer;
begin
  UpdateStandardActions;
  CommandsDataModule.UpdateMainActions;
  UpdateStatusBarPanels;
  UpdateDebugCommands(PyControl.DebuggerState);
  for i := 0 to EditorsPageList.PageCount - 1 do
    if i < TabBar.Tabs.Count then
      TabBar.Tabs[i].Modified :=
        TEditorForm(TJvStandardPage(TabBar.Tabs[i].Data).Components[0]).GetEditor.Modified;
  for i := 0 to EditorViewsMenu.Count - 1 do
    EditorViewsMenu.Items[i].Enabled := Assigned(GI_ActiveEditor);
  if Assigned(GI_ActiveEditor) then
    TEditorForm(GI_ActiveEditor.Form).DoOnIdle;

  // If a Tk or Wx remote engine is active pump up event handling
  // This is for processing input output coming from event handlers
  if (PyControl.ActiveInterpreter is TPyRemoteInterpreter) and
     (PyControl.DebuggerState = dsInactive)
  then
    with(TPyRemoteInterpreter(PyControl.ActiveInterpreter)) do begin
      if IsConnected and (ServerType in [stTkinter, stWxPython]) then
        ServeConnection;
    end;
  Done := True;
end;

procedure TPyIDEMainForm.ApplicationOnHint(Sender: TObject);
begin
  WriteStatusMsg(GetLongHint(Application.Hint));
end;

procedure TPyIDEMainForm.ApplcationOnShowHint(var HintStr: string;
  var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if HintInfo.HintControl is TBaseVirtualTree then
    HintInfo.HideTimeout := 5000;
end;

function TPyIDEMainForm.ShowFilePosition(FileName: string; Line,
  Offset: integer; ForceToMiddle : boolean = True): boolean;
Var
  Edit