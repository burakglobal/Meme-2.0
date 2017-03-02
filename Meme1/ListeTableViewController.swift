//
//  ListeTableViewController.swift
//  Meme1

//  Created by BURAK KEBAPCI on 2/19/17.
//  Copyright © 2017 BURAK KEBAPCI. All rights reserved.
//

import UIKit
class FruitTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var ima: UIImageView!
    @IBOutlet weak var lab2: UILabel!
    
}

class ListeTableViewController: UITableViewController{
    var valueToPass:String!
    
    var fruits:[String] = []
    var fruits1:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // url okuma
        if let url = URL(string: "https://www.hackingwithswift.com") {
            do {
                let contents = try String(contentsOf: url)
                print(contents)
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        
        //rest api connection ve array e atma
        let url=URL(string:"http://api.androidhive.info/contacts/")
        do {
            let allContactsData = try Data(contentsOf: url!)
            let allContacts = try JSONSerialization.jsonObject(with: allContactsData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String : AnyObject]
            
            print(allContacts)

            if let arrJSON = allContacts["contacts"] {
                for index in 0...arrJSON.count-1 {
                    
                    let aObject = arrJSON[index] as! [String : AnyObject]
                    
                    fruits.append(aObject["name"] as! String)
                    fruits1.append(aObject["phone"]?["mobile"]  as! String)
                }
            }
            
            self.tableView.reloadData()
        }
        catch {
            
        }
        
        
           
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene =  segue.destination as! DetailsTableViewController
        
        // Pass the selected object to the new view controller.
        if self.tableView.indexPathForSelectedRow != nil {
            nextScene.passedvalue = valueToPass
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "td", for: indexPath) as! FruitTableViewCell
        
        let fruitName = fruits[indexPath.row]
        cell.lab?.text = fruitName
        
        let fruitName1 = fruits1[indexPath.row]
        cell.lab2?.text = fruitName1

        
        cell.ima.downloadedFrom(link: "https://s-media-cache-ak0.pinimg.com/736x/3c/8e/dd/3c8eddab0684c16f5e00d92467a426a6.jpg")
        
        return cell
    }
    
    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        valueToPass = fruits[indexPath.row]
        print("aktarilan gonderiyor \(valueToPass)")
        
        performSegue(withIdentifier: "abc", sender: self)
        
      //  let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
      //  detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
      //  self.navigationController!.pushViewController(detailController, animated: true)

        
        
    }
    
 
    
  }

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}

