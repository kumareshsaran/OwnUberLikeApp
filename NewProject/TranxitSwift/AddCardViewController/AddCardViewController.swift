//
//  AddCardViewController.swift
//  User
//
//  Created by CSS on 12/05/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {

    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewCards: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigation()
        
        self.tableViewCards.register(UINib(nibName: XIB.Names.AddCardTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.AddCardTableViewCell)
        self.tableViewCards.delegate = self
        self.tableViewCards.dataSource = self
        
        //self.addKeyBoardObserver(with: self.buttonBottomConstraint)
        self.buttonBottomConstraint.constant = 220
        self.view.layoutIfNeeded()
    }

}
extension AddCardViewController {
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backAction))
        self.title = Constants.string.payment.localize()
        
    }
    
    @IBAction func backAction(){
        self.popOrDismiss(animation: true)
    }
}

extension AddCardViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.AddCardTableViewCell, for: indexPath) as? AddCardTableViewCell{
            
             return cell
        }
        
       return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.string.addCard.localize()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
}

