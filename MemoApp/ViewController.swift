//
//  ViewController.swift
//  MemoApp
//
//  Created by 津田準 on 2018/06/20.
//  Copyright © 2018 津田準. All rights reserved.
//

import UIKit
import CoreData
import FSCalendar
import CalculateCalendarLogic

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    var instanceGMS : GetMatchStrings
    
    init(){
        instanceGMS = GetMatchStrings()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        instanceGMS = GetMatchStrings()
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

        var Memos: [NSManagedObject] = []

        //CoreDataからテキストを呼び出す
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Test")
        let predict = NSPredicate(format: "%K=%@", "name", "test")
        fetchRequest.predicate = predict
        do {
            Memos = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

        //テキストビューに値をセットする
        textView.text = Memos[0].value(forKey: "text") as? String
        
        //NotificationCenterを使ってTextViewにイベントリスナーを追加する
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.write),
            name: NSNotification.Name.UITextViewTextDidChange,
            object: nil
        )
        
        //テキストビューのスクロール範囲設定(文字キーボード下隠れる対策)
        textView.isScrollEnabled = true
        textView.contentInset = UIEdgeInsetsMake(0, 0, (textView.contentSize.height/2), 0)
        
        //テキストビューのフォントを変更する
        textView.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        //ナビゲーションバーを透明にする
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        //ナビゲーションバーのフォントを変更する。
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Light", size: 17)!]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let searchedString : String! = appDelegate.date
        if appDelegate.flg == true{
            let text = textView.text
            //本文を変換しておく
            let insertedText = NSMutableString(string : text!)
            let searchedText : NSString = insertedText
            //マッチする文字列の場所を特定
            let loc = searchedText.range(of: searchedString).location
            scroll(to: loc)
            appDelegate.flg = false
        }
        //テキストビューのスクロール範囲設定(文字キーボード下隠れる対策)
//        textView.isScrollEnabled = true
//        textView.contentInset = UIEdgeInsetsMake(0, 0, (textView.contentSize.height), 0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //テキストビューの値が変わるたびに呼び出されるメソッド。テキストのデータを保存している。
    @objc func write(){
        var Memos: [NSManagedObject] = []

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Test")
        let predict = NSPredicate(format: "%K=%@", "name", "test")
        fetchRequest.predicate = predict
        do {
            Memos = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let memo = Memos[0] as! Test
        memo.setValue(textView.text, forKey: "text")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        //テキストビューのスクロール範囲設定(文字キーボード下隠れる対策)
        textView.isScrollEnabled = true
        textView.contentInset = UIEdgeInsetsMake(0, 0, (textView.contentSize.height/2), 0)
    }
    
    
    //デートピッカーから戻ってきたときに実行されるメソッド
    @IBAction func backToTop(segue: UIStoryboardSegue) {
        let secondVC = segue.source as! ViewController3
        let datePicker = secondVC.datePicker
        let date1 = datePicker?.date
        
        //正規表現
        let pattern = "[0-9]{4}/[0-9]{1,2}/[0-9]{1,2}"
        //メモ本文
        let text = textView.text
        //本文からpatternにマッチするものを配列に格納
        let matches = instanceGMS.getMatchStrings(targetString: text!, pattern: pattern)
        //本文を変換しておく
        let insertedText = NSMutableString(string : text!)
        var searchedText : NSString = insertedText
        
        //日付を比べて、正しい位置に挿入する
        let formatter = DateFormatter()
        formatter.dateFormat  = "yyyy/MM/dd";
        compareDates : if matches.count == 0{
            insertedText.append("\n" + formatter.string(from: date1!) + "\n")
        }else{
            for matched in matches {
                let date2 : Date = formatter.date(from : matched)!
                if date1! < date2 {
                    //マッチする文字列の場所を特定
                    let loc = searchedText.range(of: matched).location
                    //日付挿入
                    insertedText.insert(formatter.string(from: date1!) + "\n\n\n", at: loc)
                    break compareDates
                }
            }
            //選択した日付が最新である場合は、テキストの最後に追加する
            insertedText.append("\n" + formatter.string(from: date1!) + "\n")
        }
        //テキストビューに日付挿入ごのテキストを設定
        textView.text = insertedText as String!
        //挿入した箇所までスクロール
        searchedText = NSMutableString(string : textView.text)
        let loc = searchedText.range(of: formatter.string(from: date1!)).location
        scroll(to: loc)
    }
    
    
    //好きな箇所にスクロールできるメソッド
    func scroll(to : Int) {
        textView.scrollRangeToVisible(NSRange(location: to, length: 0))
        textView.selectedRange = NSRange(location: to, length: 0)
    }
    
    @IBAction func back(segue: UIStoryboardSegue) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.textView.resignFirstResponder()
    }

}

