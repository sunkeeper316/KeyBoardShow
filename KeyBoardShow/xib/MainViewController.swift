//
//  MainViewController.swift
//  KeyBoardShow
//
//  Created by 黃德桑 on 2020/5/13.
//  Copyright © 2020 黃德桑. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var tfTop: UITextField!
    @IBOutlet weak var tfCenter: UITextField!
    @IBOutlet weak var tfBottom: UITextField!
    
    var textFieldRealYPosition: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Bundle.main.loadNibNamed(String(describing: MainViewController.self), owner: self, options: nil)
        tfTop.delegate = self
        tfCenter.delegate = self
        tfBottom.delegate = self
        setToolbar(tfTop)
        setToolbar(tfCenter)
        setToolbar(tfBottom)
        // Do any additional setup after loading the view.
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MainViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
      textFieldRealYPosition = textField.frame.origin.y + textField.frame.height
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    func setToolbar(_ textView:UITextField){
        let toolBarHeight:CGFloat = 150
        //製作鍵盤上方幫手
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: toolBarHeight))
        //左邊空白處
        let flexSpace: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        //想製作的按鈕及用途
        let doneBotton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: .done, target: self, action: #selector(doneButtonAction))
        toolBar.setItems([flexSpace,doneBotton], animated: false)
        toolBar.sizeToFit()
        textView.inputAccessoryView = toolBar
    }
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
}
