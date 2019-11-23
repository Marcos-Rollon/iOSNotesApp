//
//  NoteCellType.swift
//  Notes
//
//  Created by Marcos Rollón Rivas on 16/11/2019.
//  Copyright © 2019 Marcos Rollón Rivas. All rights reserved.
//

import UIKit

class NoteCellType {
    let title : String
    let content : String
    var typeImage : UIImage {
        didSet{
            
        }
    }
    let date : String{
        
    }
    var isFavorited : Bool
}
