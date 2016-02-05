//
//  NVDataSource.h
//  Anvil
//
//  Created by Elliott Kember on 31/07/2012.
//  Copyright (c) 2012 Riot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVApp.h"

@interface NVDataSource : NSObject

@property (strong, readonly, nonatomic) NSMutableArray *apps;
@property (strong, readonly, nonatomic) NSMutableArray *hammerApps;
@property (strong, readonly, nonatomic) NSMutableArray *phpApps;

- (void)readInSavedAppDataFromDisk;
+ (NVDataSource *)sharedDataSource;
- (NVApp *)addAppWithURL:(NSURL *)url;
- (void)removeApp:(NVApp *)appToRemove;
- (NVApp *)findAppWithURL:(NSURL *)url;
- (NSInteger)indexOfAppWithURL:(NSURL *)url;
- (NSInteger *)numberOfHammerSites;
- (NSInteger *)numberOfPhpSites;

@end
