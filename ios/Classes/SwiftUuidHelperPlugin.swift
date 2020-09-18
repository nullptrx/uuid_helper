import Flutter
import UIKit

private let kChannelName = "nullptrx.github.io/uuid_helper"

public class SwiftUuidHelperPlugin: NSObject, FlutterPlugin {
 public static func register(with registrar: FlutterPluginRegistrar) {
         let channel = FlutterMethodChannel(name: kChannelName, binaryMessenger: registrar.messenger())
         let instance = SwiftUuidHelperPlugin()
         registrar.addMethodCallDelegate(instance, channel: channel)
     }

     public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
         if call.method == "getUniqueId" {
             let keyChain = KeyChain()
             let uuid = generateUUID(keyChain)
             result(uuid)
         } else {
             result(FlutterMethodNotImplemented)
         }
     }

     private func generateUUID(_ keyChain: KeyChain) -> String {
         let uuid: String

         if keyChain.contains(kChannelName) {
             guard let value: String = keyChain.value(for: kChannelName) else {
                 _ = keyChain.remove(kChannelName)
                 uuid = generateUUID(keyChain)
                 return uuid
             }
             uuid = value
         } else {
             uuid = UUID().uuidString
             keyChain.setValue(uuid, for: kChannelName)
         }
         return uuid
     }
}
