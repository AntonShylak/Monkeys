//
//  ViewController.swift
//  Monkeys
//
//  Created by Sergey Shinkarenko on 22.06.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TABLA: UITableView!
    @IBOutlet weak var pickedMonkeyLabel: UILabel!
    @IBOutlet weak var selectedMonkeyTextField: UITextField!
    var monkeysList: [String] = []
    let picker = UIPickerView()

    func toolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(title: "Done",
                                   style: .done,
                                   target: self,
                                   action: #selector(selectItem))
        toolbar.setItems([done],
                         animated: false)
        return toolbar
    }

    @objc func selectItem() {
        selectedMonkeyTextField.text = "\(picker.selectedRow(inComponent: 0) + 1) " + monkeysList[picker.selectedRow(inComponent: 1)]
        selectedMonkeyTextField.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        monkeysList = Parser.singletone.parseNamesFromJSON()?.list ?? []

        picker.delegate = self
        picker.dataSource = self

        selectedMonkeyTextField.inputView = picker
        selectedMonkeyTextField.inputAccessoryView = toolbar()
        
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monkeysList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var strkoca = monkeysList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CELL") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = strkoca
        return cell
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 10
        case 1:
            return monkeysList.count
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(row + 1)"
        case 1:
            return monkeysList[row]
        default:
            return ""
        }
    }
}


    

