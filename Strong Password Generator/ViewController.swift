//
//  ViewController.swift
//  Strong Password Generator
//
//  Created by Özlem Körpe on 23.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var passwordLengthLabel: UILabel!
    @IBOutlet weak var passwordLengthSlider: UISlider!
    
    @IBOutlet weak var generatedPasswordTextField: UITextField!
    
    
    var possiblePasswordCharactersSet = Set<String>()
    var passwordLength = 10
    
    // Character sets
    let lowerCaseAlphabetSet: Set<String> = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","r","s","t","u","v","w","x","y","z"]
    let upperCaseAlphabetSet: Set<String> = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let numbersSet: Set<String> = ["0","1","2","3","4","5","6","7","8","9"]
    let specialCharactersSet: Set<String> = ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", "[", "]", "{", "}", "|", "\\", ":", ";", "'", "\"", "<", ">", ",", ".", "?", "/", "~"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        possiblePasswordCharactersSet = possiblePasswordCharactersSet.union(lowerCaseAlphabetSet)
        //print("Possible characters are: \(possiblePasswordCharactersSet)")
        
        passwordLengthSlider.minimumValue = 6
        passwordLengthSlider.maximumValue = 20
        passwordLengthSlider.value = 10    }

    @IBAction func includeNumbersEnabled(_ sender: UISwitch) {
        
        if(sender.isOn){
            print("Including numbers is true")
            possiblePasswordCharactersSet = possiblePasswordCharactersSet.union(numbersSet)
        }else{
            print("Including numbers is false")
            possiblePasswordCharactersSet = possiblePasswordCharactersSet.subtracting(numbersSet)
        }
        print("Possible characters are: \(possiblePasswordCharactersSet)")
    }
    
    @IBAction func includeUpperCaseEnabled(_ sender: UISwitch) {
        if(sender.isOn){
            print("Including upper case letters is true")
            possiblePasswordCharactersSet = possiblePasswordCharactersSet.union(upperCaseAlphabetSet)
        }else{
            print("Including upper case letters is false")
            possiblePasswordCharactersSet = possiblePasswordCharactersSet.subtracting(upperCaseAlphabetSet)
        }
        print("Possible characters are: \(possiblePasswordCharactersSet)")
    }
    
    @IBAction func includeSpecialCharactersEnabled(_ sender: UISwitch) {
        if(sender.isOn){
            possiblePasswordCharactersSet = possiblePasswordCharactersSet.union(specialCharactersSet)
        }else{
            possiblePasswordCharactersSet = possiblePasswordCharactersSet.subtracting(specialCharactersSet)
        }
        print("Possible characters are: \(possiblePasswordCharactersSet)")
    }
    
    
    // Set the password length
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        passwordLength = Int(sender.value)
        passwordLengthLabel.text = (String(passwordLength))
        //print("Slider value: \(passwordLength)")
    }
    
    // Generate the password
    @IBAction func generateButtonPressed(_ sender: UIButton) {
        
        //Shuffle the set elements to increase randomness
        let shuffelledPossiblePasswordCharactersSet = possiblePasswordCharactersSet.shuffled()
        
        // Generate Substring of shuffled elements
        let subsetOfPasswordCharacters = Set(shuffelledPossiblePasswordCharactersSet.prefix(passwordLength))
        
        // Combine substring into a string
        let finalPassword = subsetOfPasswordCharacters.joined()
        
        generatedPasswordTextField.text = finalPassword
        
        print("Created password is: \(finalPassword)")
    }
    
    
    @IBAction func copyButtonClicked(_ sender: UIButton) {

        guard let coppiedPassword = generatedPasswordTextField.text else {
                    return
                }
               // Copy text to the clipboard
                UIPasteboard.general.string = coppiedPassword
        
        let alertController = UIAlertController(title: "Text Copied", message: "The text has been copied to the clipboard.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

        
}

