
#import "CDViCloudDocument.h"
#import "iCloud.h"

@implementation CDViCloudDocument

// - (void)setiCloudDocumentContainer:(CDVInvokedUrlCommand*)command{
//
//     CDVPluginResult* pluginResult = nil;
//     NSString* container = [command.arguments objectAtIndex:0];
//
//     if (container != nil) {
// 		[[iCloud sharedCloud] setupiCloudDocumentSyncWithUbiquityContainer:@"iCloud.br.com.meubolsoemdia.Meunegocioemdia"];
//     }
// }
//
//
// - (void)listDocuments:(CDVInvokedUrlCommand*)command{
//     // Check command.arguments here.
// 	NSArray *documentList = [[iCloud sharedCloud] listCloudFiles];
//
//     [self.commandDelegate runInBackground:^{
//
//     	if (documentList.count == 0)
//     	{
//
//     	}
//
//         NSString* payload = nil;
//         // Some blocking logic...
//         CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
//         // The sendPluginResult method is thread-safe.
//         [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//     }];
// }


// - (CDVAccelerometer*)init
// {
//     self = [super init];
//     if (self) {
//         self.x = 0;
//         self.y = 0;
//         self.z = 0;
//         self.timestamp = 0;
//         self.callbackId = nil;
//         self.isRunning = NO;
//         self.haveReturnedResult = YES;
//         self.motionManager = nil;
//     }
//     return self;
// }

- (void)uploadFile:(CDVInvokedUrlCommand*)command{

  CDVPluginResult* pluginResult = nil;
  NSString* fileName = [command.arguments objectAtIndex:0];

  if (fileName != nil) {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];


    NSData *textData = [NSData dataWithContentsOfFile:filePath];


    [[iCloud sharedCloud] saveAndCloseDocumentWithName:fileName
                                       withContent:textData
                                        completion:^(UIDocument *cloudDocument, NSData *documentData, NSError *error) {

                                            if (error == nil) {

                                              CDVPluginResult* pluginResult = [CDVPluginResult
                                                                        resultWithStatus:CDVCommandStatus_OK
                                                                        messageAsString:@"File saved to iCloud"];

                                              [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

                                            }
                                            else
                                            {
                                              CDVPluginResult* pluginResult = [CDVPluginResult
                                                                        resultWithStatus:CDVCommandStatus_OK
                                                                        messageAsString:@"Error saving to iCloud"];

                                              [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
                                            }
                                        }];

  } else {

      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"FileName was null"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }



}

- (void)retriveFile:(CDVInvokedUrlCommand*)command{

  CDVPluginResult* pluginResult = nil;
  NSString* fileName = [command.arguments objectAtIndex:0];

  if (fileName != nil) {

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];

    [[iCloud sharedCloud] retrieveCloudDocumentWithName:fileName completion:^(UIDocument *cloudDocument, NSData *documentData, NSError *error) {
      if (!error) {
          NSString *fileName = [cloudDocument.fileURL lastPathComponent];
          NSData *fileData = documentData;

          [fileData writeToFile:filePath atomically:YES];

          CDVPluginResult* pluginResult = [CDVPluginResult
                                    resultWithStatus:CDVCommandStatus_OK
                                    messageAsString:@"File writed to Documents"];

          [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
      }
      else
      {
        CDVPluginResult* pluginResult = [CDVPluginResult
                                  resultWithStatus:CDVCommandStatus_OK
                                  messageAsString:@"Error Retriving File from iCloud"];
          [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
      }
    }];

  } else {

      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"FileName was null"];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }
}


- (void)checkFile:(CDVInvokedUrlCommand*)command{

    CDVPluginResult* pluginResult = nil;
    NSString* fileName = [command.arguments objectAtIndex:0];

    if (fileName != nil) {

      BOOL fileExists = [[iCloud sharedCloud] doesFileExistInCloud:fileName];

      if (fileExists == YES) {
        pluginResult = [CDVPluginResult
                        resultWithStatus:CDVCommandStatus_OK
                        messageAsString:@"File Exists"];
      }
      else
      {
        pluginResult = [CDVPluginResult
                        resultWithStatus:CDVCommandStatus_ERROR
                        messageAsString:@"File Not Exists in iCloud"];

      }

    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Container name was null"];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)setContainer:(CDVInvokedUrlCommand*)command{

    CDVPluginResult* pluginResult = nil;
    NSString* containerName = [command.arguments objectAtIndex:0];

    if (containerName != nil) {

        [[iCloud sharedCloud] setupiCloudDocumentSyncWithUbiquityContainer:containerName];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Container name was null"];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)listDocuments:(CDVInvokedUrlCommand*)command{

  CDVPluginResult* pluginResult = nil;
  NSArray *tempArray=[[iCloud sharedCloud] listCloudFiles];

  if (tempArray.count != 0) {

      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray: tempArray];
  } else {
      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Container has no Objects"];
  }

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)test:(CDVInvokedUrlCommand*)command
{

    NSString* name = [[command arguments] objectAtIndex:0];
    NSString* msg = [NSString stringWithFormat: @"geremias, %@", name];

    CDVPluginResult* result = [CDVPluginResult
                               resultWithStatus:CDVCommandStatus_OK
                               messageAsString:msg];

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
