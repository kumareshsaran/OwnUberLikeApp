//
//  CountryCodeSelectionViewController.swift
//  User
//
//  Created by CSS on 09/06/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

protocol CountrySelectionDelegate {
    func selectedCountry(country : Country)
}

class CountryCodeSelectionViewController: UIViewController {
    
    var tableViewCountryCode = UITableView()
    
    private var countryCodes = [Country]()
    
    private var filterDataSource = [Country]()
    
    var countryDelegate : CountrySelectionDelegate?
    
    var search = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setConstraint()
        setNavigation()
        getCountryCode()
       
    }
    
    private func setNavigation(){
        self.navigationController?.isNavigationBarHidden = false
        search = UISearchController(searchResultsController: nil)
        search.dimsBackgroundDuringPresentation = false
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.delegate = self
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back-icon"), style: .done, target: self, action: #selector(backButtonAction))
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
             self.navigationController?.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .automatic
            self.title = Constants.string.selectCountry.localize()
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func backButtonAction(){
        self.popOrDismiss(animation: true)
    }
    
    private func getCountryCode(){
        let countryCode = Common.getCountries()
        self.countryCodes = countryCode
        self.filterDataSource = countryCode
        print(self.countryCodes)
    }
 
    
    private func setConstraint(){
        self.view.addSubview(self.tableViewCountryCode)
        
        self.tableViewCountryCode.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableViewCountryCode.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableViewCountryCode.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableViewCountryCode.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableViewCountryCode.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            ])
        
        self.tableViewCountryCode.register(UINib(nibName: XIB.Names.CountryCodeTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.CountryCodeTableViewCell)
        self.tableViewCountryCode.delegate = self
        self.tableViewCountryCode.dataSource = self
    }

}
//MARK:- UITableViewDelegate

extension CountryCodeSelectionViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let countryCode = tableView.dequeueReusableCell(withIdentifier: XIB.Names.CountryCodeTableViewCell, for: indexPath) as? CountryCodeTableViewCell  {
            countryCode.setdata(data: self.filterDataSource[indexPath.row])
            return countryCode
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countryDelegate?.selectedCountry(country: self.filterDataSource[indexPath.row])
        self.search.dismiss(animated: true) {
            self.popOrDismiss(animation: true)
        }
        self.popOrDismiss(animation: true)
        
       
    }
    
    
    
}

//MARK:- UISearchControllerDelegate
extension CountryCodeSelectionViewController : UISearchControllerDelegate , UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        filterDataSource = countryCodes.filter({ ($0.name+$0.code+$0.dial_code).lowercased().contains(searchText.lowercased())})
        print(filterDataSource.count)
        if filterDataSource.count <= 0 {
            self.filterDataSource = countryCodes
        }
        self.tableViewCountryCode.reloadData()
        
    }
}
