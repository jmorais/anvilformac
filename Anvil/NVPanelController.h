#import "NVBackgroundView.h"
#import "NVStatusItemView.h"
#import "NVDataSource.h"
#import "NVStyledView.h"
#import "NVLabel.h"
#import "NVSwitchView.h"
#import "NVStyledButton.h"
#import "CustomLoadingSpinner.h"
#import "NVSiteTableView.h"

@class NVPanelController;

@protocol NVPanelControllerDelegate <NSObject>

@optional

- (NVStatusItemView *)statusItemViewForPanelController:(NVPanelController *)controller;
- (BOOL)isPowInstalled;
- (CGRect)globalMenubarViewFrame;

@end

#pragma mark -

@interface NVPanelController : NSWindowController <NSWindowDelegate, NSTableViewDelegate, NSTextFieldDelegate, NVSwitchDelegate, NSOpenSavePanelDelegate, NVStatusItemViewDelegate> {
    BOOL _hasActivePanel;
    __unsafe_unretained NVBackgroundView *_backgroundView;
    __unsafe_unretained id<NVPanelControllerDelegate> _delegate;
    __unsafe_unretained NSSearchField *_searchField;
    __unsafe_unretained NSTextField *_textField;
}

@property (weak, nonatomic) IBOutlet NVSiteTableView *appListTableView;
@property (nonatomic, unsafe_unretained) IBOutlet NVBackgroundView *backgroundView;
@property (nonatomic, unsafe_unretained) IBOutlet NSSearchField *searchField;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *textField;
@property (nonatomic, unsafe_unretained) IBOutlet NSScrollView *appListTableScrollView;
@property (nonatomic, unsafe_unretained) IBOutlet NVStyledView *headerView;
@property (nonatomic, unsafe_unretained) IBOutlet NVStyledView *headerIconView;
@property (nonatomic, unsafe_unretained) IBOutlet NVLabel *switchLabel;
@property (weak, nonatomic) IBOutlet NVSwitchView *switchView;
@property (weak, nonatomic) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSTextField *welcomeLabel;

@property (weak, nonatomic) IBOutlet CustomLoadingSpinner *installingPowSpinner;



@property (weak, nonatomic) IBOutlet NSPopUpButton *settingsButton;
@property (weak, nonatomic) IBOutlet NVStyledView *settingsDivider;

@property (nonatomic, unsafe_unretained) IBOutlet NVStyledView *welcomeView;
@property (nonatomic, unsafe_unretained) IBOutlet NVStyledView *noAppsView;
@property (nonatomic, unsafe_unretained) IBOutlet NVStyledButton *noSitesAddASiteButton;
@property (nonatomic, unsafe_unretained) IBOutlet NVStyledButton *installPowButton;

@property (nonatomic, unsafe_unretained) IBOutlet NVLabel *welcomePanelHeader;
@property (nonatomic, unsafe_unretained) IBOutlet NVLabel *welcomePanelFirstLine;
@property (nonatomic, unsafe_unretained) IBOutlet NVLabel *welcomePanelSecondLine;

@property (nonatomic) BOOL hasActivePanel;
@property (nonatomic, unsafe_unretained) id<NVPanelControllerDelegate> delegate;

//- (id)initWithDelegate:(id<NVPanelControllerDelegate>)delegate;

- (void)openPanel;
- (void)closePanel;
- (NSRect)statusRect;
- (NSMenu *)buildSettingsMenu;
- (void)beginEditingRowAtIndex:(NSNumber *)index;

- (IBAction)didClickRestartButton:(id)sender;
- (IBAction)didClickAddButton:(id)sender;
- (IBAction)didClickInstallPowButton:(id)sender;
- (IBAction)didClickReallyDeleteButton:(id)sender;

@end
