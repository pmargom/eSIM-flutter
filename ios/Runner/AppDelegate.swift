import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let esimChannel = FlutterMethodChannel(name: "samples.flutter.dev/esim", binaryMessenger: controller.binaryMessenger)
        
        esimChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: FlutterResult) in
            if call.method == "launchESimSetup" {
                if let args = call.arguments as? [String: Any],
                   let activationCode = args["activationCode"] as? String {
                    self?.launchESimSetup(activationCode: activationCode)
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func launchESimSetup(activationCode: String) {
        let content = "https://esimsetup.apple.com/esim_qrcode_provisioning?carddata=\(activationCode)"
        
        if let url = URL(string: content) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: { success in
                    if success {
                        print("Successfully opened eSIM setup")
                    } else {
                        print("Failed to open eSIM setup")
                    }
                })
            } else {
                print("Cannot open eSIM setup URL")
            }
        } else {
            print("Invalid eSIM setup URL")
        }
    }
}
