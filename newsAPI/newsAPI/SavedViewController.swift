//
//  SavedViewController.swift
//  newsAPI
//
//  Created by Madala, Sarath Chandra on 11/20/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import UIKit
import CoreData

class SavedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var articless = [Artcles]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("COUNT: ", articless.count)
        return articless.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell") as? NewTableViewCell else { return UITableViewCell() }
        
        if(articless[indexPath.row].title == nil){
            cell.titleLabel.text = "Exclusive News, Jump in for details"
            //nullToNil(value: articles[indexPath.row].title as AnyObject) as? String
        }else{
            cell.titleLabel.text = articless[indexPath.row].title
        }
        
        if(articless[indexPath.row].desc == nil){
            cell.descLabel.text = "Check out the article in detail"
            //nullToNil(value: articles[indexPath.row].description as AnyObject) as? String
        }else{
            cell.descLabel.text = articless[indexPath.row].desc
        }
        
        if(articless[indexPath.row].urlToImage == nil){
            cell.imgView.isHidden = true
        }else{
            let imgURL = NSURL(string: articless[indexPath.row].urlToImage!)
            if(imgURL != nil){
                let data = NSData(contentsOf: (imgURL as URL?)!)
                cell.imgView.image = UIImage(data: data! as Data)
            }
        }

        
        return cell
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(false)
        articless = fetchResults()
        self.tableView.reloadData()
    }
    
    func fetchResults()->Array<Artcles>{
        var newArt = [Artcles]();
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Artcles")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try managedContext.fetch(fetchRequest)
            //print("results: ", results.count)
            if results.count > 0
            {
                
                for article in results{
                    newArt.append(article as! Artcles)
                    //articless.append(article as! Artcles)
                }
                //articless = newArt
            }
        }catch{
            print("DB display ERROR!!!")
        }
        
        return newArt
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsView = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        detailsView.getTitle = articless[indexPath.row].title ?? "Breaking News"
        detailsView.getContent = articless[indexPath.row].content ?? "Content is not available"
        detailsView.getImgurl = articless[indexPath.row].urlToImage ?? "Image Unavailable"
        detailsView.getPublished = articless[indexPath.row].publishedAt ?? "Time Unavailable"
        detailsView.getUrl = articless[indexPath.row].url ?? "  "
        detailsView.getAuthor = articless[indexPath.row].author ?? " "
        detailsView.getDescription = articless[indexPath.row].description 
        
        self.navigationController?.pushViewController(detailsView, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    

}
