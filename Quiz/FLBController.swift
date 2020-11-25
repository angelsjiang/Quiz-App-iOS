//
//  FLBController.swift
//  Quiz
//
//  Created by Angel Jiang on 11/24/20.
//

import UIKit

class FLBController: UIViewController {
    
    // FLB
    @IBOutlet var FLBQuestionLabel: UILabel!
    @IBOutlet var FLBNextBtn: UIButton!
    @IBOutlet var FLBSubmitBtn: UIButton!
    @IBOutlet var usrData: UITextField!
    
    // need a score board to sync
    var FLBScore: Int = 0
    
    let FLBQuestions: [String] = [
        "How many elements are on the Periodic table?",
        "How many members are in the K-pop group named BTS?",
        "On average, how many seeds does a strawberry have on its surface?"
    ]
    
    let answers: [String] = ["118", "7", "200"]
    
    var currentQuestionIndex: Int = 0
    
    
    let correctAlertContent = NSAttributedString(string: "That was correct!", attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
        NSAttributedString.Key.foregroundColor : UIColor.green])
    let correctAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    let wrongAlertContent = NSAttributedString(string: "Sorry that was incorrect!", attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
        NSAttributedString.Key.foregroundColor : UIColor.red])
    let wrongAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    
    @IBAction func checkForEmpty(_ sender: UIButton) {
        
        if usrData.text == answers[currentQuestionIndex] {
            FLBScore += 1
            print("score is: " , FLBScore)
            Resources.resources.flbScore = FLBScore
            Resources.resources.correctAns += 1
            
            correctAlert.setValue(correctAlertContent, forKey: "attributedTitle")
            self.present(correctAlert, animated: true, completion: {
                self.correctAlert.view.superview?.isUserInteractionEnabled = true
                self.correctAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertBackgroundTapped)))
            })
        }
        else {
            wrongAlert.setValue(wrongAlertContent, forKey: "attributedTitle")
            self.present(wrongAlert, animated: true, completion: {
                self.wrongAlert.view.superview?.isUserInteractionEnabled = true
                self.wrongAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertBackgroundTapped)))
            })

        }
        
        if currentQuestionIndex >= (FLBQuestions.count - 1) {
            print("in checkForEmpty if: ", currentQuestionIndex)

            FLBNextBtn.isEnabled = false
            FLBNextBtn.alpha = 0.3
            
            FLBSubmitBtn.isEnabled = false
            FLBSubmitBtn.alpha = 0.3
        }
        else {
            print("in checkForEmpty else: ", currentQuestionIndex)
            FLBNextBtn.isEnabled = true
            FLBNextBtn.alpha = 1

            FLBSubmitBtn.isEnabled = false
            FLBSubmitBtn.alpha = 0.3
        }
        
    }

    

    // to dismiss alert
    @objc func alertBackgroundTapped () {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func showNextQuest(_ sender: UIButton) {

        currentQuestionIndex += 1

        if currentQuestionIndex < FLBQuestions.count {
            // need to find a way to prevent index going out of bound
            FLBQuestionLabel.text = FLBQuestions[currentQuestionIndex]
            usrData.text = ""
            
            FLBNextBtn.isEnabled = false
            FLBNextBtn.alpha = 0.3
            FLBSubmitBtn.isEnabled = true
            FLBSubmitBtn.alpha = 1

        }
        else {
            FLBNextBtn.isEnabled = false
            FLBNextBtn.alpha = 0.3

            FLBSubmitBtn.isEnabled = false
            FLBSubmitBtn.alpha = 0.3
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        usrData.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FLBQuestionLabel.text = FLBQuestions[0]
        
        FLBNextBtn.isEnabled = false
        FLBNextBtn.alpha = 0.3
    }
}
