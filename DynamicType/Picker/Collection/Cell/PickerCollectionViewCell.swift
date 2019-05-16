//
//  PickerCollectionViewCell.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class PickerCollectionViewCell: UICollectionViewCell {
    
    static var font: UIFont {
        return UIFont.preferredFont(forTextStyle: .body)
    }
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.font = PickerCollectionViewCell.font
    }
    
    override var isSelected: Bool {
        didSet {
            self.label.textColor = isSelected ? self.tintColor : .black
        }
    }
}
