

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfTop: UITextField!
    @IBOutlet weak var tfCentter: UITextField!
    @IBOutlet weak var tfBottom: UITextField!
    
    var textFieldRealYPosition: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfTop.delegate = self
        tfCentter.delegate = self
        tfBottom.delegate = self
        setToolbar(tfTop)
        setToolbar(tfCentter)
        setToolbar(tfBottom)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeKeyboardObserver()
    }
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let distanceBetweenTextfielAndKeyboard = self.view.frame.height - textFieldRealYPosition - keyboardSize.height
            let Keyboardy = self.view.frame.height - keyboardSize.height
            let distanceBetweenTextfielAndKeyboard = Keyboardy - textFieldRealYPosition
            
            print(distanceBetweenTextfielAndKeyboard)
            //            print(distanceBetweenTextfielAndKeyboard)
            if distanceBetweenTextfielAndKeyboard < 0 {
                UIView.animate(withDuration: 0.4) {
                    self.view.transform = CGAffineTransform(translationX: 0.0, y: distanceBetweenTextfielAndKeyboard)
                }
            }
        }
    }
    
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0.4) {
            self.view.transform = .identity
        }
    }
    
}
extension ViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldRealYPosition = textField.frame.origin.y + textField.frame.size.height
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
