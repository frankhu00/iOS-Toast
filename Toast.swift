//
//  Toast.swift
//  Snaps
//
//  Created by Frank Hu on 11/3/16.
//  Copyright © 2016 Sugarcube. All rights reserved.
//

import UIKit

open class Toast: UILabel {
    
    
    
    //
    //
    // Public Variables and Methods
    //
    //
    
    
    
    //Array of active toasts
    public static var toastList = [Toast]()
    
    
    //
    // Public Functions
    //
    
    
    //Func used to test if any Toast is active (dies after fade out)
    //Runs completion handler after toast becomes inactive
    public static func isActive(delay: Double = 0.5, completion: @escaping () -> ()) {
        if Toast.toastList.isEmpty {
            completion()
        } else {
            UtilityClass.delay(delay) {
                Toast.isActive {
                    completion()
                }
            }
        }
    }

    //Toast a message
    public static func alert(message: String, duration: Double = Animation.activeDuration, speed: Double = Animation.fadeSpeed, style: ToastStyle = ToastStyle()) -> Toast {
        
        var toast = Toast(frame: CGRect(
            x: 0,
            y: 0,
            width: style.maxWidth,
            height: 20.0
        ))
        
        //Saves active toast to toastList
        toastList.append(toast)
        
        toast = Toast.setupToast(toast: toast, message: message, style: style)
        toast.animate(active: duration, speed: speed)
        
        return toast
    }
    
    
    //Removes all current active toasts from superview
    public static func removeAllToasts() {
        Toast.toastList.forEach( { $0.removeFromSuperview() } )
    }
    
    
    
    //
    //
    // Private Variables and Functions
    //
    //
    
    
    
    //Default settings
    private struct Animation {
        static let fadeSpeed        : Double    = 1.0
        static let activeDuration   : Double    = 1.0
    }
    
    
    //
    // Private methods
    //
    
    
    //Setup Toast properties
    private static func setupToast(toast: Toast, message: String, style: ToastStyle) -> Toast {
        
        toast.textAlignment = .center
        toast.baselineAdjustment = .alignCenters
        toast.textColor = style.textColor
        toast.font = toast.font.withSize(style.fontSize)

        toast.text = message
        toast.lineBreakMode = style.lineBreakMode
        toast.numberOfLines = style.numberOfLines
        
        var tempFrameSize = toast.sizeThatFits(toast.frame.size)
        tempFrameSize.height = tempFrameSize.height + style.padding
        tempFrameSize.width = tempFrameSize.width + style.padding
        
        toast.frame.size = tempFrameSize
        
        toast.layer.zPosition = CGFloat.greatestFiniteMagnitude
        toast.layer.cornerRadius = style.cornerRadius
        toast.clipsToBounds = true

        toast.backgroundColor = style.backColor
        toast.layer.borderColor = style.borderColor?.cgColor
        toast.layer.borderWidth = style.borderWidth
        
        toast.setPosition(position: style.centerAt)
        
        return toast
    }
    
    //Defines toast position
    private func setPosition(position: ToastStyle.ToastPosition) {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let heightCorrection = self.bounds.height/2
        
        switch position {
        case .top:
            self.center = CGPoint(x: width/2, y: heightCorrection + 20)
        case .center:
            self.center = CGPoint(x: width/2, y: height/2)
        case .bottom:
            self.center = CGPoint(x: width/2, y: height - heightCorrection - 20)
        case .positionAt(let point):
            self.center = point
        }
    }
    
    //Clean up method (runs after fadeOut completes)
    private static func cleanUp(toast: Toast) {
        toast.removeFromSuperview()
        
        if let expiredToast = Toast.toastList.index(of: toast) {
            Toast.toastList.remove(at: expiredToast)
        }
    }
    
    //Animating toast
    private func animate(active: Double, speed: Double) {
        
        //Note: active means the duration of Toast staying at full alpha.
        //      speed means the speed of the fade in / fade out animation
        //      Both are default to 1 sec
        
        self.alpha = 0.0
        
        Toast.fadeTo(view: self, alpha: 1.0, duration: speed, delay: 0.0) {
            Toast.fadeTo(view: self, alpha: 0.0, duration: speed, delay: active) {
                Toast.cleanUp(toast: self)
            }
            
        }
    }
    
    //Fading Animation
    private static func fadeTo(view: Toast, alpha: CGFloat, duration: Double, delay: Double = 0.0, completion: (() -> ())? = nil) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            view.alpha = alpha
        }, completion: {(value : Bool) in
            if let callback = completion {
                callback()
            }
        })
    }
    

}

open class ToastStyle {
    
    public var textColor = UIColor.white
    public var backColor = UIColor(
        red: 105/255,
        green: 105/255,
        blue: 105/255,
        alpha: 1.0
    )
    public var borderColor : UIColor?
    public var borderWidth : CGFloat = 0.0
    public var padding : CGFloat = 20.0
    public var fontSize : CGFloat = 15.0
    public var cornerRadius  : CGFloat = 20.0
    public var maxWidth = UIScreen.main.bounds.width * 0.75
    public var centerAt : ToastPosition = .center
    public var numberOfLines = 0
    public var lineBreakMode = NSLineBreakMode.byWordWrapping
    
    public enum ToastPosition {
        case top
        case center
        case bottom
        case positionAt(CGPoint)
    }
    
}


public class UtilityClass : NSObject {
    
    //Sets delay
    public static func delay(_ delay:Double, closure: @escaping () -> ()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
    
}
