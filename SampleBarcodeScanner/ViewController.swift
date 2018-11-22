//
//  ViewController.swift
//  SampleBarcodeScanner
//
//  Created by Chinna Addepally on 11/19/18.
//  Copyright © 2018 Chinna Addepally. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var switchBarcodeType: UIView!
    @IBOutlet weak var scanView: UIView!
    
    var barcodeScanView: BarcodeScanView!
    var focusView: FocusView!

    @IBAction func turnFlashOnOrOff(_ sender: Any) {
        guard barcodeScanView != nil else {
            return
        }
        
        let scanButton = sender as! UIBarButtonItem
        
        if barcodeScanView.torchMode == .off {
            barcodeScanView.torchMode = .on
        }
        else if barcodeScanView.torchMode == .on {
            barcodeScanView.torchMode = .off
        }
        
        scanButton.image = barcodeScanView.torchMode.image
    }
    
    func setUpScan() {
        barcodeScanView = BarcodeScanView.init(frame: CGRect.zero)
        barcodeScanView.translatesAutoresizingMaskIntoConstraints = false
        barcodeScanView.delegate = self
        scanView.addSubview(barcodeScanView)
        
        let viewsDict: [String: Any] = ["ScanView": barcodeScanView]
        
        scanView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[ScanView]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        scanView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[ScanView]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        
        barcodeScanView.setUpCamera()
        barcodeScanView.startCapturing()
    }
    
    func addFocusView() {
        focusView = FocusView.init(frame: CGRect.zero, focusText: "UPC bar code")
        focusView.translatesAutoresizingMaskIntoConstraints = false
        focusView.backgroundColor = UIColor.clear
        scanView.addSubview(focusView)
        
        let viewsDict: [String: Any] = ["FocusView": focusView]
        
        scanView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[FocusView]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        scanView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[FocusView]|", options: .init(rawValue: 0), metrics: nil, views: viewsDict))
        
        scanView.bringSubviewToFront(focusView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        setUpScan()
//        addFocusView()
    }
}


extension ViewController: BarcodeScanViewDelegate {
    
    func didFinishScanningBarcode(code: String, type: String) {
        print("Barcode: \(code)")
        print("Type: \(type)")
    }
    
    func enterCodeManually() {
        //Perform UI flow If you want to enter the code manually
    }
}
