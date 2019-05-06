//
//  yourTripsViewController.swift
//  User
//
//  Created by CSS on 07/04/19.
//  Copyright © 2019 Appoets. All rights reserved.
//

import UIKit

class yourTripsViewController: UIViewController {

    @IBOutlet weak var buttonPast: UIButton!
    @IBOutlet weak var buttonUpcoming: UIButton!
    
    @IBOutlet weak var tableViewYoueTrips: UITableView!
    @IBOutlet weak var viewUnderLine: UIView!
    
    @IBOutlet weak var viewUnderLineWidthConstraint: NSLayoutConstraint!
    var isPastTripSelected: Bool = true {
        didSet {

            let buttonFrame = self.isPastTripSelected ? self.buttonPast : self.buttonUpcoming
            UIView.animate(withDuration: 1, animations: {
            
                
                self.viewUnderLine.center.x =  (buttonFrame?.center.x)!
                self.viewUnderLineWidthConstraint.constant = 100
            }) { (sucess) in


            }
            
            
        }
    }
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: [Constants.string.past.localize(), Constants.string.upcoming.localize()])
        sc.selectedSegmentIndex = 0
       // sc.tintColor = .default
        sc.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilaLoad()
        // Do any additional setup after loading the view.
        self.tableViewYoueTrips.register(UINib(nibName: XIB.Names.YourTripsTableViewCell, bundle: nil), forCellReuseIdentifier: XIB.Names.YourTripsTableViewCell)
        
    }
    
    @objc fileprivate func handleSegmentChange() {
//        print(segmentedControl.selectedSegmentIndex)
//
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            //rowsToDisplay = games
//        case 1:
//            //rowsToDisplay = tvShows
//        default:
//            //rowsToDisplay = devices
//        }
//
//       // tableView.reloadData()
    }
    
    private func initilaLoad(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isPastTripSelected = true
        }
        
        setNavigation()
    }
    
    @IBAction func buttonUpcomingAction(_ sender: Any) {
        self.isPastTripSelected = false
    }
    @IBAction func ButtoNPastAsction(_ sender: Any) {
        self.isPastTripSelected = true
    }
    
    private func setNavigation(){
    
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = Constants.string.yourTrips.localize()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow1"), style: .done, target: self, action: #selector(menuAction(sender:)))
        
        let paddedStackView = UIStackView(arrangedSubviews: [segmentedControl])
        paddedStackView.layoutMargins = .init(top: 12, left: 12, bottom: 6, right: 12)
        paddedStackView.isLayoutMarginsRelativeArrangement = true
        
        let stackView = UIStackView(arrangedSubviews: [
            paddedStackView
            ])
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
      // stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .zero)
        
        NSLayoutConstraint.activate([stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)])
        
        

    }
    
    @IBAction func menuAction(sender : UIBarButtonItem){
        if sender == self.navigationItem.leftBarButtonItem {
            self.popOrDismiss(animation: true)
        }else{
            print("save")
        }
    }
}

extension yourTripsViewController : UITableViewDelegate {
    
    
}
extension yourTripsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: XIB.Names.YourTripsTableViewCell, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(id: Storyboard.Ids.YourTripsDetailViewController, animation: true)
    }
    
    
}
