#import <UIKit/UIKit.h>
#import <Cordova/CDVPlugin.h>
#import "iCloud.h"

@interface CDViCloudDocument : CDVPlugin
{

}

- (void)test:(CDVInvokedUrlCommand*)command;
- (void)setContainer:(CDVInvokedUrlCommand*)command;
- (void)checkFile:(CDVInvokedUrlCommand*)command;
- (void)uploadFile:(CDVInvokedUrlCommand*)command;
- (void)retriveFile:(CDVInvokedUrlCommand*)command;
- (void)listDocuments:(CDVInvokedUrlCommand*)command;
// @property (readonly, assign) BOOL isRunning;
// @property (nonatomic, strong) NSString* callbackId;
//
// - (CDViCloudDocument*)init;
//
// - (void)start:(CDVInvokedUrlCommand*)command;
// - (void)stop:(CDVInvokedUrlCommand*)command;

@end
