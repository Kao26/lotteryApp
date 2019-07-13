//
//  ListViewController.swift
//  lotteryApp
//
//  Created by Kaoru Tsugane on 2019/07/13.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list: [String] = []

    @IBOutlet weak var tableView: UITableView!
    
    
    
//画面読み込み時の処理
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    
//画面遷移時の処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "list") != nil {
            list = UserDefaults.standard.object(forKey: "list") as! [String]
            tableView.reloadData()
            //チェック
            print("画面遷移:\(list)")
        }
    }
    

    
//追加ボタンを押した時の処理
    @IBAction func AddButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "追加", message: "参加者の情報を入力してください", preferredStyle: .alert)
        //名前入力用TextField
        alert.addTextField { (text:UITextField!) in
            text.placeholder = "名前入力"
            text.tag = 1
        }
        //ステータス入力用TextField
        alert.addTextField { (text:UITextField!) in
            text.placeholder = "ステータス入力"
            text.tag = 2
        }
        
        //OKボタンを生成
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction) in
            //複数のtextFieldのテキストを格納
            guard let textFields:[UITextField] = alert.textFields else {return}
            
            //名前の情報が入る
            var nameText: String = ""
            //ステータスが入る
            var statusText: String = ""
            
            for textField in textFields {
                
                if textField.text! != "" {
                    
                    switch textField.tag {
                        case 1: nameText = textField.text!
                    case 2: statusText = " : \(textField.text!)"
                        default: break
                    }
                }else{
                    break
                }
                //チェック
                print("nameText：\(nameText)")
                print("statusText：\(statusText)")
                
            }
            
            //最低限名前が入力されていればリストに情報を表示
            if nameText != "" {
                let textf = "\(nameText)\(statusText)"
                self.list.append(textf)
                UserDefaults.standard.set( self.list, forKey: "list" )
                self.tableView.reloadData()
            //名前が入力されていない場合、アラートを表示する。
            } else {
                self.showAlert(message: "名前を入力してください")
            }
            
        }
        //OKボタンを追加
        alert.addAction(okAction)
        //Cancelボタンを生成
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        //Cancelボタンを追加
        alert.addAction(cancelAction)
        //アラートを表示
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
//全てを削除ボタンを押した時の処理
    @IBAction func deleteButton(_ sender: Any) {
        //アラート準備
        let alert = UIAlertController(title: "削除", message: "全て削除してもよろしいですか？", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default)
        let okAction = UIAlertAction(title: "OK", style: .destructive) { (action: UIAlertAction) in
            //削除処理
            UserDefaults.standard.removeObject(forKey: "list")
            self.list = []
            self.tableView.reloadData()
            //チェック
            print("削除後\(self.list)")
        }
        //アラート表示
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
//アラート設定
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
//セルの設定
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //スワイプしたセルを削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
        UserDefaults.standard.set( list, forKey: "list" )
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    
}

