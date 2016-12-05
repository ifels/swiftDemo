//
//  NBRobotoFont.swift
//  Pods
//
//  Created by Torstein Skulbru on 10.06.15.
//
//

private class FontLoader {
    class func loadFont(_ name: String) {
        let bundle = Bundle(for: FontLoader.self)
        let fontURL = bundle.url(forResource: name, withExtension: "ttf")
        
        let data = try! Data(contentsOf: fontURL!)
        
        let provider = CGDataProvider(data: data as CFData)
        let font = CGFont(provider!)
        
        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            let errorDescription: CFString = CFErrorCopyDescription(error!.takeUnretainedValue())
            let nsError = error!.takeUnretainedValue() as AnyObject as! NSError
            NSException(name: NSExceptionName.internalInconsistencyException, reason: errorDescription as String, userInfo: [NSUnderlyingErrorKey: nsError]).raise()
        }
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block: (Void)->Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        _onceTracker.append(token)
        block()
    }
}

public extension UIFont {
    public class func robotoMediumOfSize(_ fontSize: CGFloat) -> UIFont {
        struct Static {
            static var onceToken =  NSUUID().uuidString
        }
        
        let name = "Roboto-Medium"
        if (UIFont.fontNames(forFamilyName: name).count == 0) {
            DispatchQueue.once(token: Static.onceToken) {
                FontLoader.loadFont(name)
            }
        }
        
        return UIFont(name: name, size: fontSize)!
    }
    
    public class func robotoRegularOfSize(_ fontSize: CGFloat) -> UIFont {
        struct Static {
            static var onceToken =  NSUUID().uuidString
        }
        
        let name = "Roboto-Regular"
        if (UIFont.fontNames(forFamilyName: name).count == 0) {
            DispatchQueue.once(token: Static.onceToken) {
                FontLoader.loadFont(name)
            }
        }
        
        return UIFont(name: name, size: fontSize)!
    }
    
}
