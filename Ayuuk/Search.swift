//
//  ViewController.swift
//  Ayuuk
//
//  Created by BM-BONNI on 29/01/18.
//  Copyright © 2018 BM-BONNI. All rights reserved.
//

import UIKit

class Seach: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var txtPalabra: UITextField!
    @IBOutlet weak var tbPalabras: UITableView!
    
    
    var palabras=[PalabraStatsSearch]()
    
    @IBAction func txtSearch(_ sender: Any, forEvent event: UIEvent)
    {
        downloadJsonPalabra
        {
            self.tbPalabras.reloadData()
        }
        tbPalabras.delegate = self
        tbPalabras.dataSource = self
    }
    @IBAction func btnBuscar(_ sender: UIButton) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return palabras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PalabraCell") as? PalabraList else{return UITableViewCell()}
        //let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        cell.lblcellAyuuk.text=palabras[indexPath.row].mixe
        cell.lblcellAmexan.text=palabras[indexPath.row].español
        
        let imgcell = palabras[indexPath.row].imagen
        
        if imgcell.isEmpty{
            cell.imgcellAap.image=#imageLiteral(resourceName: "notFound")
        }else{
            let imgcellParse = imgcell.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
            if let imageURL = URL(string: "http://diidxa.itistmo.edu.mx/app/capturista/traduccion/images/\(imgcellParse)")
            //if let imageURL = URL(string: "http://localhost:8888/app/capturista/traduccion/images/\(imgcellParse)")
            {
                DispatchQueue.global().async
                {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data
                    {
                        let img = UIImage(data: data)
                        DispatchQueue.main.async
                        {
                            cell.imgcellAap.image=img
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func downloadJsonPalabra(completed: @escaping () ->()){
        let palabra = txtPalabra.text!.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        let url = URL(string: "http://diidxa.itistmo.edu.mx/webservice/busquedaMixe.php?id=\(palabra)")
        //let url = URL(string: "http://localhost:8888/webservice/busquedaMixe.php?id=\(palabra)")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.palabras = try JSONDecoder().decode([PalabraStatsSearch].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{}
            }
        }
        task.resume()
    }
}

