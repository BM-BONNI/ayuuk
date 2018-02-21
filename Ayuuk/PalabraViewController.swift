//
//  PalabraViewController.swift
//  Ayuuk
//
//  Created by BM-BONNI on 19/02/18.
//  Copyright © 2018 BM-BONNI. All rights reserved.
//

import UIKit
import AVFoundation

class PalabraViewController: UIViewController {
    @IBOutlet weak var lblAyuuk: UILabel!
    @IBOutlet weak var lblAmexan: UILabel!
    @IBOutlet weak var imgAap: UIImageView!
    @IBOutlet weak var btnMedowit: UIButton!
    
    
    var playerItem:AVPlayerItem?
    var player:AVPlayer?
    
    var medow:String!
    var aap:String!
    var palabra:PalabraStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        lblAyuuk.text = palabra?.mixe
        lblAmexan.text = palabra?.español
        self.medow = palabra?.audio
        self.aap = palabra?.imagen
        
        if medow.isEmpty{
            btnMedowit.isHidden=true
        }
        //print(palabra?.mixe as Any)
        //print(palabra?.español as Any)
        //print(palabra?.audio as Any)
        //print(palabra?.imagen as Any)
        viewImage()
    }
    
    @IBAction func btnMedow(_ sender: Any) {
        if medow.isEmpty{
            
        }else{
            let medowParse = medow.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
            let url = URL(string: "http://diidxa.itistmo.edu.mx/app/capturista/traduccion/mixe/"+medowParse)
            //let url = URL(string: "http://localhost:8888/app/capturista/traduccion/mixe/"+medowParse)
            if url != nil{
                playerItem = AVPlayerItem(url: url!)
                player=AVPlayer(playerItem: playerItem!)
                
                _=AVPlayerLayer(player: player)
                player!.play()
            }
        }
    }
    
    func viewImage(){
        if aap.isEmpty{
            self.imgAap.image=#imageLiteral(resourceName: "notFound.png")
        }else{
            let aapParse = aap.addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
            let imageUrlString = "http://diidxa.itistmo.edu.mx/app/capturista/traduccion/images/\(aapParse)"
            //let imageUrlString = "http://localhost:8888/app/capturista/traduccion/images/\(aapParse)"
            let imageUrl:URL = URL(string: imageUrlString)!
            let imageData:NSData = NSData(contentsOf: imageUrl)!
            
            DispatchQueue.main.async
                {
                    let image = UIImage(data: imageData as Data)
                    self.imgAap.image = image
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
