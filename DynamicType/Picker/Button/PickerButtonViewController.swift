//
//  PickerButtonViewController.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class PickerButtonViewController: UIViewController, Storyboardable, PickerControllerProtocol {

    weak var datasource: PickerDatasource?
    weak var delegate: PickerDelegate?
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
    }
    
    @IBAction func showItems(_ sender: UIButton) {
        guard let datasource = datasource else {
            return
        }
        
        let alertController = UIAlertController(title: "Опции",
                                                message: nil,
                                                preferredStyle: .actionSheet)
        
        for item in datasource.items {
            let action = UIAlertAction(title: item,
                                       style: .default) { [unowned self] alertAction in
                                        self.selectItemManually(item)
            }
            
            alertController.addAction(action)
        }
        
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
}

extension PickerButtonViewController {
    private func selectItemManually(_ item: String) {
        selectItem(item)
        delegate?.pickerControllerDidSelectItem(self, item: item)
    }
    
    func selectItem(_ item: String) {
        button.setTitle(item, for: .normal)
    }
}

extension PickerButtonViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        button.setNeedsLayout() // otherwise button's titleLabel gets clipped on size changes
    }
}
