//
//  ViewController.swift
//  Quiz
//
//  Created by Angel Jiang on 11/21/20.
//

import UIKit

class MCQController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MCQ
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var nextBtn: UIButton!
    @IBOutlet weak var answers: UIPickerView!
    

    var MCQScore: Int = 0

    let questions: [String] = [
        "How many stripes are on the American flag?",
        "How many wisdom teeth does the average human have?",
        "In The Little Mermaid Disney cartoon, how many sisters does Ariel have?"
    ]
    
    let pickerDataSet1: [[String]] = [["8", "13", "25", "50"], ["2", "4", "6", "8"], ["2", "4", "5", "6"]]
    let correctAnswer: [String] = ["13", "4", "6"]
    
    var usrChoice = String()

    // initialize the set of questions and answers to be delivered, should increment after user click "Next question"
    var currentQuestionIndex: Int = 0
    
    let correctAlertContent = NSAttributedString(string: "That was correct!", attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
        NSAttributedString.Key.foregroundColor : UIColor.green])
    let correctAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    
    let wrongAlertContent = NSAttributedString(string: "Sorry that was incorrect!", attributes: [
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20),
        NSAttributedString.Key.foregroundColor : UIColor.red])
    let wrongAlert = UIAlertController(title: "", message: "", preferredStyle: .alert)


    @objc func alertControllerBackgroundTapped()
    {
        self.dismiss(animated: true, completion: nil)
    }
        
    @IBAction func showNextQuestion(_ sender: UIButton) {
//        print("from showNextQuestion func, user choice is: " + usrChoice)
//        print("correct answer is: " + correctAnswer[currentQuestionIndex])
//        print(usrChoice == correctAnswer[currentQuestionIndex])
        if usrChoice == correctAnswer[currentQuestionIndex] {
            MCQScore += 1
            Resources.resources.mcqScore = MCQScore
            Resources.resources.correctAns += 1
            
            correctAlert.setValue(correctAlertContent, forKey: "attributedTitle")
            self.present(correctAlert, animated: true,  completion:{
                self.correctAlert.view.superview?.isUserInteractionEnabled = true
                self.correctAlert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            })

            print("Score is: ", MCQScore)
        }
        else {
            
            wrongAlert.setValue(wrongAlertContent, forKey: "attributedTitle")
            self.present(wrongAlert, animated: true, completion: {
                self.wrongAlert.view.superview?.isUserInteractionEnabled = true
                self.wrongAlert.view.superview?
                    .addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.alertControllerBackgroundTapped)))
            })

        }
        currentQuestionIndex += 1


        if currentQuestionIndex != questions.count {
            // need to find a way to prevent index from going out of bound
            let question: String = questions[currentQuestionIndex]
            questionLabel.text = question
            answers.reloadAllComponents()
            answers.selectRow(0, inComponent: 0, animated: true)
        }
        else if currentQuestionIndex == questions.count{
            nextBtn.isEnabled = false
            nextBtn.alpha = 0.3
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data
        self.answers.delegate = self
        self.answers.dataSource = self
        
        questionLabel.text = questions[currentQuestionIndex]
        answers.selectRow(0, inComponent: 0, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // to dispose of any resources that acn be recreated
    }
    
    // Data number column
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    // number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerDataSet1[currentQuestionIndex].count
    }
    
    // data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSet1[currentQuestionIndex][row]
    }
    
    // capture pickerview selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row is: ", row)
        print("current index is: ", currentQuestionIndex)
        usrChoice = pickerDataSet1[currentQuestionIndex][row]
        print(usrChoice)
    }
    
//    @IBAction func done(_ sender: UIButton) {
//        performSegue(withIdentifier: "MCQTotalScore", sender: self)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let finalScoreBoard = segue.destination as! scoreViewController
//        finalScoreBoard.usrScore = self.MCQScore
//    }

}

