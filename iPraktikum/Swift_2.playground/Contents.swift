/*:
 # Swift 2
 ## Homework
 
 In this homework we will create a weather station which takes measurements and determines the weather accordingly. ☀️⛈
 
 
 **Task 1:** Create an enumeration called `MeasurementType` which can be `temperature` or `rainfall`.
 */
enum MeasurementType {
    case temperature, rainfall
}

/*:
 **Task 2:** Create a type named `City` that stores the `name` of a city and the `country` it is located in. City should conform to the `CustomStringConvertible` protocol using an extension.
 */
struct City {
    let name: String
    let country: String
}

extension City: CustomStringConvertible {
    var description: String {
        return "\(name) in \(country)"
    }
}
/*:
 **Task 3:** Create a class `WeatherStation`.
 
 **Task 3.1:** The weather station has a private property called `measurements`. This property should be an Array of Tuples of type `(MeasurementType, Double)`. Add a property `city` of type `City` to the class. We should only have to pass an instance of type `City` to the constructor of `WeatherStation`, the measurements Array should be empty after initialization.
 
 **Task 3.2:** Add two ways of adding measurements:
 * One should be a method to add a single measurement using two separate arguments: a type (`MeasurementType`) and a value (`Double`). Use descriptive argument labels here!
 * The other should be a method that allows an arbitrary number of Tuples of type `(MeasurementType, Double)` to be added to the array. 
 
 Hint: use variadic parameters and the `append(contentsOf:)` method offered by `Array`
 
 **Task 3.3** Add two **computed properties** to your class:
 * The property `rainfall` should return the sum of values of all measurements which have the type `.rainfall`.
 * The property `meanTemperature` should return the mean of all measurements of type `.temperature` (return `nil` if there are no measurements, as otherwise you would be dividing by zero)
 * Use two different ways of iterating over the measurements array with a `for` loop: e.g. a `where` statement and pattern matching
 */
class WeatherStation {
    let city: City
    private var measurements: [(measurementType: MeasurementType, measurement: Double)]
    init (city: City) {
        self.city = city
        self.measurements = []
    }
    func add (which measurementType: MeasurementType, what measurement: Double) {
        measurements.append((measurementType, measurement))
    }
    func addArray (measurementArray: [(MeasurementType, Double)]) {
        measurements.append(contentsOf: measurementArray)
    }
    var rainfall: Double {
        get {
            var tempSum = 0.0
            for tmpTuple in measurements {
                switch tmpTuple {
                    case (.rainfall, _):
                        tempSum += tmpTuple.measurement
                    default:
                        break
                }
            }
            return tempSum
        }
    }
    var meanTemperature: Double? {
        get {
            var tempSum = 0.0
            var tempCounter = 0.0
            for (meaurementType, measurement) in measurements where meaurementType == .temperature {
                    tempSum += measurement
                    tempCounter += 1
            }
            if tempCounter > 0 {
                return tempSum/tempCounter
            } else {
                return nil
            }
        }
    }
}
/*:
 **Task 4:** Create an enumeration called `Weather` with three cases: `sunny`, `cloudy` and `rainy`.
 */
enum Weather {
    case sunny, cloudy, rainy
}
/*:
 **Task 5:** Add a private method `determineWeather()` to your weather station.
 * It should return an Optional `Weather?` and return `nil` if there are no measurements yet.
 * Determine a way of returning the correct weather type: e.g. the weather is rainy if there are more than 10mm of rainfall, it’s sunny if the mean temperature is above 20 degrees, otherwise it’s cloudy.
 */
extension WeatherStation {
    private func determineWeather() -> Weather? {
        if rainfall > 10 {
            return .rainy
        }
        if let meanTemperature = meanTemperature, meanTemperature > 20 {
                return .sunny
        }
        if measurements.count == 0 {
                return nil
        }
        return .cloudy
    }
}
/*:
 **Task 6:** Extend `WeatherStation` to make it conform to `CustomStringConvertible`. Implement the `description` property to return a logical textual description of the weather using the result of `determineWeather()`.
 * Use `guard let` to determine if the method returns a value. If not, signal that the weather cannot be determined.
 * Return a textual description of each weather type. Use the properties `city`, `meanTemperature` and `rainfall` to build the description where appropriate.
 
 Example: "Oh no! There is rain in \(city) today! We have rainfall of \(rainfall) mm."
 */
extension WeatherStation: CustomStringConvertible {
    var description: String {
        guard let determinedWeather = determineWeather() else {
            return "Weather cannot be determined!"
        }
        switch determinedWeather {
        case .rainy:
            return "Oh no! There is rain in \(city) today! We have rainfall of \(rainfall) mm."
        case .sunny:
            return "Yeah! It is sunny in \(city) today! Temperature is \(meanTemperature!) degrees"
        default:
            return "Well, it is cloudy in \(city) today"
        }
    }
}
/*:
 **Task 7:** Extend `WeatherStation` to make it conform to `Equatable`. Two instances should be equal if their weather types are equal. You can use the result of `determineWeather()` here as well.
 */
extension WeatherStation: Equatable {
    static func == (lhs: WeatherStation, rhs: WeatherStation) -> Bool {
        return lhs.determineWeather() == rhs.determineWeather()
    }
}
/*:
 **Task 8:** Add a method `compareWeather(to:)` to the WeatherStation class. It should indicate if the two cities have the same or different weather through a `print` statement.
 */
extension WeatherStation {
    func compareWeather(to weatherStation:WeatherStation){
        if self == weatherStation {
            print("\(city.name) has the same weather as \(weatherStation.city.name)!")
        }
    }
}
/*:
 **Task 9:** Create two `WeatherStation` instances, one for Munich and one for e.g. Barcelona. Use a `print` statement on one of them to see what happens if there are no measurements yet.
 */
let munich = City(name: "Munich", country: "Germany")
let barc = City(name: "Barcelona", country: "Spain")
let munichWS = WeatherStation (city: munich)
let barcWS = WeatherStation (city: barc)
print (munichWS.description)
/*:
 **Task 10:** Add at least two measurements of each `MeasurementType` to both weather stations. Use both methods that you created at least once. Print out both instances and use the `compareWeather(to:)` method to see if they are equal.
 */
barcWS.add(which: .rainfall, what: 8)
barcWS.add(which: .temperature, what: 30)
munichWS.addArray(measurementArray: [(.rainfall, 5), (.temperature, 21)])
munichWS.compareWeather(to: barcWS)
/*:
 # Congratulations!
 ## You completed your second Swift homework! 👩‍💻👨‍💻
 Please submit it to your tutor as described in the slides. They will almost certainly have comments, so be prepared to re-iterate based on their feedback.
 
 ## *Optional* Challenge 😎
 Feel free to improve your solution by implementing the following improvements:
 - Add associated values to the Weather enumeration. The case sunny should have an associated value named temperature of type Double and the case rainy should have an associated value named rainfall of type Double too. And make Weather conform to the Equatable protocol. (In Swift 4.1 you don’t have to write a single function 🎉)
 - Rename MeasurementType to Measurement and add unnamed associated values of type Double to each case
 - Adapt the type of the measurements array accordingly and rethink what should be stored in the array
 - Reduce the way to add Measurements to the WeatherStation by reducing it to one function named add(_:) that only uses a variadic parameter
 - Adapt all method calls according to the changes in your code. Use the refactoring tool of Xcode to reduce the number of redundant changes 😉
 */
