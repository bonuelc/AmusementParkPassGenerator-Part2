//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Christopher Bonuel on 7/15/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    var sound: SystemSoundID = 0
    
    enum Access {
        case Granted
        case Denied
        
        private var filename: String {
            switch(self) {
            case .Granted: return "AccessGranted"
            case .Denied: return "AccessDenied"
            }
        }
        
        var url: NSURL {
            let path = NSBundle.mainBundle().pathForResource(self.filename, ofType: "wav")!
            return  NSURL(fileURLWithPath: path)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func scan(entrant: EntrantType, accessType: AccessType) {
        if Scanner.scan(entrant, accessType: accessType) {
            print("Access to \(accessType) is granted")
            playSound(Access.Granted.url)
        } else {
            print("Access to \(accessType) is denied")
            playSound(Access.Denied.url)
        }
    }
    
    func playSound(url: NSURL) {
        AudioServicesCreateSystemSoundID(url, &sound)
        AudioServicesPlaySystemSound(sound)
    }
}