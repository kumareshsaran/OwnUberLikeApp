//
//  LocationSearchTableViewController.swift
//  User
//
//  Created by CSS on 25/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit
import PopMenu
import GooglePlaces

class LocationSearchTableViewController: UIViewController {
    
    private var searchBgView = UIView()
    private let fevImageData = [#imageLiteral(resourceName: "home-icon"),#imageLiteral(resourceName: "work")]
    private let fevTitle = [Constants.string.home.localize(),Constants.string.work.localize()]
    // let manager = PopMenuManager.default
    
    lazy private var searchController : UISearchBar = {
        let search = UISearchBar()
        search.placeholder = Constants.string.searchYourAddress.localize()
        search.tintColor = #colorLiteral(red: 0.2039215686, green: 0.4705882353, blue: 0.9647058824, alpha: 1)
        if #available(iOS 13.0, *) {
            search.barTintColor = .systemBackground
            search.backgroundColor = .systemBackground
            search.searchTextField.backgroundColor = .systemBackground
        } else {
            search.barTintColor = .white
            search.backgroundColor = .white // Fallback on earlier versions
        }
        let bgImage = UIImageView()
        if #available(iOS 13.0, *) {
            bgImage.backgroundColor = .clear
        } else {
            bgImage.backgroundColor = .clear// Fallback on earlier versions
        }
        search.backgroundImage = bgImage.image
        
        return search
    }()
    
   lazy private var tableviewAutoComplete : UITableView = {
        let tableview = UITableView(frame: CGRect.zero, style: .grouped)
        return tableview
    }()
    
    private var googlePlacesHelper : GooglePlacesHelper?
    
    private var datasource = [GMSAutocompletePrediction]() {  // Predictions List
        didSet {
            DispatchQueue.main.async {
                print("Reloaded")
                self.tableviewAutoComplete.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConstraint()
        setNavigationBar()
        
        self.tableviewAutoComplete.register(UINib(nibName: XIB.Names.FevortiesTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.FevortiesTableViewCell)
        self.googlePlacesHelper = GooglePlacesHelper()
        
        self.searchController.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.systemFont(ofSize: 12)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.systemFont(ofSize: 12)
    }
    
    private func setConstraint(){
        
        view.addSubview(self.searchBgView)
        self.searchBgView.addSubview(self.searchController)
        self.view.addSubview(self.tableviewAutoComplete)
        
        self.searchBgView.translatesAutoresizingMaskIntoConstraints = false
        self.searchController.translatesAutoresizingMaskIntoConstraints = false
        self.tableviewAutoComplete.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            
            NSLayoutConstraint.activate([self.searchBgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),self.searchBgView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),self.searchBgView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),self.searchBgView.heightAnchor.constraint(equalToConstant: 60)])
            
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            self.searchBgView.backgroundColor = .systemBackground
        } else {
            self.searchBgView.backgroundColor = .white// Fallback on earlier versions
        }
        
        NSLayoutConstraint.activate(
            [self.searchController.leadingAnchor.constraint(equalTo: self.searchBgView.leadingAnchor, constant: 16),self.searchController.trailingAnchor.constraint(equalTo: self.searchBgView.trailingAnchor, constant: -16),self.searchController.heightAnchor.constraint(equalToConstant: 20),self.searchController.centerXAnchor.constraint(equalTo: self.searchBgView.centerXAnchor, constant: 0),self.searchController.centerYAnchor.constraint(equalTo: self.searchBgView.centerYAnchor, constant: 0)])
        
        NSLayoutConstraint.activate(
            [self.tableviewAutoComplete.topAnchor.constraint(equalTo: searchBgView.bottomAnchor, constant: 0),self.tableviewAutoComplete.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),self.tableviewAutoComplete.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),self.tableviewAutoComplete.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)])
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = UIColor.systemBackground
        } else {
            // Fallback on earlier versions
            self.view.backgroundColor = UIColor.white
        }
        
        
        // self.navigationItem.titleView = searchController
        self.tableviewAutoComplete.delegate = self
        self.tableviewAutoComplete.dataSource = self
    }
    
    private func getPredications(from string : String?){
        
        self.googlePlacesHelper?.getAutoComplete(with: string, with: { (predictions) in
            
            for data in predictions{
                
                print(data)
            }
            self.datasource = predictions
        })
        
    }
    
    private func setNavigationBar(){
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "Set location"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .plain, target: self, action: #selector(backAction))
        
    }
    
    @IBAction func backAction(){
        //   self.popOrDismiss(animation: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func popMenuTextAndImage() -> PopMenuViewController {
        let actions = [
            // PopMenuDefaultAction(title: Constants.string.edit.localize(), image: #imageLiteral(resourceName: "Edit")),
            PopMenuDefaultAction(title: Constants.string.delete.localize(), image: #imageLiteral(resourceName: "Delete")),
            ]
        
        let popMenu = PopMenuViewController(actions: actions)
        popMenu.delegate = self
        return popMenu
    }
    
}

extension LocationSearchTableViewController {
    private func setData(indexPath: IndexPath)-> UITableViewCell{
        switch indexPath.section {
        case 0:
            let cell = tableviewAutoComplete.dequeueReusableCell(withIdentifier: XIB.Names.FevortiesTableViewCell, for: indexPath) as! FevortiesTableViewCell
            cell.setFevData(title: self.fevTitle[indexPath.row], addressValue: "Chennai International Airport (MAA), GST Rd, Meenambakkam, Chennai, Tamil Nadu", titleImage: self.fevImageData[indexPath.row])
            return cell
        case 1:
            if  let cell = tableviewAutoComplete.dequeueReusableCell(withIdentifier: XIB.Names.FevortiesTableViewCell, for: indexPath) as? FevortiesTableViewCell{
                cell.setFevData(title: "\(self.datasource[indexPath.row].attributedPrimaryText.string)" , addressValue: "\(self.datasource[indexPath.row].attributedFullText.string)", titleImage: #imageLiteral(resourceName: "placeholder"))
                return cell
            }
        default:
            break;
        }
        return UITableViewCell()
    }
}

extension LocationSearchTableViewController : PopMenuViewControllerDelegate {
    
    func popMenuDidSelectItem(_ popMenuViewController: PopMenuViewController, at index: Int) {
        
    }
}

extension LocationSearchTableViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.getPredications(from: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchController.endEditing(true)
    }
    
}

extension LocationSearchTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.datasource.count > 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.setData(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HeaderSection()
        let headerTitle = section == 0 ? Constants.string.fevroties.localize() : Constants.string.address.localize()
        header.setTitle(title: headerTitle)
        if #available(iOS 13.0, *) {
            header.backgroundColor = UIColor.systemBackground
        } else {
            header.backgroundColor = UIColor.systemGray// Fallback on earlier versions
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //present(self.popMenuTextAndImage(), animated: true, completion: nil)
        
    }
    
}
