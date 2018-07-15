//
//  ViewController3.swift
//  MemoApp
//
//  Created by 津田準 on 2018/06/23.
//  Copyright © 2018 津田準. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {

    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        datePicker.datePickerMode = UIDatePickerMode.date
        doneButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 17)!], for :UIControlState.normal)
        backButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 17)!], for :UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
