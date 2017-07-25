//
//  PayAngelFonts.swift
//  paymobile
//
//  Created by James Amo on 21/06/2016.
//  Copyright © 2016 PayAngel. All rights reserved.
//

import UIKit

public enum FontSelectType : String {
    case ProMedium = "GarageFonts - FreightText Pro Medium"
    case BrandonTextblack = "HVD Fonts - BrandonText-Black"
    case bold = "Roboto-Bold"
    case LarsseitBold = "Type Dynamic - Larsseit Bold"
    case LarsseitExtraBold = "Type Dynamic - Larsseit ExtraBold"
    case light = "Roboto-Light"
    case LarsseitItalic = "Type Dynamic - Larsseit Italic"
    case LarsseitMedium = "Type Dynamic - Larsseit Medium"
    case Larsseit = "Type Dynamic - Larsseit"
}

public struct MaterialFont {
    
    public static func fontWithSize(offontType: FontSelectType, size: CGFloat) -> UIFont{
        let fontname = offontType.rawValue
        if let font = UIFont.init(name: fontname, size: size){
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
    public static func light (with : CGFloat) -> UIFont{
        return fontWithSize(offontType: .light, size: with)
    }
}
public class MyFont {
    class func light (with : CGFloat) -> UIFont{
        return MaterialFont.light(with: with)
    }
}
enum UIUserInterfaceIdiom : Int
{
    case Unspecified
    case Phone
    case Pad
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}
