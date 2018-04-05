/*:
 # Swift 1
 ## Homework
 
 In this homework you will apply your newly learned Swift concepts 👩‍💻👨‍💻👩‍💻👨‍💻👩‍💻👨‍💻
 */
import Foundation
/*:
 **Task 1:** Create a class `Developer`. The class should have two properties: `name` of type `String` and `monthsOfSwiftExperience` of type `Int?`. When initializing a new `Developer` instance, we want to configure all properties using initializer parameters.
 */
class Developer {
    let name: String
    var monthOfSwiftExperience: Int?
    init (name: String, monthOfSwiftExperience: Int?){
        self.name = name
        self.monthOfSwiftExperience = monthOfSwiftExperience
        print(swiftExperienceDescription())
    }
}
/*:
 **Task 2:** Create an instance method `swiftExperienceDescription()` with return type `String` to generate a printable
 description of the developer's experience:
 * Use optional binding to check if the property is set. If not, return a description saying that the developer has no Swift experience.
 * If the property has a value, use a `switch` statement to see whether it's equal to 1. If it is, return a description saying that the developer has just finished the intro course.
 * The default case of the `switch` statement should return a description using the developer's name and their months of Swift experience (this sentence, and all others, should be grammatically correct 🤨).
 * Call this method in the initializer you defined before and make sure its result is printed using a `print` statement
 
 **Note**: We added an `extension` for the `Developer` class here. Declare your instance method there. You will learn what this means in the next Swift session, but for now just imagine you are continuing to write code in your class!
 */
extension Developer {
    func swiftExperienceDescription() -> String{
        if let number = monthOfSwiftExperience{
            switch number{
            case 1:
                return "\(self.name) has just finished the intro course"
            default:
                return "\(self.name) has \(number) months of Swift experience"
            }
        } else {
            return "\(self.name) has no Swift experience"
        }
    }
}
/*:
 **Task 3:** Instantiate an instance of `Developer` with your name and no (`nil`) Swift experience.
 Instantiate another instance of `Developer` with the name "Prof. Bruegge" and 36 months of Swift experience.
 */
let me = Developer(name: "Artemii Frolov", monthOfSwiftExperience: nil)
let prof = Developer(name: "Prof. Bruegge", monthOfSwiftExperience: 36)
/*:
 **Task 4:** Create a second class `Course` with two properties: `name` of type `String` and `instructor` of type `String`. When initializing a new `Course` instance, we want to configure all properties using initializer parameters.
 */
class Course {
    let name: String
    let instructor: String
    init (name: String, instructor: String){
        self.name = name
        self.instructor = instructor
    }
}
/*:
 **Task 5:** Create an instance method `attend(course:)` in the class `Developer` which takes one argument course of type `Course?`.
 * Use optional binding to check if the property is set.
 * If the property has a value, check if the lowercase name of the course contains "swift". If so, increase the `monthsSwiftExperience` of the developer by 1 and print a successful participation message detailing the developer's name, the name of the course and the course's instructor.
 */
extension Developer {
    func attend(course: Course?){
        if let cour = course{
            if cour.name.lowercased().range(of:"swift") != nil{
                if var month=self.monthOfSwiftExperience {
                    month += 1
                } else {
                    self.monthOfSwiftExperience = 1
                }
                print("\(self.name) finished course \(cour.name) with instructor \(cour.instructor)")
            }
        }
    }
}
/*:
 **Task 6:** Create an instance of `Course` with the name "Swift Intro Course" and the instructor "Dora, Paul, Lukas and Dominic". Make yourself (the previously created `Developer` instance) attend this course. After that, print your Swift experience to the console using the `swiftExperienceDescription()` method
 */
let sic = Course(name: "Swift Intro Course", instructor: "Dora, Paul, Lukas and Dominic")
me.attend(course: sic)
print(me.swiftExperienceDescription())
/*:
 **Task 7:** Check the console for the output of your print statements and make sure you understand how the code works. Ask your tutor for help if you don't! Play around with the features of the Playground (e.g. try inline debug statements) - you will need these during the rest of the course.
 */

/*:
 # Congratulations!
 ## You completed your first homework! 🎉🎉🎉
 Please submit it to your tutor as described in the slides. They will almost certainly have comments, so be prepared to re-iterate based on their feedback.
 */
