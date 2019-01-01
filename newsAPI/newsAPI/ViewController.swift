//
//  ViewController.swift
//  newsAPI
//
//  Created by Madala, Sarath Chandra on 9/18/18.
//  Copyright © 2018 Madala, Sarath Chandra. All rights reserved.
//

import UIKit

/*protocol SourceProtocol {
    func getSource(source: String)
}*/

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    /*func getSource(source: String) {
        print("DelegationSrc= \(source)")
    }*/

    var newsSources:String = ""
    var oldNewsSource:String = ""
    struct countryData{
        var name: String
        var code: String
    }
    var flag:Int=0

    var newsUrlComponents = URLComponents()
    //var url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=f7afd229c20b47159174a1949686b64b"
    let APIKey = "f7afd229c20b47159174a1949686b64b"
    var newsCategory:String = ""
    var newsCountry = "us"
    //var newsSources = "nothing"
    var oldNewsComponents = URLComponents()
    
    
    //let srcVC = SourcesViewController()
    
    var value:Int = 0
    var articles = [News]()
    let categories = ["Business", "Entertainment", "General", "Health", "Science", "Sports", "Technology"]
    let countries = [countryData(name: "Argentina", code: "ar"), countryData(name: "Australia", code: "au"), countryData(name: "Austria", code: "at"), countryData(name: "Belgium", code: "be"), countryData(name: "Brazil", code: "br"), countryData(name: "Bulgaria", code: "bg"), countryData(name: "Canada", code: "ca"), countryData(name: "China", code: "cn"), countryData(name: "Colombia", code: "co"), countryData(name: "Cuba", code: "cu"), countryData(name: "Czech Republic", code: "cz"), countryData(name: "Egypt", code: "eg"), countryData(name: "France", code: "fr"), countryData(name: "Germany", code: "de"), countryData(name: "Greece", code: "gr"), countryData(name: "Hong kong", code: "hk"), countryData(name: "Hungary", code: "hu"), countryData(name: "India", code: "in"), countryData(name: "Indonesia", code: "id"), countryData(name: "Ireland", code: "ie"), countryData(name: "Israel", code: "il"), countryData(name: "Italy", code: "it"), countryData(name: "Japan", code: "jp"), countryData(name: "Latvia",code: "lv"), countryData(name: "Lithuania", code: "lt"), countryData(name: "Malaysia", code: "my"), countryData(name: "Mexico", code: "mx"), countryData(name: "Morocco", code: "ma"), countryData(name: "Netherlands", code: "nl"), countryData(name: "New Zealand", code: "nz"), countryData(name: "Nigeria", code: "ng"), countryData(name: "Norway", code: "no"), countryData(name: "Philippines", code: "ph"), countryData(name: "Poland", code: "pl"), countryData(name: "Portugal", code: "pt"), countryData(name: "Romania", code: "ro"), countryData(name: "Russia", code: "ru"), countryData(name: "Saudi Arabia", code: "sa"), countryData(name: "Serbia", code: "rs"), countryData(name: "Singapore", code: "sg"), countryData(name: "Slovakia", code: "sk"), countryData(name: "Slovenia", code: "si"), countryData(name: "South Africa", code: "za"), countryData(name: "South Korea", code: "kr"), countryData(name: "Sweden", code: "se"), countryData(name: "Switzerland", code: "ch"), countryData(name: "Taiwan", code: "tw"), countryData(name: "Thailand", code: "th"), countryData(name: "Turkey",code: "tr"), countryData(name: "UAE", code: "ae"), countryData(name: "Ukraine", code: "ua"), countryData(name: "United Kingdom", code: "gb"), countryData(name: "United States", code: "us"), countryData(name: "Venuzuela", code: "ve")]
    

    @IBOutlet var loadingView: LoadingView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var locationBtn: UIButton!
    @IBAction func categoriesButton(_ sender: Any) {
        //print("Categories Button")
        /*multipickerView.multiPicker.dataSource = self as? UIPickerViewDataSource
         multipickerView.multiPicker.delegate = self as? UIPickerViewDelegate
         
         multipickerView.frame = CGRect(x: 0, y: 510, width: tableView.frame.width, height: multipickerView.frame.height)
         self.view.addSubview(multipickerView)*/
        let actionSheet = UIAlertController(title: "Categories", message: "Select one Category", preferredStyle: .actionSheet)
        
        for category in categories{
            let cat = UIAlertAction(title: category, style: .default, handler: { action in
                self.newsCategory = category
                self.newsSources = ""
                self.oldNewsSource = self.newsSources
                UserDefaults.standard.set("", forKey: "sources")
                UserDefaults.standard.set(category, forKey: "newsCategory")
                self.urlBuilding()
                //print(category)
                
            })
            actionSheet.addAction(cat)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in //print("Cancel")
            
        })
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func locationButton(_ sender: Any) {
        //print("Countries Button")
        /*multipickerView.frame = CGRect(x: 0, y: 510, width: tableView.frame.width, height: multipickerView.frame.height)
         self.view.addSubview(multipickerView)*/
        
        let actionSheet = UIAlertController(title: "Countries", message: "Select one Country", preferredStyle: .actionSheet)
        
        for country in countries{
            let con = UIAlertAction(title: country.name, style: .default, handler: { action in
                self.newsCountry = country.code
                self.newsSources = ""
                self.oldNewsSource = self.newsSources
                UserDefaults.standard.set("", forKey: "sources")
                UserDefaults.standard.set(country.code, forKey: "newsCountry")
                self.urlBuilding()
                //print(country)
                
            })
            actionSheet.addAction(con)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in //print("Cancel")
            
        })
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        //loadingToLoading()
        //srcVC.delegate = self
        let tabBar = tabBarController as! TabBarViewController
        self.flag = tabBar.flag
        if(self.flag == 0){
            newsSources = tabBar.newsSrc
            UserDefaults.standard.set(newsSources, forKey: "sources")
            self.flag = 1
            tabBar.flag = 1
        }
        
        //print("nagarjuna  ", newsUrlComponents.url as Any)
        //print("nagarjuna1  ", self.oldNewsComponents.url as Any)
        if(oldNewsSource != newsSources){
            urlBuilding()
            //tableView.reloadData()
        }
        
        //removeLoading()
        //print("naga")
        //gettingJSON()
        //self.tableView.reloadData()
    }
    
    //start here
    func loadingToLoading() {
        //print("loading")
        loadingView.bounds.size.width = view.bounds.width
        loadingView.bounds.size.height = view.bounds.height
        loadingView.center = view.center
        activityIndicator.startAnimating();
        self.tableView.addSubview(loadingView)
        
    }
    
    func removeLoading() {
         //print("removing")
        loadingView.removeFromSuperview()
    }
    //end here
    
    override func viewDidLoad() {
        //super.viewDidLoad()
       // loadingToLoading()
//start here
        urlBuilding()
        tableView.reloadData()
        //End here
       // removeLoading();
        //print("viewdidload")
        
        
    }
    
    private func urlBuilding(){
        newsUrlComponents.scheme = "https"
        newsUrlComponents.host = "newsapi.org"
        newsUrlComponents.path = "/v2/top-headlines"
        //print("Source = \(newsSources)")
        oldNewsSource = newsSources
        //print(UserDefaults.standard.string(forKey: "newsCountry"))
        //print(UserDefaults.standard.string(forKey: "newsCategory"))
        let cntry = UserDefaults.standard.string(forKey: "newsCountry") != nil ? URLQueryItem(name: "country", value: UserDefaults.standard.string(forKey: "newsCountry")) : URLQueryItem(name: "country", value: "us");
        
        let src = URLQueryItem(name: "sources", value: UserDefaults.standard.string(forKey: "sources"))
        let cat = URLQueryItem(name: "category", value: UserDefaults.standard.string(forKey: "newsCategory"))
        let api = URLQueryItem(name: "apiKey", value: APIKey)
        newsUrlComponents.queryItems = [cntry, cat, src, api]
        print("URL = \(newsUrlComponents.url as Any)")
        print(oldNewsSource)
        if(oldNewsSource != ""){
            newsUrlComponents.queryItems?.remove(at: 0)
            newsUrlComponents.queryItems?.remove(at: 0)
        }else{
            newsUrlComponents.queryItems?.remove(at: 2)
            if(newsCategory == ""){
                newsUrlComponents.queryItems?.remove(at: 1)
            }
        }
    
        //self.url = NSURL(string: newsUrlComponents.url)
        oldNewsComponents = newsUrlComponents
        print("URL = \(newsUrlComponents.url as Any)")
        gettingJSON()
        
    }

    func gettingJSON() {
        loadingToLoading();
        let urlString = newsUrlComponents.url
        
        URLSession.shared.dataTask(with: (urlString as URL?)!, completionHandler: { (data, response, err) in
            
            guard let data = data, err == nil, response != nil else { return }
            
            do{
                let decoder = JSONDecoder()
                let downloadArticles = try decoder.decode(Articles.self, from: data)
                self.articles = downloadArticles.articles
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }catch{
                print("error")
            }
            
            }).resume()
        //removeLoading()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // print("articles count: \(articles.count)")
        return articles.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TableViewCell else { return UITableViewCell() }
        
        //print("Article title: \(String(describing: articles[indexPath.row].title))")
        if(articles[indexPath.row].title == nil){
            cell.titleLabel.text = "Exclusive News, Jump in for details"
                //nullToNil(value: articles[indexPath.row].title as AnyObject) as? String
        }else{
        cell.titleLabel.text = articles[indexPath.row].title
        }
        
        if(articles[indexPath.row].description == nil){
            cell.descLabel.text = "Check out the article in detail"
                //nullToNil(value: articles[indexPath.row].description as AnyObject) as? String
        }else{
            cell.descLabel.text = articles[indexPath.row].description
        }
        
        if(articles[indexPath.row].urlToImage == nil){
            //cell.imgView.isHidden = true
            cell.imgView.image = UIImage(contentsOfFile: "news2.jpg")
        }else{
            let imgURL = NSURL(string: articles[indexPath.row].urlToImage!)
            if(imgURL != nil){
            let data = NSData(contentsOf: (imgURL as URL?)!)
                if(data == nil){
                    cell.imgView.image = UIImage(contentsOfFile: "news2.jpg")
                }else{
                    cell.imgView.image = UIImage(data: data! as Data)
                }
                
            }
        }
        //start here
        removeLoading()
        //end here
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsView = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        detailsView.getTitle = articles[indexPath.row].title ?? "Breaking News"
        detailsView.getContent = articles[indexPath.row].content ?? "Content is not available"
        detailsView.getImgurl = articles[indexPath.row].urlToImage ?? "Image Unavailable"
        detailsView.getPublished = articles[indexPath.row].publishedAt ?? "Time Unavailable"
        detailsView.getUrl = articles[indexPath.row].url ?? "  "
        detailsView.getAuthor = articles[indexPath.row].author ?? " "
        detailsView.getDescription = articles[indexPath.row].description ?? " "
        
        self.navigationController?.pushViewController(detailsView, animated: true)
    }
    
    
    
}
