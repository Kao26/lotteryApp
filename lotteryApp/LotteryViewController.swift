//
//  LotteryViewController.swift
//  lotteryApp
//
//  Created by Kaoru Tsugane on 2019/07/13.
//  Copyright © 2019 津金薫. All rights reserved.
//

import UIKit
import AVFoundation

class LotteryViewController: UIViewController {

    var list: [String] = []
    
    
//ドラムの音
    var shuffleAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    func shuffleSound() {
        if let sound = Bundle.main.path(forResource: "drum", ofType: ".mp3") {
            shuffleAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            shuffleAudioPlayer.prepareToPlay()
        }
    }
    
    
//結果発表の音
    var resultAudioPlayer: AVAudioPlayer = AVAudioPlayer()
    func resultSound() {
        if let sound = Bundle.main.path(forResource: "result", ofType: "mp3") {
            resultAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
            resultAudioPlayer.prepareToPlay()
        }
    }
    
    
    
//画面読み込み時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleSound()
        resultSound()
    }
    
    
//画面遷移時の処理
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.object(forKey: "list") != nil {
            list = UserDefaults.standard.object(forKey: "list") as! [String]
            //チェック
            print("画面遷移:\(list)")
        }
    }
    
    
    
//結果表示ビュー
    @IBOutlet weak var overView: UIView!
//最終結果発表用ラベル
    @IBOutlet weak var finalResultLabel: UILabel!
//結果表示ラベル（ルーレット表示用）
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
//抽選ボタンを押した時の処理
    @IBOutlet weak var lotteryButton: UIButton!
    @IBAction func lotteryButton(_ sender: Any) {
        if UserDefaults.standard.object(forKey: "list") != nil {
            
            tabBarController?.tabBar.isUserInteractionEnabled = false
            lotteryButton.isHidden = true
            
            for i in 1...70 {
                self.shuffleAudioPlayer.play()
                self.shuffleAudioPlayer.numberOfLoops = 1
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.05 * Double(i)) {
                    self.resultLabel.text = self.list.randomElement()
                    
                    if i == 70 {
                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                                self.overView.isHidden = false
                                self.finalResultLabel.text = self.list.randomElement()
                                self.shuffleAudioPlayer.stop()
                                self.resultAudioPlayer.play()
                            }
                    }
                }
            }
        } else {
            self.showAlert(message: "リストに情報を追加してください")
        }
        
    }
    
    
    
//戻るボタンを押した時の処理
    @IBOutlet weak var backButton: UIButton!
    @IBAction func backButton(_ sender: Any) {
        overView.isHidden = true
        lotteryButton.isHidden = false
        tabBarController?.tabBar.isUserInteractionEnabled = true
        resultLabel.text = "抽選会"
    }
    
    
    
//アラート設定
    func showAlert(message: String) {
        
        let alert = UIAlertController(title: nil, message: message , preferredStyle: .alert)
        
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        
        alert.addAction(close)
        
        present(alert, animated: true, completion: nil)
        
    }
    

    
}
