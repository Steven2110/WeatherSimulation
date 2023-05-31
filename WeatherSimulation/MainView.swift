//
//  MainView.swift
//  WeatherSimulation
//
//  Created by Steven Wijaya on 30.05.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var timer: Timer?
    @State private var isOnGoing: Bool = false
    
    @ObservedObject var vm: WeatherViewModel = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image(systemName: vm.weather.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150)
                    .symbolRenderingMode(.multicolor)
                Text(vm.weather.description).font(.title)
                Spacer()
                Button {
                    if !isOnGoing {
                        isOnGoing = true
                        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                            withAnimation {
                                vm.simulate()
                            }
                        }
                    } else {
                        timer?.invalidate()
                        isOnGoing = false
                    }
                } label: {
                    startButton
                }.padding()
            }.navigationTitle(vm.date.formatted(date: .numeric, time: .shortened))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension MainView {
    private var startButton: some View {
        Text("Start/Stop")
            .font(.title)
            .foregroundColor(.white)
            .frame(width: 250)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
