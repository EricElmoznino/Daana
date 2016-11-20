//
//  MainPageViewController.swift
//  Daana
//
//  Created by Eric Elmoznino on 2016-10-12.
//  Copyright © 2016 Eric Elmoznino. All rights reserved.
//

import UIKit
import MapKit

class MainPageViewController: UIViewController, LocationHandlerDelegate {
    
    // MARK: Initialization
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var footerView: FooterView!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var showListArrow: UIImageView!
    @IBOutlet weak var donationInfo: UILabel!
    
    var footerViewIsHalfway = false {
        didSet{
            footerViewIsHalfway ? transitionFooterHalfway() : transitionFooterCompact()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listButton.alpha = 0.0
        listButton.isHidden = true
        showListArrow.image = UIImage(named: "Arrow Icon")?.withRenderingMode(.alwaysTemplate)
        showListArrow.tintColor = listButton.titleLabel?.textColor
        showListArrow.alpha = 0.0
        showListArrow.isHidden = true
        
        donateButton.horizontalAnchor = donateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -27)
        
        amountButton = TextCircleButton(radius: 35, red: true, text: "$5")
        amountButton.addTarget(self, action: #selector(didTapAmountButton(_:)), for: .touchUpInside)
        radiusButton = TextCircleButton(radius: 35, red: true, text: "2km")
        radiusButton.addTarget(self, action: #selector(didTapRadiusButton(_:)), for: .touchUpInside)
        
        locationHandler.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

    // MARK: Actions
    
    @IBAction func didTapDonateButton(_ sender: AnyObject) {
        print("donating")
    }
    
    @IBAction func didTapListButton(_ sender: AnyObject) {
        print("open list")
    }
    
    @IBAction func didTapFooterView(_ sender: AnyObject) {
        if !footerViewIsHalfway {
            footerViewIsHalfway = true
        }
    }
    
    @IBAction func didTapOutsideFooterView(_ sender: AnyObject) {
        if footerViewIsHalfway {
            footerViewIsHalfway = false
        }
    }
    
    func didTapAmountButton(_ sender: AnyObject) {
        print("chaging amount")
    }
    
    func didTapRadiusButton(_ sender: AnyObject) {
        print("chaging radius")
    }
    
    // MARK: Footer Animation
    
    let transitionTime = 0.2
    let transitionDistance: CGFloat = 80
    @IBOutlet weak var donateButton: DonateButton!
    @IBOutlet weak var footerViewDistance: NSLayoutConstraint!
    @IBOutlet weak var donateTopDistance: NSLayoutConstraint!
    var amountButton: TextCircleButton!
    var radiusButton: TextCircleButton!
    
    func transitionFooterCompact() {
        restoreSecondaryButtons()
        donationInfo.isHidden = false
        footerViewDistance.constant += transitionDistance
        donateTopDistance.constant -= transitionDistance
        toggleDonatePosition()
        UIView.animate(withDuration: transitionTime,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.listButton.alpha = 0.0
                        self.showListArrow.alpha = 0.0
                        self.donationInfo.alpha = 1.0
                        self.view.layoutIfNeeded()
        }) { _ in
            self.listButton.isHidden = true
            self.showListArrow.isHidden = true
            self.amountButton.removeFromSuperview()
            self.radiusButton.removeFromSuperview()
        }
    }
    
    func transitionFooterHalfway() {
        insertAndMoveSecondaryButtons()
        listButton.isHidden = false
        showListArrow.isHidden = false
        footerViewDistance.constant -= transitionDistance
        donateTopDistance.constant += transitionDistance
        toggleDonatePosition()
        UIView.animate(withDuration: transitionTime,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
                        self.listButton.alpha = 1.0
                        self.showListArrow.alpha = 1.0
                        self.donationInfo.alpha = 0.0
                        self.view.layoutIfNeeded()
            }) { _ in
                self.donationInfo.isHidden = true
        }
    }
    
    func toggleDonatePosition() {
        if footerViewIsHalfway {
            donateButton.horizontalAnchor = donateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        } else {
            donateButton.horizontalAnchor = donateButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -27)
        }
    }
    
    func restoreSecondaryButtons() {
        amountButton.horizontalAnchor = amountButton.centerXAnchor.constraint(equalTo: donateButton.centerXAnchor)
        radiusButton.horizontalAnchor = radiusButton.centerXAnchor.constraint(equalTo: donateButton.centerXAnchor)
    }

    
    func insertAndMoveSecondaryButtons() {
        footerView.insertSubview(amountButton, belowSubview: donateButton)
        amountButton.translatesAutoresizingMaskIntoConstraints = false
        amountButton.centerYAnchor.constraint(equalTo: donateButton.centerYAnchor).isActive = true
        amountButton.horizontalAnchor = amountButton.centerXAnchor.constraint(equalTo: donateButton.centerXAnchor)
        
        footerView.insertSubview(radiusButton, belowSubview: donateButton)
        radiusButton.translatesAutoresizingMaskIntoConstraints = false
        radiusButton.centerYAnchor.constraint(equalTo: donateButton.centerYAnchor).isActive = true
        radiusButton.horizontalAnchor = radiusButton.centerXAnchor.constraint(equalTo: donateButton.centerXAnchor)
        
        view.layoutIfNeeded()
        amountButton.horizontalAnchor = amountButton.rightAnchor.constraint(equalTo: self.donateButton.leftAnchor, constant: -28)
        radiusButton.horizontalAnchor = radiusButton.leftAnchor.constraint(equalTo: self.donateButton.rightAnchor, constant: 28)
    }
    
    // MARK: Charities in range
    // TODO: Keep the map centered on the user location unless they drag. Have a button to relock onto the user location if they have dragged away.
    // TODO: Create the map annotations
    // TODO: When the user wants to show the list of charities, initialize the list page with the charities whose ids are in one of the annotations id's. As an alternative, maybe initialize the page with the charities in the desired location/range. It's a question of which function to use from the charities repository.
    var charitiesRepository = CharitiesRepository()
    var locationHandler = LocationHandler()
    var trackingUser = true
    var range = 5
    var displayedCharities: [Charity] = []  // TODO: Change to be just an array of the map annotations for the charity, where every annotation will just have the id, and be initialized with the charity objects fetched from the repository. Will use a translator class to do this instead of doing the translation in the view controller. We will only do this update if the charities have changed.
    
    func locationDidUpdate() {
        if trackingUser {
            displayedCharities = charitiesRepository.getCharities(
                inRange: range,
                fromLocation: mapView.userLocation.location)
            print(displayedCharities)
        }
    }
}
