//
//  PaymentViewController.swift
//  User
//
//  Created by CSS on 15/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {

    @IBOutlet weak var tableViewPayment: UITableView!
    
    var paymnetArray = [(#imageLiteral(resourceName: "cash"),Constants.string.cash.localize()),(#imageLiteral(resourceName: "salary"),Constants.string.card.localize()),(UIImage(),Constants.string.addCard.localize())]
    var savedCards = [(#imageLiteral(resourceName: "credit-card"),".... 8479"),(#imageLiteral(resourceName: "credit-card"),".... 1435")]
    var selectedIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backAction))
        self.title = Constants.string.payment.localize()
        
    }
    
    @IBAction func backAction(){
        self.popOrDismiss(animation: true)
    }
    
}

extension PaymentViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.paymnetArray.count : self.savedCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.PaymentTableViewCell, for: indexPath) as! PaymentTableViewCell
         cell.accessoryType = .disclosureIndicator
        if indexPath.section == 0 {
            if indexPath.row == paymnetArray.count - 1 {
                cell.imagePaymentType.image = paymnetArray[indexPath.row].0
                cell.labelPaymentType.text = paymnetArray[indexPath.row].1
                cell.labelPaymentType.textAlignment = .center
                cell.labelPaymentType.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }else{
                cell.imagePaymentType.image = paymnetArray[indexPath.row].0
                cell.labelPaymentType.text = paymnetArray[indexPath.row].1
                cell.accessoryType = self.selectedIndex == indexPath.row ? .checkmark : .disclosureIndicator
                
            }
        }else if indexPath.section == 1 {
                cell.imagePaymentType.image = savedCards[indexPath.row].0
                cell.labelPaymentType.text = savedCards[indexPath.row].1
               // cell.accessoryType = self.selectedIndex == indexPath.row ? .checkmark : .disclosureIndicator
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.selectedIndex = indexPath.row
            self.tableViewPayment.reloadData()
            if indexPath.row == self.paymnetArray.count - 1 {
                self.push(id: Storyboard.Ids.AddCardViewController, animation: true)
            }
        }else{
            
        }
       
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? Constants.string.paymentMenthod.localize() : Constants.string.savedCard.localize()
    }
    
    
}

