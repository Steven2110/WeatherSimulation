//
//  WeatherViewModel.swift
//  WeatherSimulation
//
//  Created by Steven Wijaya on 30.05.2023.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var date: Date
    @Published var weather: Weather = SUNNY
    
    private var dateComponents: DateComponents = DateComponents()
    
    init() {
        let today: Date = Date()
        let calendar = Calendar.current
        
        let day = calendar.component(.day, from: today)
        let month = calendar.component(.month, from: today)
        let year = calendar.component(.year, from: today)
        
        var currDateComponents: DateComponents = DateComponents()
        currDateComponents.day = day
        currDateComponents.month = month
        currDateComponents.year = year
        currDateComponents.hour = 0
        currDateComponents.minute = 0
        currDateComponents.second = 0
        
        date = calendar.date(from: currDateComponents)!
    }
    
    func simulate() {
        continuousMarkovProcess(currentState: weather.state)
    }
    
    func continuousMarkovProcess(currentState: Int) {
        print("Before: \(date)")
        let prob = Q[currentState - 1][currentState - 1]
        let time = Int(log(Double.random(in: 0.0...1.0)) / prob)
        print("Curr Q: \(prob)")
        print("Time: \(time)")
        
        var probabilitiesArray = Q[currentState - 1].map{ -$0 / prob }
        probabilitiesArray[currentState - 1] = 0.0
        
        let newState = getNextState(probabilities: probabilitiesArray)
        weather = getWeatherState(newState)
        
        dateComponents.hour = time > 1 ? time : 1
        date = Calendar.current.date(byAdding: dateComponents, to: date)!
    }
    
    private func getNextState(probabilities: [Double]) -> Int {
        var a = Double.random(in: 0.0...1.0)
        var i = 0
        
        repeat {
            a -= probabilities[i]
            i += 1
        } while a > 0.0
        
        print(i)
        return i
    }
}
