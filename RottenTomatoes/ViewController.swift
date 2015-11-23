//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Salyards, Adey on 11/21/15.
//  Copyright © 2015 Salyards, Adey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        movies = []
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = NSURL(string: "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us")!
        let request = NSURLRequest(URL: url)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (respond:NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            
            let dictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: [])
            
            self.movies = dictionary["movies"] as! [NSDictionary]
            
            self.tableView.reloadData()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as! MovieCell
        
        let movie = movies[indexPath.row]
        
        let blueVariable = CGFloat(indexPath.row * 13)
        
        print(blueVariable)
        
        let posterColor = UIColor(red: 248/255, green: 204/255, blue: blueVariable/255, alpha: 1)
        
        cell.posterImageView.backgroundColor = posterColor
            
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

