import UIKit

class DetailFruitTableViewCell: UITableViewCell
{
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var ima: UIImageView!
    
    }


class DetailsTableViewController: UITableViewController{
    var valueToPass:String!
    
    var passedvalue:String!
    
    var items = ["Burak","Burcu"]
    var items1 = ["Burak","Burcu"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Passed Value Details\(passedvalue)")
        
        
}
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextScene =  segue.destination as! ShowDetailsViewController
        
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
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "td", for: indexPath) as! DetailFruitTableViewCell
        
        let fruitName = items[indexPath.row]
        cell.lab?.text = fruitName
        
        cell.ima.downloadedFrom(link: "https://s-media-cache-ak0.pinimg.com/736x/3c/8e/dd/3c8eddab0684c16f5e00d92467a426a6.jpg")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.row)!")
        
        valueToPass = items[indexPath.row]
        print("aktarilan gonderiyor \(valueToPass)")
        
         performSegue(withIdentifier: "bbc", sender: self)
        
        
        
    }
}
 
