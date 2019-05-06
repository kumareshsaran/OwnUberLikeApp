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
    
    var paymnetArray = [(#imageLiteral(resourceName: "cash"),Constants.string.cash.localize()),(#imageLiteral(resourceName: "debit-card"),Constants.string.card.localize())]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigation()
    }
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backAction))
        self.title = Constants.string.payment.localize()
        
    }
    
    @IBAction func backAction(){
        
    }
    
    
    

}

extension PaymentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.paymnetArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.PaymentTableViewCell, for: indexPath) as! PaymentTableViewCell
        cell.imagePaymentType.image = paymnetArray[indexPath.row].0
        cell.labelPaymentType.text = paymnetArray[indexPath.row].1
        return cell
    }
    
    
}

