//
//  ViewController.swift
//  iWeather
//
//  Created by Jigna Joshi on 2022-07-18.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func cityWeatherRequest(_ sender: Any) {
        if let cityName = self.cityNameTextFld.text, cityName != "" {
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
                        self.currentTempLbl.text = "\(responseData.temp)"
                        self.minTempLbl.text = "\(responseData.temp_min)"
                        self.maxTempLbl.text = "\(responseData.temp_max)"
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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

