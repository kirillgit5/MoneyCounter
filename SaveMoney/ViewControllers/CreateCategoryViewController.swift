//
//  CreateCategoryViewController.swift
//  SaveMoney
//
//  Created by Кирилл Крамар on 18.08.2020.
//  Copyright © 2020 Кирилл Крамар. All rights reserved.
//

import UIKit

class CreateCategoryViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IB Outlets
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var iconButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    @IBOutlet var borderView: UIView!
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var colorView: UIView!
    
    //MARK: - Public Property
    var categoriesType: CategoriesType!
    
    //MARK: - Private Property
    private var iconName = "default"
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        switch categoriesType {
        case .moneyCategory:
            infoLabel.text = "Новая категория доходов"
            view.backgroundColor = .systemYellow
            nameTextField.backgroundColor = .systemYellow
            amountTextField.backgroundColor = .systemYellow
            nameTextField.delegate = self
            amountTextField.delegate = self
            colorView.backgroundColor = .systemYellow
        case .purchasesCategory:
            infoLabel.text = "Новая категория расходов"
            amountTextField.isHidden = true
            view.backgroundColor = .systemGreen
            nameTextField.backgroundColor = .systemGreen
            colorView.backgroundColor = .systemGreen
            nameTextField.delegate = self
            nameTextField.returnKeyType = .done
        case .none:
            break
        }
        
        iconImageView.image = UIImage(named: iconName)
        colorView.layer.borderColor = UIColor.systemGray.cgColor
        colorView.layer.borderWidth = 3
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        colorView.layer.cornerRadius = colorView.frame.width/2
        iconButton.layer.cornerRadius = iconButton.frame.width/2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let chooseIconVC = segue.destination as! ChooseIconCollectionViewController
        chooseIconVC.categoryType = categoriesType
        chooseIconVC.delegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    //MARK: IB Actions
    @IBAction func cancel() {
        dismiss(animated: true)
    }
    
    @IBAction func addCategory() {
        switch categoriesType {
        case .moneyCategory:
            if let name = nameTextField.text, !name.isEmpty {
                if let amountText = amountTextField.text, let amount = Double(amountText) {
                    let moneyCategory = CategoryCreator.shared.createCategory(categoryType: .moneyCategory,
                                                                              name: name,
                                                                              iconName: iconName,
                                                                              startAmount: amount)
                    StorageManager.shared.save(category: moneyCategory)
                } else {
                    let moneyCategory = CategoryCreator.shared.createCategory(categoryType: .moneyCategory,
                                                                              name: name,
                                                                              iconName: iconName)
                    StorageManager.shared.save(category: moneyCategory)
                }
            } else {
                showAlert(title: "Внимание", message: "Введите название категории")
            }
            
        case .purchasesCategory:
            if let name = nameTextField.text, !name.isEmpty {
                let purchasesCategory = CategoryCreator.shared.createCategory(categoryType: .purchasesCategory,
                                                                              name: name,
                                                                              iconName: iconName)
                StorageManager.shared.save(category: purchasesCategory)
            } else {
                showAlert(title: "Внимание", message: "Введите название категории")
            }
        default:
            break
        }
        dismiss(animated: true)
    }
    
    @IBAction func chooseIconForCategoryName() {
        performSegue(withIdentifier: SegueIndentifire.chooseIconForCategory.rawValue, sender: nil)
    }
    
    private func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert,animated: true)
    }
    
    
}

extension CreateCategoryViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if categoriesType == .moneyCategory {
            if textField === nameTextField {
                amountTextField.becomeFirstResponder()
            }
        } else {
            nameTextField.resignFirstResponder()
        }
        return true
    }
}

extension CreateCategoryViewController: ChooseIconDelegate {
    func addIconName(name: String) {
        iconImageView.image = UIImage(named: name)
        iconName = name
    }
}
