//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer = false
    var questionNumber = 0
    var score = 0
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let firstQuestion = allQuestions.list[0]
//        questionLabel.text = firstQuestion.questionText
        
        nextQuestion()
        
    }
    
    
    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        
        questionNumber = questionNumber + 1
        //        questionNumber += 1
        nextQuestion()
        
        
    }
    
    
    func updateUI() {
//        let questionCount = allQuestions.list.count
        
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        
//        progressBar.frame.size.width = (view.frame.size.width / allQuestions.list.count) * CGFloat(questionNumber + 1)
//        progressBar.frame.size.width = (viewWidthSize / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
        progressBar.layer.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
        
        scoreLabel.text = "Score: \(score)"
        
    }
    
    
    func nextQuestion() {
        
        if questionNumber <= allQuestions.list.count - 1 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        } else {
            //            print("End of Quiz!")
            //            questionNumber = 0
            
            let alert = UIAlertController(title: "Awesome!", message: "You've finished all questions, do you want to start all over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            
//            present(alert, animated: true, completion: nil)
            
            
            // add 1sec delay in presenting alert
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == correctAnswer {
//            print("Correct")
//            Third party library, Progress Bar
//            https://github.com/relatedcode/ProgressHUD
//            ProgressHUD.showSucceed("Correct")
//            ProgressHUD.show(icon: .star)
            ProgressHUD.showSuccess("Nice!")
            score += 1
        } else {
//            print("Wrong!")
            ProgressHUD.showError("Nope!")
        }
    }
    
    
    func startOver() {
        score = 0
        questionNumber = 0
        nextQuestion()
    }
}
