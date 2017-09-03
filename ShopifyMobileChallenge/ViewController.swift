//
//  ViewController.swift
//  ShopifyMobileChallenge
//
//  Created by Vipul Srivastav on 2017-08-27.
//  Copyright © 2017 Vipul Srivastav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    let url = "https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
    
    var i : Int? = nil
    var j : Int? = nil
    var count : Int = 0
    var countBag : Int = 0
    var totalSpend : Float = 0
    var spend: Float! = 0
    
    @IBOutlet var amount: UILabel!
    
    @IBOutlet var AwesomeBrnzBag: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("\(json["orders"].count)")
                self.count = json["orders"].count

                for i in 0...self.count {
                    print("--------")
                   // Calculating no of line_items
                   // Iteration for Title attribute to count 'Awesome Bronze Bag(s)'
                    for j in 0...json["orders"][i]["line_items"].count
                    {
                       if json["orders"][i]["line_items"][j]["title"] == "Awesome Bronze Bag" {
                          print("\(json["orders"][i]["line_items"][j]["title"])")
                          self.countBag = self.countBag + 1
                        
                        }
                    }
                   // Checking currency for CAD
                   // Cust Info to calculate amount (in Canadian dollars) spent by Napoleon Batz
                   
                    if json["orders"][i]["currency"] == "CAD" && json["orders"][i]["customer"]["email"] == "napoleon.batz@gmail.com" {
                        print("\(json["orders"][i]["currency"])")
                        print("\(json["orders"][i]["customer"]["email"])")
                        print("\(json["orders"][i]["customer"]["total_spent"])")
                        self.spend = Float(String(describing: json["orders"][i]["customer"]["total_spent"]))
                        self.totalSpend = self.totalSpend + self.spend
                    }
                   print("No. of Awesome Bronze Bags : \(self.countBag)")
                   print("Amount Spent by Napoleon Batz: \(self.totalSpend)")
                }
                
                self.amount.text = String(describing: self.totalSpend)
                self.AwesomeBrnzBag.text = String(describing: self.countBag)
                
            case .failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
   

}

