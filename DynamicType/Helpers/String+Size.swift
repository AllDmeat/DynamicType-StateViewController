//
//  String+Size.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

extension String {
    
    func size(limit: CGFloat, font: UIFont) -> CGSize {
        let sizeLimit = CGSize(width: limit, height: CGFloat.greatestFiniteMagnitude)
        return size(limit: sizeLimit, font: font)
    }
    
    func size(limit: CGSize, font: UIFont) -> CGSize {
        guard self.count > 0 else {
            // No space for empty string
            return CGSize.zero
        }
        
        let boundingRect = self.boundingRect(with: limit,
                                             options: [.usesLineFragmentOrigin, .usesFontLeading],
                                             attributes: [.font: font],
                                             context: nil)
        
        return boundingRect.size.integral
    }
}

extension CGSize {
    var integral: CGSize {
        return CGSize(width: ceil(self.width),
                      height: ceil(self.height))
    }
}
