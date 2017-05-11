//
//  ViewController.swift
//  PlistTuto
//
//  Created by Tran Van Tin on 5/11/17.
//  Copyright © 2017 Tran Van Tin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var txtTest: UITextField!

    
    let itemKey = "Item"
    var itemValue: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnSave(_ sender: Any) {
        self.saveData(value: txtTest.text!)
    }
    
    func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let documentDirectory = paths[0] as! String
        let path = documentDirectory.appending("list.plist")
        
        let fileManager = FileManager.default
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "list", ofType: "plist"){
                let result = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle File list.plist is: -> \(String(describing: result?.description))")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {
                    print("Copy Failured!")
                }
            } else {
                print("File list.plist not found!")
            }
        } else{
            print("File list.plist already at path!")
        }
        
        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
        print("Load list.plist is -> \(String(describing: resultDictionary?.description))")
        
        let myDict = NSDictionary(contentsOfFile: path)
        if let dict = myDict {
            itemValue = dict.object(forKey: itemKey) as? String
            txtTest.text = itemValue
        } else {
            print("Load failured!")
        }
    }
    
    func saveData(value:String) {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentDirectory = paths.object(at: 0) as! String
        
        let path = documentDirectory.appending("list.plist")
        
        let dict: NSMutableDictionary = [:]
        
        dict.setObject(value, forKey: itemKey as NSCopying)
        dict.write(toFile: path, atomically: false)
        print("Saved")
    }
}

