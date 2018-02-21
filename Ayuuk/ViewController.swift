//
//  ViewController.swift
//  Example1
//
//  Created by BM-BONNI on 29/01/18.
//  Copyright © 2018 BM-BONNI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var txtPalabra: UITextField!
    @IBOutlet var lblRes: UILabel!

    @IBAction func btnBuscar(_ sender: UIButton) {
        getWebServicePalabra()
    }
    
    func getWebServicePalabra(){
        let palabra = txtPalabra.text!
        let url = URL(string: "http://localhost/webservice/busquedaMixe.php?id="+palabra)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if let content = data
            {
                do{
                    /*let json = try JSONSerialization.jsonObject(with: content, options: .mutableContainers)
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    var jsonString = String()
                    jsonString = String(data: jsonData, encoding: .utf8)!
                    print(jsonString)*/
                    
                    if let myJSON = try JSONSerialization.jsonObject(with: content, options: .mutableContainers) as? [[String:Any]]{
                        for data in myJSON
                        {
                            DispatchQueue.main.async
                            {
                                self.lblRes.text = data["mixe"] as? String
                            }
                        }
                    }
                }
                catch{ print(error) }
            }
        }
        task.resume()
    }
}
