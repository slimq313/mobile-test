//
//  RestaurantController.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-14.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class DetailController: UIViewController, Reusable, UITableViewDelegate, UITableViewDataSource {

    var selectedItem = String()
    
    var placeTitle = [String]()
    var decriptionText = [String]()
    
    
    //
    //MARK:- Override
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getRestuarantInfos()
        getVacationInfos()
        // Do any additional setup after loading the view.
    }
    
    //
    //MARK:- Operations
    //
    
    func getRestuarantInfos() {
        
        guard selectedItem == selectedCounts.restuarant.rawValue else {
            return
        }
        
        do {
            if let file = Bundle.main.url(forResource: "restaurants", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let array = object as? [[String: Any]] {
                        //If you want array of task id you can try like
                        let titleNames = array.flatMap { $0["title"] as? String }
                        let decription = array.flatMap { $0["description"] as? String }
                        
                        let title = titleNames as [String]
                        let placeDecription = decription as [String]
                        
                        for placeName in title {
                            placeTitle.append(placeName)
                        }
                        
                        for desc in placeDecription {
                            decriptionText.append(desc)
                        }
                        
                        print(titleNames)
                    }
                    
                }
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    func getVacationInfos() {
        
        guard selectedItem == selectedCounts.vacationSpots.rawValue else {
            return
        }
        
        do {
            if let file = Bundle.main.url(forResource: "vacation-spot", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                if let object = json as? [Any] {
                    // json is an array
                    print(object)
                    
                    if let array = object as? [[String: Any]] {
                        //array of task id 
                        let titleNames = array.flatMap { $0["title"] as? String }
                        let decription = array.flatMap { $0["description"] as? String }
                        
                        let title = titleNames as [String]
                        let placeDecription = decription as [String]
                        
                        for placeName in title {
                            placeTitle.append(placeName)
                        }
                        
                        for desc in placeDecription {
                            decriptionText.append(desc)
                        }
                        
                        print(titleNames)
                    }
                    
                }
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //
    // MARK:- implementations
    //
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailCell.identifier, for: indexPath)
            as! DetailCell
        let descText = decriptionText[indexPath.row]
        let newDescription = descText.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        
        cell.placeTitle.text = placeTitle[indexPath.row]
        cell.descriptionText.text = newDescription
        
        return cell
    }
    
    enum selectedCounts: String {
        case restuarant = "Restaurants"
        case  vacationSpots = "Vacation Spots"
    }
}
