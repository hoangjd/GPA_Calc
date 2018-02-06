//
//  ViewController.swift
//  GPA_Calculator
//
//  Created by Joseph Hoang on 2/3/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var titleOfCourse: UITextField!
    @IBOutlet weak var assignmentPoint: UITextField!
    @IBOutlet weak var midtermPoint: UITextField!
    @IBOutlet weak var finalPoint: UITextField!
    @IBOutlet weak var maxScoreAssignments: UITextField!
    @IBOutlet weak var maxScoreMidterm: UITextField!
    @IBOutlet weak var maxScoreFinal: UITextField!
    @IBOutlet weak var percentAssignments: UITextField!
    @IBOutlet weak var percentMidterm: UITextField!
    @IBOutlet weak var percentFinal: UITextField!
    @IBOutlet weak var numberOfCredits: UITextField!
    @IBOutlet weak var deleteCourseNumber: UITextField!
    
    struct GradeWithWeight {
        var courseTitle: String?
        var grades: Double = 0
        var weights: Double = 0
    }
    
    var gradeAndWeightStorage: [GradeWithWeight] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func AddCourseCalc(_ sender: UIButton) {
        var finalAssignmentScore: Double = 0
        var finalMidtermScore: Double = 0
        var finalFinalScore: Double = 0
        var credit: Double = 0
        var grade: Double = 0
        var gpa: Double = 0
        let courseName = titleOfCourse.text
        
        if let pointsAssign = Double(assignmentPoint.text!),
            let maxAssign = Double(maxScoreAssignments.text!),
            let percentAssign = Double(percentAssignments.text!){
            finalAssignmentScore = pointsAssign / maxAssign * percentAssign
        } else {
            print("Invalid inputs in assingments row")
        }
        
        if let pointsMidterm = Double(midtermPoint.text!),
            let maxMidterm = Double(maxScoreMidterm.text!),
            let percentMidterm = Double(percentMidterm.text!){
            finalMidtermScore = pointsMidterm / maxMidterm * percentMidterm
        } else {
            print("Invalid inputs in midterm row")
        }
        
        if let pointsFinal = Double(finalPoint.text!),
            let maxFinal = Double(maxScoreFinal.text!),
            let percentFinal = Double(percentFinal.text!){
            finalFinalScore = pointsFinal / maxFinal * percentFinal
        } else {
            print("Invalid inputs in final row")
        }
        
        if let credits = Double(numberOfCredits.text!){
            credit = credits
        } else {
            print("Invalid inputs in credits row")
        }
        
        if ((finalAssignmentScore + finalMidtermScore + finalFinalScore) > 90){
            grade = 4
        } else if ((finalAssignmentScore + finalMidtermScore + finalFinalScore) < 90 && (finalAssignmentScore + finalMidtermScore + finalFinalScore)>=80){
            grade = 3
        } else if ((finalAssignmentScore + finalMidtermScore + finalFinalScore) < 80 && (finalAssignmentScore + finalMidtermScore + finalFinalScore)>=70){
            grade = 2
        } else if ((finalAssignmentScore + finalMidtermScore + finalFinalScore) < 70 && (finalAssignmentScore + finalMidtermScore + finalFinalScore)>=60){
            grade = 1
        } else {
            grade = 0
        }
        
        let thisGradeAndWeight = GradeWithWeight(courseTitle: courseName, grades: grade, weights: credit)
        
        gradeAndWeightStorage.append(thisGradeAndWeight)
        
        gpa = gpaCalculation(gradeAndWeightStorage)
  //      gpa = (grade * credit) / creditWeight // end creditWeight needs to change
        
        print(gpa)
//
//        }
    }
    
    func gpaCalculation(_ array: [GradeWithWeight]) -> Double {
        var credit: Double = 0
        var grade: Double = 0
        for items in array{
            grade = grade + (items.weights * items.grades)
            credit = credit + items.weights
       // var gpa: Double = 0
        }
        let gpa = grade/credit
        return gpa
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

