

import UIKit
import AVFoundation
import AVKit

class TaxViewController: UIViewController, UIPickerViewDataSource,  UITextFieldDelegate, UIPickerViewDelegate, CalculatorDelegate{
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var amountBeforeTaxTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var taxLabel1: UILabel!
    @IBOutlet weak var taxLabel2: UILabel!
    
    @IBOutlet weak var taxPercentageLabel1: UILabel!
    @IBOutlet weak var taxPercentageLabel2: UILabel!
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var calcInputView: CalculatorKeyboard!

    
    //MARK: - Properties
    var provinceforPicker = ["British Columbia", "Alberta", "Saskatchewan", "Manitoba", "Ontario", "Qubec", "New Brunswick", "Nova Scotia", "Newfoundland and Labrador", "Prince Edward Island", "Yukon", "North Western Territories", "Nunavut"]
    var percentByRegion = region()
    var taxCalc = TaxCalc(amountBeforeTax: 0.0, taxPercentage: 0.13)
    let percent = 0.13
    var pickerPickerView = UIPickerView()
    var indexPicker: Int = 0
    var taxHST: Float = 0
    var taxGST: Float = 0
    var taxPST: Float = 0
    var taxRST: Float = 0
    var taxQST: Float = 0
    var indexPickerForLoad = NSUserDefaults.standardUserDefaults()
    //var player: AVPlayer?
    
    
    
    //MARK: - ViewControllerLifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        pickerPickerView.delegate = self
        pickerPickerView.dataSource = self
        calcInputView.delegate = self
        calcInputView.removeFromSuperview()
        pickerTextField.inputView = pickerPickerView
        amountBeforeTaxTextField.inputView = calcInputView
        //amountBeforeTaxTextField.keyboardAppearance = UIKeyboardAppearance.Dark
        //amountBeforeTaxTextField.keyboardType = UIKeyboardType.DecimalPad
        //String(format: "%0.2f", arguments: [taxCalc.amountBeforeTax])
        taxPercentageLabel1.text = String(format: "Tax(%%):", arguments: [Int(taxCalc.taxPercentage*100)])
        let indexPickerNum = indexPickerForLoad.integerForKey("regionSaved")
        pickerPickerView.selectRow(indexPickerNum, inComponent: 0, animated: true)
        pickerTextField.text = provinceforPicker[indexPickerNum]
        indexPicker = provinceforPicker.indexOf(provinceforPicker[indexPickerNum])!
        percentByRegion.province = indexPicker
       
        calcTax()
        
        
        
