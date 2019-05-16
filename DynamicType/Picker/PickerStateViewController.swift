//
//  PickerStateViewController.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class PickerStateViewController: StateViewController, PickerDatasource {
    
    private enum State {
        case collection, button
    }
    
    private var state: State = .collection {
        didSet {
            if state != oldValue {
                update(for: state)
            }
        }
    }

    lazy var items: [String] = {
        var items = [String]()
        
        let itemsCount = 10
        
        for _ in 0...itemsCount {
            let item = Int.random(in: 1...100).stringRepresentation
            items.append(item)
        }
        return items
    }()
    
    lazy var selectedItem: String = items.first!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update(for: state)
        updateStateForCurrentContentSizeCategory()
    }

    private func update(for state: State) {
        let controller = viewController(for: state)
        updateController(with: controller)
        
        controller.datasource = self
        controller.delegate = self
        
        controller.selectItem(selectedItem)
    }
    
    private func viewController(for state: State) -> PickerControllerProtocol {
        switch state {
        case .collection:
            return collectionController
        case .button:
            return buttonController
        }
    }
    
    private lazy var collectionController = PickerCollectionViewController.instantiateInitialFromStoryboard()
    private lazy var buttonController = PickerButtonViewController.instantiateInitialFromStoryboard()
}

extension PickerStateViewController: PickerDelegate {
    func pickerControllerDidSelectItem(_ pickerController: PickerControllerProtocol, item: String) {
        let title = "Выбрали айтем «\(item)»"
        let alertController = UIAlertController(title: title,
                                                message: nil,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "ОК",
                                          style: .default,
                                          handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController,
                     animated: true,
                     completion: nil)
        
        selectedItem = item
    }
}

extension PickerStateViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateStateForCurrentContentSizeCategory()
    }
    
    private func updateStateForCurrentContentSizeCategory() {
        updateState(with: traitCollection.preferredContentSizeCategory)
    }
    
    private func updateState(with contentSizeCategory: UIContentSizeCategory) {
        state = contentSizeCategory.isAccessibilityCategory ? .button : .collection
    }
}

protocol PickerDatasource: class {
    var items: [String] { get }
}

protocol PickerDelegate: class {
    func pickerControllerDidSelectItem(_ pickerController: PickerControllerProtocol, item: String)
}

protocol PickerControllerProtocol where Self: UIViewController {
    var datasource: PickerDatasource? { get set }
    var delegate: PickerDelegate? { get set }
    
    func selectItem(_ item: String)
}
