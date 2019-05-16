//
//  PickerCollectionViewController.swift
//  DynamicType
//
//  Created by Алексей Берёзка on 15/05/2019.
//  Copyright © 2019 Алексей Берёзка. All rights reserved.
//

import UIKit

class PickerCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, Storyboardable, PickerControllerProtocol {
    
    weak var datasource: PickerDatasource?
    weak var delegate: PickerDelegate?
    
    lazy var cellNibName = String(describing: PickerCollectionViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    private func registerCells() {
        let nib = UINib.init(nibName: cellNibName, bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: cellNibName)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource != nil ? 1 : 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource?.items.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellNibName, for: indexPath) as! PickerCollectionViewCell
    
        cell.label.text = datasource?.items[indexPath.row]
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let text = datasource?.items[indexPath.item] else {
            return .zero
        }
        
        let font = PickerCollectionViewCell.font
        let size = text.size(limit: .greatestFiniteMagnitude, font: font)
        return size
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = self.datasource?.items[indexPath.item] else {
            return
        }
        
        delegate?.pickerControllerDidSelectItem(self, item: item)
    }

}

extension PickerCollectionViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension PickerCollectionViewController {
    func selectItem(_ item: String) {
        guard let itemIndex = self.datasource?.items.firstIndex(of: item) else {
            return
        }
        
        let indexPath = IndexPath.init(item: itemIndex,
                                       section: 0)
        
        self.collectionView.selectItem(at: indexPath,
                                       animated: true,
                                       scrollPosition: .centeredHorizontally)
    }
}
