//
//  AddItemViewController.swift
//  MyWorkList
//
//  Created by kalimi venkata vijay vardhan on 11/12/17.
//  Copyright © 2017 kalimi venkata vijay vardhan. All rights reserved.
//

import UIKit
protocol ItemDetailViewDelegate : class {
    func ItemDetailViewControllerDidCancel(_ controller : ItemDetailV)
    func ItemDetailViewController(_ controller : ItemDetailV, didFinishAdding item : MyWorkListItem)
    func ItemDetailViewController(_ controller : ItemDetailV, didFinishEditing item : MyWorkListItem)
}

class ItemDetailV: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    weak var delegate : ItemDetailViewDelegate?
    var itemToEdit : MyWorkListItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit{
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }
    

    @IBOutlet weak var textField: UITextField!
    @IBAction func cancel(){
        navigationController?.popViewController(animated: true)
        delegate?.ItemDetailViewControllerDidCancel(self)
    }
    @IBAction func done(){
        if let itemToEdit = itemToEdit{
            itemToEdit.text = textField.text!
            delegate?.ItemDetailViewController(self, didFinishEditing: itemToEdit)
        }else{
        let item = MyWorkListItem()
        item.text = textField.text!
        item.checkedState = false
        delegate?.ItemDetailViewController( self , didFinishAdding : item)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range,in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty{
            doneBarButton.isEnabled = false
        }else{
            doneBarButton.isEnabled = true
        }
    return true
}
}
