//
//  ViewController.swift
//  MyWorkList
//
//  Created by kalimi venkata vijay vardhan on 09/12/17.
//  Copyright © 2017 kalimi venkata vijay vardhan. All rights reserved.
//

import UIKit

class MyWorkListViewController: UITableViewController, ItemDetailViewDelegate {
    
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailV) {
        
        navigationController?.popViewController(animated: true)
    
    }
    
    func ItemDetailViewController(_ controller: ItemDetailV, didFinishAdding item: MyWorkListItem) {
        
        let newRowIndex = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    
    }
    
    func ItemDetailViewController(_ controller: ItemDetailV, didFinishEditing item: MyWorkListItem) {
        
        if let index = items.index(of: item){
            let indexPath = IndexPath(row : index , section : 0)
            if let cell = tableView.cellForRow(at: indexPath){
                configureText(for: cell, with: item)
                navigationController?.popViewController(animated: true)
                
            }
        }
        
    }
   
    
    var items : [MyWorkListItem]
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        
        print("added item")
        let newRowIndex = items.count
        let item = MyWorkListItem()
        var titles = ["LaLiga 2018","fifa 2019","ICC world cup 2019","hockey cup 23","imdb top 10"]
        let randomNumber = arc4random_uniform(UInt32(titles.count))
        item.text = titles[Int(randomNumber)]
        item.checkedState = true
        items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        items.remove(at: indexPath.row)
        tableView.reloadData()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        
         items = [MyWorkListItem]()
         let row0Item = MyWorkListItem()
         row0Item.text = "walk the dog"
         row0Item.checkedState = false
         items.append(row0Item)
        
         let row1Item = MyWorkListItem()
         row1Item.text = "eat the cake"
         row1Item.checkedState = false
         items.append(row1Item)
        
         let row2Item = MyWorkListItem()
         row2Item.text = "soccer cricket"
         row2Item.checkedState = false
         items.append(row2Item)
        
         let row3Item = MyWorkListItem()
         row3Item.text = "iOS Development"
         row3Item.checkedState = false
         items.append(row3Item)
        
         let row4Item = MyWorkListItem()
         row4Item.text = "break the ice"
         row4Item.checkedState = false
         items.append(row4Item)
        
         super.init(coder: aDecoder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem"{
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
        }else if segue.identifier == "EditItem"{
            let controller = segue.destination as! ItemDetailV
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
          
            let item = items[indexPath.row]
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyWorkListItem", for: indexPath)
        let item = items[indexPath.row]
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureText( for cell:UITableViewCell,with item : MyWorkListItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    func configureCheckmark( for cell : UITableViewCell, with item : MyWorkListItem){
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checkedState{
            label.text = "✔️"
        }else{
            label.text = " "
        }
    }
}

