//
//  TempViewController.swift
//  Sample Slidebar
//
//  Created by Avram-Chaim Levy on 2015-12-27.
//  Copyright © 2015 Avram-Chaim Levy. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class TempViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var FahrenheitTextField: UITextField!
    @IBOutlet weak var CelsiusTextField: UITextField!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //MARK: - Variables
    
    var tempCalc = TempCalc()
    var userCelcsius: Double = 0
    var userFahrenheit: Double = 0
        var player: AVPlayer?
    
    
    //MARK: - Properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CelsiusTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        CelsiusTextField.keyboardType = UIKeyboardType.DecimalPad
        FahrenheitTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        FahrenheitTextField.keyboardType = UIKeyboardType.DecimalPad
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let videoURL: NSURL = NSBundle.mainBundle().URLForResource("Background", withExtension: "mov")!
        
        player = AVPlayer(URL: videoURL)
        player?.actionAtItemEnd = .None
        player?.muted = true
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playerLayer.zPosition = -1
        
        playerLayer.frame = view.frame
        
        view.layer.addSublayer(playerLayer)
        
        player?.play()
        
        //loop video
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "loopVideo",
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: nil)
        
        
        
    }
    
    func calcCelsius(){
        userFahrenheit = ((FahrenheitTextField.text!) as NSString).doubleValue
        tempCalc.fahrenheit = userFahrenheit
        tempCalc.calcCelsius()
        updateUIForCelsius()
     

    }

    func calcFahrenheit(){
        userCelcsius = ((CelsiusTextField.text!) as NSString).doubleValue
        tempCalc.celsius = userCelcsius
        tempCalc.calcFahrenheit()
        updateUIForFahrenheit()
        print("userCelsius: \(userCelcsius)")
    }
    
    func updateUIForCelsius(){
        CelsiusTextField.text = String(format: "%0.2f", arguments: [tempCalc.calculatedCelsius])
    }
    
    func updateUIForFahrenheit(){
        FahrenheitTextField.text = String(format: "%0.2f", arguments: [tempCalc.calculatedFahrenheit])
        
       
    }
    
    //MARK: - UIControlEvents
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    @IBAction func CelsiusToFahrenheit(){
        calcFahrenheit()
    }
    
    @IBAction func FahrenheitToCelsius(){
        calcCelsius()
    }
    @IBAction func clearCelsiusTextField(sender: UITextField) {
        CelsiusTextField.text = nil
        calcFahrenheit()
    }
    @IBAction func clearFahrenheitTextField(sender: UITextField) {
        FahrenheitTextField.text = nil
        calcCelsius()
    }
    
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
}
