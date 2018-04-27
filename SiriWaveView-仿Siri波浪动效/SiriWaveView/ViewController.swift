//
//  ViewController.swift
//  SiriWaveView
//
//  Created by William on 2018/4/26.
//  Copyright © 2018年 William. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var wave : SiriWaveView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.wave = SiriWaveView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: 300))
        wave?.backgroundColor = UIColor.clear
        
        self.view.addSubview(self.wave!)
        self.wave?.wavePlay()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wave?.strokeColor = UIColor.yellow
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

