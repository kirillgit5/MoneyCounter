//
//  BetaPurchasesCategoryCollectionView.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 07.07.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class BetaPurchasesCategoryCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK : - Private Propetyes
    private var puchases = DataManager.shared.moneyCategoryes
    
     init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        register(BetaPurchasesCollectionViewCell.self, forCellWithReuseIdentifier: BetaPurchasesCollectionViewCell.reuseId)
        backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(puchases.count)
        return puchases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BetaPurchasesCollectionViewCell.reuseId, for: indexPath)
        return cell
    }
    
    
}
