//
//  Extensions_UIImage.swift
//  BelieveApp
//
//  Created by Marcos Rollón Rivas on 3/5/19.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
    
    /// SwifterSwift: Size in bytes of UIImage
    var bytesSize: Int {
        return jpegData(compressionQuality: 1)?.count ?? 0
    }
    
    /// SwifterSwift: Size in kilo bytes of UIImage
    var kilobytesSize: Int {
        return bytesSize / 1024
    }
    
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(size.width, size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0 && radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let rect = CGRect(origin: .zero, size: size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        draw(in: rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // Images of the project
    // It's ok to force unwrap, if some image is not there it should crash
    static let financeTypeImage         : UIImage = UIImage(named: "finance_type_image")!
    static let personalTypeImage        : UIImage = UIImage(named: "personal_type_image")!
    static let otherTypeImage           : UIImage = UIImage(named: "other_type_image")!
    static let workTypeImage            : UIImage = UIImage(named: "work_type_image")!
    static let homeIcon                 : UIImage = UIImage(named: "home_icon")!
    static let addButtonIcon            : UIImage = UIImage(named: "add_button_icon")!
    static let chillNatureWallpaper     : UIImage = UIImage(named: "chill_nature")!
    static let chillCampfireWallpaper   : UIImage = UIImage(named: "chill_campfire")!
    static let chillOceanWallpaper      : UIImage = UIImage(named: "chill_ocean")!
    static let notesIcon                : UIImage = UIImage(named: "notes_icon")!
    static let logoutIcon               : UIImage = UIImage(named: "logout_icon")!
    static let menuIcon                 : UIImage = UIImage(named: "menu_icon")!
    static let settingsIcon             : UIImage = UIImage(named: "settings_icon")!
    static let trashIcon                : UIImage = UIImage(named: "trash_icon")!
    static let leftArrowIcon            : UIImage = UIImage(named: "left_arrow_icon")!
    static let superuserIcon            : UIImage = UIImage(named: "superuser_icon")!
    static let userIcon                 : UIImage = UIImage(named: "user_icon")!
    static let changeIcon               : UIImage = UIImage(named: "change_icon")!
}
