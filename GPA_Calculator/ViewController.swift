//
//  ViewController.swift
//  GPA_Calculator
//
//  Created by Joseph Hoang on 2/3/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//
//this application allows users to input scores for a specific class and the calculator outputs gpa based on these scores.

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
    @IBOutlet weak var firstCourse: UILabel!
    @IBOutlet weak var secondCourse: UILabel!
    @IBOutlet weak var thirdCourse: UILabel!
    @IBOutlet weak var fourthCourse: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
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
        var totalPercent: Double = 0
        var finalAssignmentScore: Double = 0
        var finalMidtermScore: Double = 0
        var finalFinalScore: Double = 0
        var credit: Double = 0
        var grade: Double = 0
        var gpa: Double = 0
        let courseName = titleOfCourse.text

        //check for all bubbles to be filled Assign
        if let pointsAssign = Double(assignmentPoint.text!),
            let maxAssign = Double(maxScoreAssignments.text!),
            let percentAssign = Double(percentAssignments.text!){
            finalAssignmentScore = pointsAssign / maxAssign * percentAssign
            totalPercent = totalPercent + percentAssign
        } else {
            print("Invalid inputs in assingments row")
            return
        }
        
        //check for all bubbles to be filled Midterm
        if let pointsMidterm = Double(midtermPoint.text!),
            let maxMidterm = Double(maxScoreMidterm.text!),
            let percentMidterm = Double(percentMidterm.text!){
            finalMidtermScore = pointsMidterm / maxMidterm * percentMidterm
            totalPercent = totalPercent + percentMidterm
        } else {
            print("Invalid inputs in midterm row")
            return
        }
        
        //check for all bubbles to be filled Final
        if let pointsFinal = Double(finalPoint.text!),
            let maxFinal = Double(maxScoreFinal.text!),
            let percentFinal = Double(percentFinal.text!){
            finalFinalScore = pointsFinal / maxFinal * percentFinal
            totalPercent = totalPercent + percentFinal
        } else {
            print("Invalid inputs in final row")
            return
        }
        
        // if total percent = 100 proceed else error
        if totalPercent == 100 {
            
            if let credits = Double(numberOfCredits.text!){
                credit = credits
            } else {
                print("Invalid inputs in credits row")
            }
            
            grade = gradeCheck(finalAssignmentScore, finalMidtermScore, finalFinalScore)
            
            let thisGradeAndWeight = GradeWithWeight(courseTitle: courseName, grades: grade, weights: credit) //create a new struct
            
            gradeAndWeightStorage.append(thisGradeAndWeight) //add course into array
            gpa = gpaCalculation(gradeAndWeightStorage)
            
            printClassAndGrade(gradeAndWeightStorage)
            gpaLabel.text = String(gpa)
            
        } else {
            print("Invalid Percentages")
            return
        }
//
//        }
    }
    
    //prints what is on the chalkboard
    func printClassAndGrade (_ array: [GradeWithWeight]) {
        var letterGrade: String
        var count = 0
        for item in array {
            count = count + 1
            if item.grades == 4.0 {
                letterGrade = "A"
            } else if item.grades == 3.0 {
                letterGrade = "B"
            } else if item.grades == 2.0 {
                letterGrade = "C"
            } else if item.grades == 1.0 {
                letterGrade = "D"
            } else {
                letterGrade = "F"
            }
            
            if count == 1{
                firstCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + letterGrade)
            } else if count == 2 {
                secondCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + letterGrade)
            } else if count == 3 {
                thirdCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + letterGrade)
            } else if count == 4 {
                fourthCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + letterGrade)
            }
            print(item.courseTitle! + "|" + String(Int(item.weights)) + " " + letterGrade)
        }
    }
    
    //checks for Value of final grade
    func gradeCheck(_ firstScore: Double,_ secondScore: Double,_ thirdScore: Double) -> Double{
        if ((firstScore + secondScore + thirdScore) > 90){
            return 4
        } else if ((firstScore + secondScore + thirdScore) < 90 && (firstScore + secondScore + thirdScore)>=80){
            return 3
        } else if ((firstScore + secondScore + thirdScore) < 80 && (firstScore + secondScore + thirdScore)>=70){
            return 2
        } else if ((firstScore + secondScore + thirdScore) < 70 && (firstScore + secondScore + thirdScore)>=60){
            return 1
        } else {
            return 0
        }
    }
    
    //calculates gpa
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

