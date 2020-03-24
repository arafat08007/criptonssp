//
//  ViewController.swift
//  CriptoniOS
//
//  Created by PTVL on 24/3/20.
//  Copyright © 2020 PTVL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var useridfeild: UITextField!
    var BASE_URL = "http://ba.pakizatvl.com:8070/CRAPI.asmx"
    
    
    @IBOutlet weak var passwordfeild: UITextField!
    let alert = UIAlertController(title: "Missing", message: "User id or password missing", preferredStyle: .alert)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButton(_ sender: Any) {
        
        
       // let userid      =
      //  let userpass    =
        
       // print("Login button clicked\()\(userpass)")
        useridfeild.text = "rupun"
        passwordfeild.text = "Rupun"
        
        
        if((useridfeild.text!.isEmpty) || (passwordfeild.text!.isEmpty)){
        let alertController = UIAlertController(title: "Missing", message:
            "User id or password missing", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
        }
        else {
            if( checkLogin(Uid: useridfeild.text!,UPas: passwordfeild.text!,BASE_URL: BASE_URL)){
                let alertController = UIAlertController(title: "Login", message:
                    "Please wait...", preferredStyle: .alert)
                
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            else{
                let alertController = UIAlertController(title: "Mismatch!", message:
                    "User id or password did not match!", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func checkLogin(Uid : String, UPas: String,BASE_URL:String!) -> Bool {
        let login_api = String(BASE_URL+"/GetUserLogin")
        var islogin : Bool = false
        //return true
       
        
        let user_id     :String = String(Uid)
        let user_pass   :String = String(UPas)
        
        print("Paramas \(user_id)\(user_pass)\(login_api)")
        
        
       let params = ["Uid":Uid, "Upas":UPas] as Dictionary<String, String>
        
        
        var request = URLRequest(url: URL(string: login_api)!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/text", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                print(json)
                islogin = true
            } catch {
                islogin = false
                print("error")
            }
        })
        
        task.resume()
        return islogin
    
}
}

