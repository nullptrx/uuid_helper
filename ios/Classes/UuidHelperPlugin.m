#import "UuidHelperPlugin.h"
#if __has_include(<uuid_helper/uuid_helper-Swift.h>)
#import <uuid_helper/uuid_helper-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uuid_helper-Swift.h"
#endif

@implementation UuidHelperPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUuidHelperPlugin registerWithRegistrar:registrar];
}
@end
