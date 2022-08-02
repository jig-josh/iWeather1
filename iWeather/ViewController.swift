//
//  ViewController.swift
//  iWeather
//
//  Created by Jigna Joshi on 2022-07-18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var getTempIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempView: UIView!
    @IBOutlet weak var cityNameTxtFld: UITextField!
    @IBOutlet weak var currentTempLbl: UILabel!
    @IBOutlet weak var minTempLbl: UILabel!
    @IBOutlet weak var maxTempLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tempView.isHidden = true
        self.getTempIndicator.isHidden = true
    }
    
    
    @IBAction func cityWeatherRequest(_ sender: Any) {
        
        if let cityName = self.cityNameTxtFld.text, cityName != "" {
            self.getTempIndicator.isHidden = false
            self.getTempIndicator.startAnimating()
            WebServiceManager.sharedInstance.callWeatherAPI(forCity: cityName) { (success, message, data) in
                DispatchQueue.main.async {
                    //Once API call happened to stop the activity indicator regardless of succuss or failure
                    self.getTempIndicator.stopAnimating()
                    self.getTempIndicator.isHidden = true
                }
                if success, let responseData = data {
                    DispatchQueue.main.async {
                        self.tempView.isHidden = false
                        self.currentTempLbl.text = "\(responseData.temperature)"
                        self.minTempLbl.text = "\(responseData.minTemperature)"
                        self.maxTempLbl.text = "\(responseData.maxTemperature)"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.tempView.isHidden = true
                        self.showAlert(with: "Data not available now. Please try after some time")
                    }
                }
            }
            
        } else {
            showAlert(with: "Please enter a city name")
        }
    }
    
    func showAlert(with message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    /* override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tempView.isHidden = true
        self.getTempIndicator.isHidden = true
    } */


}

