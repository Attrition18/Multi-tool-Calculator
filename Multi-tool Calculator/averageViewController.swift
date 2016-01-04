import UIKit

import AVFoundation
import AVKit

class averageViewController: UIViewController {
    //MARK: - IBOutlet
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var menuButton: UIBarButtonItem!
   
    
    //MARK:- Properties
    var average = averageCalc()
    var player: AVPlayer?
    var inputArray: averageTableViewController!
    
 
    
    
    //MARK:- ViewControllerLifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        inputTextField.keyboardType = UIKeyboardType.DecimalPad
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
    
    //MARK: - UIControl Events
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "sendResult" {
            inputArray = segue.destinationViewController as! averageTableViewController
        }
        
    }
    
    @IBAction func nextButton(sender: UIButton) {
        average.arrayInput(((inputTextField.text!) as NSString).doubleValue)
       
        inputArray.arrayFromSegue = average.input
        inputArray.tableView.reloadData()
        calcAverage()

        inputTextField.text=nil

                }
    @IBAction func clearButton(sender: UIButton) {
        average.clearArray()
        calcAverage()
    }
    
    func calcAverage(){
        
        
        
        average.calcAverage()
        
        UpdateUI()
        
    }
    
    
    func UpdateUI(){
        
        outputLabel.text = String(average.average)
        
    }
    
    
    func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    }
    
    

}