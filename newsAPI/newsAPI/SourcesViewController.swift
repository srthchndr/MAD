//
//  SourcesViewController.swift
//  newsAPI
//
//  Created by Sarath Madala on 10/14/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import UIKit

class SourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let url = "https://newsapi.org/v2/sources?apiKey=f7afd229c20b47159174a1949686b64b";
    
    var sources = [Sources]()
    var newsSource = String()
    var selectedRowNumber: Int? = nil
    //var delegate: SourceProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        // Do any additional setup after loading the view.
        self.gettingJSON()
    }

    func gettingJSON() {
        let urlString = NSURL(string: url)
        
        URLSession.shared.dataTask(with: (urlString as URL?)!, completionHandler: { (data, response, err) in
            
            guard let data = data, err == nil, response != nil else { return }
            
            do{
                let decoder = JSONDecoder()
                let downloadSources = try decoder.decode(SourceList.self, from: data)
                self.sources = downloadSources.sources
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    //self.tableView.rowHeight = 100
                }
//                print("Sources count: \(self.sources.count)")
                
            }catch{
                print("error")
            }
            
        }).resume()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("Sources count: \(sources.count)")
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sourcesCell") as? SourcesTableViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = sources[indexPath.row].name
        
        if let selectedRowNumber = self.selectedRowNumber {
            if indexPath.row == selectedRowNumber {
                cell.accessoryType = .checkmark
            }
        }

        
        return cell

    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRow(at: NSIndexPath(row: row, section: section) as IndexPath) {
                cell.accessoryType = .checkmark
            }
        }

    }*/
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if let cell = tableView.cellForRow(at: indexPath) {
        //    cell.accessoryType = .checkmark
        //    newsSource = sources[indexPath.row].id ?? "google-news"
        //    print(newsSource)
        //    print(sources[indexPath.row].id as Any)
            
            //let vc = ViewController()
       
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "News") as! ViewController
        
        print("Starting Delegation")
        delegate?.getSource(source: "Hey")
        print("Delegation Done")
        print(vc.newsSources)
            //vc.newsSources = sources[indexPath.row].id ?? "google-news"
            
            //self.navigationController?.pushViewController(vc, animated: true)
        //}
    }*/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.delegate?.getSource(source: "Hey")
        /*if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            newsSource = sources[indexPath.row].id ?? "google-news"
            print(newsSource)
            print(sources[indexPath.row].id as Any)
        
            
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "News") as! ViewController
        
        vc.newsSources = sources[indexPath.row].id ?? "google-news"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }*/
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        self.selectedRowNumber = indexPath.row
        let tabbar = tabBarController as! TabBarViewController
        tabbar.newsSrc = sources[indexPath.row].id ?? "google-news"
        tabbar.flag = 0
        //print("Tabbar Src: \(tabbar.newsSrc)")

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
    
}
