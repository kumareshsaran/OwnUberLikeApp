//
//  PickerView.swift
//  Geordana User
//
//  Created by CSS on 08/07/18.
//  Copyright © 2018 Appoets. All rights reserved.
//

import UIKit

class PickerView: UIView {

    @IBOutlet private var pickerView : UIPickerView!
    @IBOutlet private var labelTitle : UILabel!
    @IBOutlet private var buttonCancel : UIButton!
    @IBOutlet var datePickerView: UIDatePicker!
    
    private var dataSource = [String]()
    
    var onClickItem : ((Int)->Void)?
    var onClickCancel : (()->Void)?
    
    
    var getdateValue : ((String)-> Void)?
    var dateCancel : (()-> Void)?
    
    
    let datePicker = UIDatePicker()
    
    var textField = UITextField()
    
    var selectedDateFormate : UIDatePickerMode?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.buttonCancel.addTarget(self, action: #selector(self.buttonCancelAction), for: .touchUpInside)
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        self.localize()
        self.setDesign()
    }
}

// MARK:- Methods

extension PickerView {
    
    // Setting Picker DataSource
    func set(dataSource : [String]) {
        self.dataSource = dataSource
        self.pickerView.reloadAllComponents()
    }
    
    func setdatePicker(datePickerMode: UIDatePickerMode, mindate: Date, maxdate: Date, textfied: UITextField){
        datePicker.datePickerMode = datePickerMode
        datePicker.minimumDate = mindate
        showdatePicker(textfiled: textfied)
        self.selectedDateFormate = datePickerMode
        
    }
    
    func showdatePicker(textfiled: UITextField){
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: Constants.string.Done.localize(), style: .done, target: self, action: #selector(datepickerDoneButtonPressed))
        doneButton.tintColor = UIColor.red
        let cancelButton = UIBarButtonItem(title: Constants.string.Cancel.localize(), style: .plain, target: self, action: #selector(dateCancelButtonTapped))
        cancelButton.tintColor = UIColor.red
        let spaceBUtton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        toolBar.setItems([doneButton,spaceBUtton,cancelButton], animated: true)
        
        self.textField = textfiled
        textfiled.inputAccessoryView = toolBar
        textfiled.inputView = datePicker
    }
    
    @IBAction func datepickerDoneButtonPressed(){
        let formater = DateFormatter()
        if self.selectedDateFormate == UIDatePickerMode.time {
            formater.timeStyle = .short
        }else {
            formater.dateFormat = DateFormat.list.dd_mm_yyyy
        
        }
        getdateValue?(formater.string(from: datePicker.date))
        self.textField.endEditing(true)
        
    }
    
    @IBAction func dateCancelButtonTapped(){
        dateCancel?()
        self.textField.endEditing(true)
    }
    // Cancel Button Action
    @IBAction private func buttonCancelAction() {
        self.onClickCancel?()
    }
    
    // Localize
    
    private func localize() {
      //   self.labelTitle.text = Constants.string.pickerTitle.localize()
     //    self.buttonCancel.setTitle(Constants.string.Cancel.localize(), for: .normal)
        
        self.labelTitle.text = "Done"
        self.buttonCancel.setTitle ("Cancel", for: .normal)

    }
    
    // Design
    
    private func setDesign() {
        
        Common.setFont(to: labelTitle, isTitle: true)
        Common.setFont(to: buttonCancel)
    }
    
}

// MARK:- UIPickerViewDelegate

extension PickerView : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        if self.dataSource.count > row {
            return self.dataSource[row]
        }
        return nil
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        onClickItem?(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
        
    }
    
}



