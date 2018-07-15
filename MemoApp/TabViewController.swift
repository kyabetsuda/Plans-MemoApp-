//
//  TabViewController.swift
//  MemoApp
//
//  Created by 津田準 on 2018/07/11.
//  Copyright © 2018 津田準. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello Tabbar!!")
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "pencil")?.withRenderingMode(UIImageRenderingMode.automatic)
        myTabBarItem1.selectedImage = UIImage(named: "pencil")?.withRenderingMode(UIImageRenderingMode.automatic)
        myTabBarItem1.title = ""
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "calendar")?.withRenderingMode(UIImageRenderingMode.automatic)
        myTabBarItem2.selectedImage = UIImage(named: "calendar")?.withRenderingMode(UIImageRenderingMode.automatic)
        myTabBarItem2.title = ""
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        // Do any additional setup after loading the view.
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
