#import "EpubKittyPlugin.h"
#import <epub_kitty_lib/epub_kitty_lib-Swift.h>

@implementation EpubKittyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEpubKittyPlugin registerWithRegistrar:registrar];
}
@end
