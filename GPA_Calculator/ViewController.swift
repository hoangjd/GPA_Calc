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
    
    @IBOutlet weak var deleteButton: UIButton!
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
    
    @IBOutlet weak var gpaConstant: UILabel!
    @IBOutlet weak var firstCourse: UILabel!
    @IBOutlet weak var secondCourse: UILabel!
    @IBOutlet weak var thirdCourse: UILabel!
    @IBOutlet weak var fourthCourse: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    
    struct GradeWithWeight {
        var courseTitle: String?
        var grades: Double = -1
        var weights: Double = -1
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
        
        // if 4 courses have already been input dont do this
        if gradeAndWeightStorage.count < 4 {
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
                gpaCalculation(gradeAndWeightStorage)
                
                printClassAndGrade(gradeAndWeightStorage)
                
            } else {
                print("Invalid Percentages")
                return
            }
        }
    }
    
    @IBAction func deleteButtonPush(_ sender: UIButton) {
        //optional Binding
        if let possibleInt = Int(deleteCourseNumber.text!){
            if (possibleInt > 0) && (possibleInt <= 4) && (gradeAndWeightStorage.count >= possibleInt) {
                deleteCourse(numberToBeDeleted: possibleInt - 1)
            }
        } else {
            return
        }
    }
    
    
    func deleteCourse(numberToBeDeleted: Int){
        if gradeAndWeightStorage[numberToBeDeleted].weights == -1{
            return
        } else {
            gradeAndWeightStorage.remove(at: numberToBeDeleted)
            gpaCalculation(gradeAndWeightStorage)
            printClassAndGrade(gradeAndWeightStorage)
        }
    }
    
    //prints what is on the chalkboard
    func printClassAndGrade (_ array: [GradeWithWeight]) {
        
        clearBoard()
        var grade: String
        var count = 0
        for item in array {
            count = count + 1
            grade = returnLetterGrade(item)
            
            if count == 1{
                firstCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + grade)
            } else if count == 2 {
                secondCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + grade)
            } else if count == 3 {
                thirdCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + grade)
            } else if count == 4 {
                fourthCourse.text = (String(count) + ") " + item.courseTitle! + " | " + String(Int(item.weights)) + " " + grade)
            }
        }
    }
    
    func returnLetterGrade(_ grade: GradeWithWeight) -> String {
        var finalLetterGrade: String
        if grade.grades == 4.0 {
            finalLetterGrade = "A"
        } else if grade.grades == 3.0 {
            finalLetterGrade = "B"
        } else if grade.grades == 2.0 {
            finalLetterGrade = "C"
        } else if grade.grades == 1.0 {
            finalLetterGrade = "D"
        } else {
            finalLetterGrade = "F"
        }
        return finalLetterGrade
    }
    
    //checks for Value of final grade
    func gradeCheck(_ firstScore: Double,_ secondScore: Double,_ thirdScore: Double) -> Double{
        
        var firstScore = firstScore
        var secondScore = secondScore
        var thirdScore = thirdScore
        
        if firstScore.isNaN {
            firstScore = 0
        }
        if secondScore.isNaN {
            secondScore = 0
        }
        if thirdScore.isNaN {
            thirdScore = 0
        }
        
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
    func gpaCalculation(_ array: [GradeWithWeight]) {
        var updateGPA: Double
        var credit: Double = 0
        var grade: Double = 0
        
        for items in array{
            grade = grade + (items.weights * items.grades)
            credit = credit + items.weights
        }
        if !((grade/credit).isNaN) {
            updateGPA = grade/credit
            updateGPA = Double(round(100*updateGPA)/100)
            gpaLabel.text = String(updateGPA)
            gpaColorChange(updateGPA)
        } else {
            gpaLabel.text = ""
            gpaLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func gpaColorChange (_ calculatedGPA: Double) {
        if calculatedGPA >= 3 {
            gpaLabel.textColor = UIColor(red: 60/255, green: 228/255, blue: 14/255, alpha: 1)
            gpaConstant.textColor = UIColor(red: 60/255, green: 228/255, blue: 14/255, alpha: 1)
        } else if calculatedGPA < 3, calculatedGPA >= 2 {
            gpaLabel.textColor = UIColor(red: 255/255, green: 240/255, blue: 59/255, alpha: 1)
            gpaConstant.textColor = UIColor(red: 255/255, green: 240/255, blue: 59/255, alpha: 1)
        } else {
            gpaLabel.textColor = UIColor(red: 255/255, green: 46/255, blue: 59/255, alpha: 1)
            gpaConstant.textColor = UIColor(red: 255/255, green: 46/255, blue: 59/255, alpha: 1)
        }
    }
    
    func clearBoard(){
        firstCourse.text = ""
        secondCourse.text = ""
        thirdCourse.text = ""
        fourthCourse.text = ""
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

