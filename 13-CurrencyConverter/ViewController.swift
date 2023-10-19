//
//  ViewController.swift
//  13-CurrencyConverter
//
//  Created by Berke Ersiz on 25.08.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cadLabel: UILabel!

    @IBOutlet weak var chfLabel: UILabel!
    
    @IBOutlet weak var gbpLabel: UILabel!
    
    @IBOutlet weak var jpyLabel: UILabel!
    
    @IBOutlet weak var usdLabel: UILabel!
    
    @IBOutlet weak var tryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func getRatesClicked(_ sender: Any) {
        // Uc Adim.
        // 1- Request & Session
        // 2- Response & Data
        // 3- Parsing & JSON Serialization
        
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=8d55c01d099e797410655bef53cd1c53&format=1")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            // Step 1
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            }else{
               // Step 2
                if data != nil {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>//jsonResponse any iken onu dictionarye cevirdim.
                        
                        //ASYNC --> Kullanici arayüzümüz kitlenmesin islemler olurken.
                        DispatchQueue.main.async {
                            // Step 3
                            // Rateste kendi icinde bir dictionary actigi icin bu islemi tekrarladik.
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                //print(rates)
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = "CAD: \(cad)"
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = "CHF: \(chf)"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "GBP: \(gbp)"
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = "JPY: \(jpy)"
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "USD: \(usd)"
                                }
                                if let tr = rates["TRY"] as? Double {
                                    self.tryLabel.text = "TRY: \(tr)"
                                }
                            }
                        }
                        
                        } catch {
                        print("Error")
                    }
                    
                }
            }
        }//Completion Handler(Closure) sayesinde bana hata mi geldi veri mi geldi bu cevap ne diyor gibi seyleri kontrol etmem kolaylasicak.
        
        task.resume()//Task diye bir degisken olusturmamizin nedenir budur bu olmadan islem baslamaz.
    }
}

