//
//  GitSearchController.swift
//  SearchGitHub
//
//  Created by IMCS2 on 11/11/19.
//  Copyright © 2019 com.phani. All rights reserved.
//

import UIKit
import Alamofire

class GitSearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView?
    
    @IBOutlet weak var userNameEndURL: UISearchBar?
    
    var finalKeyword : String?
    var array: [String]  = []
    var str : String?
    var numberOfRepository : [String] = []
    



    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        userNameEndURL?.delegate = self
        
    }
    var keyWords : String?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        keyWords = userNameEndURL?.text
        finalKeyword = keyWords?.replacingOccurrences(of: " ", with: "+")
        alamoFireOutput()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AllTheRandomUsers", for: indexPath) as? AllTheRandomUsers else{
            return UITableViewCell()
        }
        cell.userName?.text = array[indexPath.row]
        //cell.numberOfRepository?.text = numberOfRepository[indexPath.row]
        return cell
    }
    
    func registerCell(){
        self.tableView?.register(UINib(nibName: "AllTheRandomUsers", bundle: nil), forCellReuseIdentifier: "AllTheRandomUsers")
    }
    
    func alamoFireOutput(){
        array.removeAll()
        
        guard let url = URL(string: "https://api.github.com/search/users?q=" +  finalKeyword!) else {
            return
        }
        
        print("the url is \(url)")
        let task = URLSession.shared.dataTask(with: url){ ( data, response, error) in
            if error ==  nil{
                if let unwrappedData = data{
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        let feed = jsonResult?["items"] as? [[String: AnyObject]]
                        let result = feed?[0]["login"] as? String
                        if let count = feed?.count{
                            for n in 0...count-1{
                                DispatchQueue.main.async{
                                self.array.append((feed?[n]["login"] as? String)!)
                                    print(self.array)
                                self.tableView?.reloadData()
                                    self.fetchingNumberOfFollowers()

                                }
                            }
                        }
                        

                    }catch{
                        print("Error")
                    }
                }
            }
            
        }
        task.resume()

    }
    
    
    func fetchingNumberOfFollowers(){

        for n in 0..<array.count{
            print("the calue is \(array[n])")
            
        let url = URL(string: "https://api.github.com/users/" + array[n])
        let task = URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error ==  nil{
                if let unwrappedData = data{
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        let result = jsonResult?["public_repos"]
                        print(result)
                    }catch{

                    }
                }
            }

        }

        task.resume()
        }
        
    
    }
    
}
