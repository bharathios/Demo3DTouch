//
//  ViewController.swift
//  Demo3DTouch
//
//  Created by Bharath Rao on 29/01/16.
//  Copyright © 2016 Bharath Nagaraj Rao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animationDuration = 1.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Step 1
    //Mark: UITouch Delegate
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.Available {
                    
                    print("value - \(Double(touch.force))")
                    print("MAX Value- \(Double(touch.maximumPossibleForce))")
                    animationDuration = Double(touch.maximumPossibleForce) - Double(touch.force)
                    createWaterDroplet()
                    
                }
            }
        }
    }
    
    
    func createWaterDroplet()
    {
        let waterDropImageView = UIImageView(image: UIImage(named: "Water"))
        waterDropImageView.frame = CGRect(x: WATER_DROP_X_POS, y: WATER_DROP_Y_POS, width: WATER_DROP_IMAGE_WIDTH, height:WATER_DROP_IMAGE_HEIGHT)
        view.addSubview(waterDropImageView)
        
        //Start the water droplet from the tip of the sink cock. As of now, hardcoding the position for the demo
        let startPos = waterDropImageView.layer.position
        
        //Set the end position beyound bounds
        let endPos = CGPointMake(CGFloat(WATER_DROP_X_POS),self.view.bounds.height+CGFloat(WATER_DROP_IMAGE_HEIGHT))
        
        //Move the water droplet with animation
        let animate = CABasicAnimation(keyPath: "position")
        animate.fromValue = NSValue.init(CGPoint: startPos)
        animate.toValue = NSValue.init(CGPoint: endPos)
        animate.duration   = NSTimeInterval(animationDuration)
        animate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        waterDropImageView.layer.addAnimation(animate, forKey: "position")
        waterDropImageView.layer.position = endPos
    }

    
    
    
    //MARK: IBActions
    @IBAction func shopMerchandise(sender: AnyObject) {
        
        self.performSegueWithIdentifier("MerchandiseId", sender: self)
        
    }
    

}

