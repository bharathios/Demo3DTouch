//
//  MerchandiseViewController.swift
//  Demo3DTouch
//
//  Created by Bharath Rao on 29/01/16.
//  Copyright © 2016 Bharath Nagaraj Rao. All rights reserved.


import Foundation
import UIKit

class MerchandiseViewController: UIViewController,UIViewControllerPreviewingDelegate{
    
    @IBOutlet weak var merchandiseTable: UITableView!
    
    var merchandiseList:[String] = {
        
         return ["Mobiles","Furniture","Washing Machines","Taps and Faucets","Refrigerator", "External HD", "LED TV"]
    
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Register UITableView Cell
        self.merchandiseTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")

        if( traitCollection.forceTouchCapability == .Available){
            
            registerForPreviewingWithDelegate(self, sourceView: view)
            
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: UITableview Datasource & Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.merchandiseList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.merchandiseList[indexPath.row]
        
        return cell
    }
    
    //Step2
    // MARK: Trait collection delegate methods
    override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
        
    }
    
    // MARK: UIViewControllerPreviewingDelegate methods
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = self.merchandiseTable.indexPathForRowAtPoint(location)
            else {return nil }
        
        guard let cell = self.merchandiseTable.cellForRowAtIndexPath(indexPath)
            else {return nil }
        
        guard let detailVC = storyboard?.instantiateViewControllerWithIdentifier("DetailsId") as? DetailsViewController
            else {return nil }
        
        //If you want to pass any data to your destination controller, here is the place to do it
        //Set the preferredcontentsize ie, the size of the preview controller
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        //This will highlight the tapped row & blur rest of the screen
        previewingContext.sourceRect = cell.frame
        return detailVC
    }
    
    
    
    //Step3
    
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        
        showViewController(viewControllerToCommit, sender: self)
        
    }

}