       /* let videoURL: NSURL = NSBundle.mainBundle().URLForResource("Background", withExtension: "mov")!
        
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
        */
        
        
        
        
        
    }
    func calcTax(){
        percentByRegion.calcTotalTax()
        taxCalc.taxPercentage = percentByRegion.totalTax
     
        taxCalc.amountBeforeTax = ((amountBeforeTaxTextField.text!) as NSString).floatValue
        
        taxCalc.calculateTaxPartial(percentByRegion.getHSTTax())
        taxHST = taxCalc.taxPartialAmount
        taxCalc.calculateTaxPartial(percentByRegion.getGSTTax())
        taxGST = taxCalc.taxPartialAmount
        taxCalc.calculateTaxPartial(percentByRegion.getPSTTax())
        taxPST = taxCalc.taxPartialAmount
        taxCalc.calculateTaxPartial(percentByRegion.getRSTTax())
        taxRST = taxCalc.taxPartialAmount
        taxCalc.calculateTaxPartial(percentByRegion.getQSTTax())
        taxQST = taxCalc.taxPartialAmount
        
        /*
        taxHST = Float(taxCalc.calculateTaxPartial(percentByRegion.getHSTTax()))
        taxGST = Float(taxCalc.calculateTaxPartial(percentByRegion.getGSTTax()))
        print("percentByRegion:\(percentByRegion.getGSTTax())")
        
        print("calculateTaxPartial \(taxCalc.calculateTaxPartial(percentByRegion.getGSTTax()))")
        print("GST: \(taxGST)")
        taxPST = Float(taxCalc.calculateTaxPartial(percentByRegion.getPSTTax()))
        taxRST = Float(taxCalc.calculateTaxPartial(percentByRegion.getRSTTax()))
        taxQST = Float(taxCalc.calculateTaxPartial(percentByRegion.getQSTTax()))
        */
        taxCalc.calculateTax()
        updateUI()
        
    }
    func updateUI(){
        
        
        switch indexPicker {
        case 0: //BC
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = String(format: "PST(%d%%):", arguments: [Int(percentByRegion.getPSTTax()*100)])
        case 1: //A
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 2: //Sask
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = String(format: "PST(%d%%):", arguments: [Int(percentByRegion.getPSTTax()*100)])
        case 3: //Man
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = String(format: "RST(%d%%):", arguments: [Int(percentByRegion.getRSTTax()*100)])
        case 4://Ontario
            taxPercentageLabel1.text = String(format: "HST(%d%%):", arguments: [Int(percentByRegion.getHSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 5://Qubec
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = String(format: "QST(%0.3f%%):", arguments: [Double(percentByRegion.getQSTTax()*100)])
        case 6://NB
            taxPercentageLabel1.text = String(format: "HST(%d%%):", arguments: [Int(percentByRegion.getHSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 7://NS
            taxPercentageLabel1.text = String(format: "HST(%d%%):", arguments: [Int(percentByRegion.getHSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 8://N&L
            taxPercentageLabel1.text = String(format: "HST(%d%%):", arguments: [Int(percentByRegion.getHSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 9://PEI
            taxPercentageLabel1.text = String(format: "HST(%d%%):", arguments: [Int(percentByRegion.getHSTTax()*100)])
            
            taxPercentageLabel2.text = nil
        case 10://Y
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 11://NWT
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = nil
        case 12://Nun
            taxPercentageLabel1.text = String(format: "GST(%d%%):", arguments: [Int(percentByRegion.getGSTTax()*100)])
            taxPercentageLabel2.text = nil
        default:
            taxPercentageLabel1.text = nil
            taxPercentageLabel2.text = nil
        }
        totalLabel.text = String(format: "%0.2f", arguments: [taxCalc.totalAmount])
        
        
        switch indexPicker {
        case 0: //BC
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            
            taxLabel2.text = String(format: "%0.2f", arguments: [Float(taxPST)])
        case 1: //A
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = nil
        case 2: //Sask
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = String(format: "%0.2f", arguments: [Float(taxPST)])
        case 3: //Man
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = String(format: "%0.2f", arguments: [Float(taxRST)])
        case 4://Ontario
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxHST)])
            taxLabel2.text = nil
        case 5://Qubec
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = String(format: "%0.2f", arguments: [Float(taxQST)])
        case 6://NB
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxHST)])
            taxLabel2.text = nil
        case 7://NS
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxHST)])
            taxLabel2.text = nil
        case 8://N&L
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxHST)])
            taxLabel2.text = nil
        case 9://PEI
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = nil
        case 10://Y
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = nil
        case 11://NWT
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = nil
        case 12://Nun
            taxLabel1.text = String(format: "%0.2f", arguments: [Float(taxGST)])
            taxLabel2.text = nil
        default:
            taxLabel1.text = nil
            taxLabel2.text = nil
        }
    }
    //MARK: - UIControl Events
    
    @IBAction func clearTextField(sender: UITextField) {
        amountBeforeTaxTextField.text=nil
        calcTax()
    }
    
    /*@IBAction func amountChangedTextField(sender: UITextField) {
        calcTax()
    } */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return provinceforPicker.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerTextField.text = provinceforPicker[row]
        indexPicker = provinceforPicker.indexOf(provinceforPicker[row])!
        let  indexPickerViewNum = indexPicker
        NSUserDefaults.standardUserDefaults().setObject(indexPickerViewNum, forKey: "regionSaved")
        NSUserDefaults.standardUserDefaults().synchronize()
        percentByRegion.province = indexPicker
        
        calcTax()
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return provinceforPicker[row]
    }
    
    func calculator(calculator: CalculatorKeyboard, didChangeValue value: String) {
        amountBeforeTaxTextField.text = value
        calcTax()
    }
    
    
    /*func loopVideo() {
        player?.seekToTime(kCMTimeZero)
        player?.play()
    } */

    
}
