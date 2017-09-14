//
//  ViewController.swift
//  QuickSeriesTest
//
//  Created by CtanLI on 2017-09-13.
//  Copyright © 2017 QuickSeries. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Reusable {

    var categoryJson: NSArray!
    var dictionary = [Int:Any]()
    
    @IBOutlet weak var categoryTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //accessing the json file from the assets
        let asset = NSDataAsset(name: "categories", bundle: Bundle.main)
        categoryJson = try? JSONSerialization.jsonObject(with: asset!.data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        print(categoryJson)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryJson.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.identifier, for: indexPath)
            as! CategoryCell
        
        //did not have much time to figure this out
        for (index,element) in categoryJson.enumerated() {
            
            print("Item \(index): \(element)")
            let uniqueID = index //Or generate uniqued Int id
            dictionary[uniqueID] = element
           
        }

        return cell
    }
}

extension NSArray {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}
