//
//  ShowDetailsViewController.swift
//  Meme2
//
//  Created by BURAK KEBAPCI on 2/26/17.
//  Copyright © 2017 BURAK KEBAPCI. All rights reserved.
//

import UIKit

class ShowDetailsViewController: UIViewController {
    var passedvalue:String!
    @IBOutlet weak var sss: UIButton!
    @IBOutlet weak var aaa: UILabel!

    override func viewDidLoad() {
              super.viewDidLoad()
        print("Passed Value All Details\(passedvalue)")
        aaa.text = passedvalue;
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sssa(_ sender: Any) {
        
        getData()
    }
    func getData()
    {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "http://jsonplaceholder.typicode.com/users/1")!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        print(json)
                        
                   }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
                
                
            }
            
        })
        task.resume()
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
