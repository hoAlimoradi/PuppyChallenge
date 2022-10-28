//
//  extension+UIColor.swift
//  PuppyChallenge
//
//  Created by Hosein Alimoradi .
//
//
 

import Foundation
import UIKit
//MARK:- Color
extension UIColor {
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        return UIColor.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    static let defaultOuterColor = UIColor.rgb(56, 25, 49)
    static let defaultInnerColor: UIColor = .rgb(234, 46, 111)
    static let defaultPulseFillColor = UIColor.rgb(86, 30, 63)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red) / 255.0,
                  green: CGFloat(green) / 255.0,
                  blue: CGFloat(blue) / 255.0,
                  alpha: alpha)
    }
}
extension UIColor {
   /// For converting Hex-based colors
   convenience init(hex: String) {
       var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
       hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
       var rgb: UInt64 = 0

       var r: CGFloat = 0.0
       var g: CGFloat = 0.0
       var b: CGFloat = 0.0
       var a: CGFloat = 1.0
       
       let length = hexSanitized.count
       Scanner(string: hexSanitized).scanHexInt64(&rgb)
       
       if length == 6 {
           r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
           g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
           b = CGFloat(rgb & 0x0000FF) / 255.0
           
       } else if length == 8 {
           r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
           g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
           b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
           a = CGFloat(rgb & 0x000000FF) / 255.0
       }
       self.init(red: r, green: g, blue: b, alpha: a)
   }
}

extension UIColor {
   convenience init(hex:String, alpha:Float = 1.0) {
       var al = alpha
       // Remove # prefix, if used
       var tmp = hex.hasPrefix("#") ? String(hex[hex.index(after:hex.startIndex)...]) : hex
       // Handle standard HTML colours such as black, white etc.
       let colours = ["black":"000000", "white":"FFFFFF", "red":"FF0000", "cyan":"00FFFF", "blue":"0000FF", "purple":"800080", "yellow":"FFFF00", "lime":"00FF00", "magenta":"FF00FF", "silver":"C0C0C0", "green":"008000", "olive":"808000"]
       if let buf = colours[tmp] {
           tmp = buf
       }
       // Set a default of black (in case the string is invalid)
       var strR = "0"
       var strG = "0"
       var strB = "0"
       let cnt = tmp.count
       // Is this a 3 digit hex string?
       var from = tmp.startIndex
       if cnt == 3 {
           var to = tmp.index(after:from)
           strR = String(tmp[from..<to])
           from = tmp.index(after:from)
           to = tmp.index(after:from)
           strG = String(tmp[from..<to])
           from = tmp.index(after:from)
           to = tmp.index(after:from)
           strB = String(tmp[from..<to])
       }
       // Handle 6 digit hex string
       if cnt >= 6 {
           var to = tmp.index(from, offsetBy:2)
           strR = String(tmp[from..<to])
           from = to
           to = tmp.index(from, offsetBy:2)
           strG = String(tmp[from..<to])
           from = to
           to = tmp.index(from, offsetBy:2)
           strB = String(tmp[from..<to])
           if cnt == 8 {
               from = to
               to = tmp.index(from, offsetBy:2)
               let str = String(tmp[from..<to])
               var a: UInt64 = 0
               Scanner(string:str).scanHexInt64(&a)
               al = Float(a) / 255.0
           }
       }
       // Convert strings to Int values
   var r: UInt64 = 0
   var g: UInt64 = 0
   var b: UInt64 = 0
       Scanner(string:strR).scanHexInt64(&r)
       Scanner(string:strG).scanHexInt64(&g)
       Scanner(string:strB).scanHexInt64(&b)
       let rf = Float(r) / 255.0
       let gf = Float(g) / 255.0
       let bf = Float(b) / 255.0
//        println("Final values r:\(rf), g:\(gf), b:\(bf)")
       self.init(red:CGFloat(rf), green:CGFloat(gf), blue:CGFloat(bf), alpha:CGFloat(al))
   }
   
   @objc public class func from(hex:String)->UIColor {
       return UIColor(hex:hex, alpha:1.0)
   }
   
   var hexString:String {
       let colorSpace = cgColor.colorSpace!.model
       var r:Float = 0
       var g:Float = 0
       var b:Float = 0
       var a:Float = 0
       if let comps = cgColor.components {
           if colorSpace == CGColorSpaceModel.monochrome {
               r = Float(comps[0])
               g = Float(comps[0])
               b = Float(comps[0])
               a = Float(comps[1])
           } else if colorSpace == CGColorSpaceModel.rgb {
               r = Float(comps[0])
               g = Float(comps[1])
               b = Float(comps[2])
               a = Float(comps[3])
           }
       }
       return String(format:"#%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
   }
}


// Foundation
extension Double {
   
   func clean(places: Int) -> String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.\(places)f", self)
   }
}


extension UIColor {
   convenience init(rgb: UInt) {
       self.init(
           red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
           green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
           blue: CGFloat(rgb & 0x0000FF) / 255.0,
           alpha: CGFloat(1.0)
       )
   }
}
extension UIColor {
 
 convenience init(_ hex: String, alpha: CGFloat = 1.0) {
   var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
   
   if cString.hasPrefix("#") { cString.removeFirst() }
   
   if cString.count != 6 {
     self.init("ff0000") // return red color for wrong hex input
     return
   }
   
   var rgbValue: UInt64 = 0
   Scanner(string: cString).scanHexInt64(&rgbValue)
   
   self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
             alpha: alpha)
 }

}


