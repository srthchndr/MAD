//
//  DetailsViewController.swift
//  newsAPI
//
//  Created by Sarath Madala on 9/24/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    var getTitle = String()
    var getContent = String()
    var getImgurl = String()
    var getPublished = String()
    var getUrl = String()
    var getAuthor = String()
    var getDescription = String()

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var publishedLbl: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBAction func articleButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: getUrl)!, options: [:], completionHandler: nil)
    }
    @IBOutlet weak var articleOutlet: UIButton!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    @IBAction func favoritesButton(_ sender: Any) {
   
        
        //start here
        if(favBtn.tintColor == .lightGray){
            //print("Grey to Yellow")
            favBtn.tintColor = UIColor.blue
            saveToDb(author: getAuthor, title: getTitle, description: getDescription, url: getUrl, urlToImage: getImgurl, publishedAt: getPublished, content: getContent)
           // print("Saved")
        }else if(favBtn.tintColor == .blue){
            //print("Yellow to Grey")
            favBtn.tintColor = UIColor.lightGray
            deleteEntry(title: getTitle)
        }
    }
    
    //end here
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = getTitle
        contentLbl.text = getContent
        publishedLbl.text = "Published on: \(getPublished)"
        favBtn.tintColor = UIColor.lightGray
        
        var res = [Artcles]()
        res = fetchResults()
   //start here
        for articless in res{
            if(articless.title == getTitle){
                favBtn.tintColor = UIColor.blue
            }
        }
        //endhere
        
        if(getImgurl == "Image Unavailable"){
            imgView.isHidden = true
        }else{
            let url = NSURL(string: getImgurl)
            let data = NSData(contentsOf: url! as URL)
            imgView.image = UIImage(data: data! as Data)
        }
        
        if(getUrl == "URL not available"){
            articleOutlet.isEnabled = false
        }else{
            articleOutlet.isEnabled = true
        }
    }
    
    func deleteEntry(title: String){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Artcles")
        fetchRequest.predicate = NSPredicate.init(format: "title = %@", title)
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try managedContext.fetch(fetchRequest)
           // print("results: ", results.count)
            if results.count > 0
            {
                
                //if let result = try? context.fetch(fetchRequest) {
                for object in results {
                    managedContext.delete(object as! NSManagedObject)
                }
                //}
                //articless = newArt
            }
        }catch{
            print("DB display ERROR!!!")
        }
        
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
    

    func saveToDb(author: String, title: String, description: String, url: String, urlToImage: String, publishedAt: String, content: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let artcl = NSEntityDescription.insertNewObject(forEntityName: "Artcles", into: context)
        
        artcl.setValue(author, forKey: "author")
        artcl.setValue(title, forKey: "title")
        artcl.setValue(description, forKey: "desc")
        artcl.setValue(url, forKey: "url")
        artcl.setValue(urlToImage, forKey: "urlToImage")
        artcl.setValue(publishedAt, forKey: "publishedAt")
        artcl.setValue(content, forKey: "content")
        
        do{
            try context.save()
            //print("saved")
        }catch{
            print("Database ERROR!!!!")//Catch
        }
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
