//
//  CircleProgressViewTest.swift
//  Model G
//
//  Created by Anish  Sinha on 3/15/26.
//

import SwiftUI

struct CircleProgressViewTest: View {
    

    
    var body: some View {
        //CircularCountdownTimer_test()
        //MidnightCountdownView_test()
//        CircularCountdown()
//        CountdownTimer()

        CircleMidnightTimer()
    }
}

// Midnight Circle Countdown Timer
// Circular Countdown Timer
// Circle Timer to Midnight
// Midnight Circle Timer
// Midnight Circle Countdown
// Circle Midnight Timer

struct CircleMidnightTimer: View { //goal: < 48 lines of code
    
    private let size: CGFloat = 300
    
    @State var showTimer = false
    @State var showPlayButton = true
    
    @State var timerRange: ClosedRange<Date>?
    
    var body: some View {
        ZStack{

            if showPlayButton {
                VStack{
                    Button("Play"){
                        //finds today's midnight, then adds 1 day to get tomorrow's midnight
                        let midnight = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!
                        showTimer = true
                        //timerRange = Date()...midnight
                        timerRange = Date()...Date().addingTimeInterval(20)
                        showPlayButton = false
                    }.font(.custom("Rajdhani-Bold", size: 50))
                    Button("Reset"){showTimer = false}
                }
            }

            /* Background Circle */
            Circle().stroke(.secondary.opacity(0.2), lineWidth: 20)
            
            /* Progress Ring */
            if showTimer, let range = timerRange {
                
                TimelineView(.periodic(from: .now, by: 0.1)){ context in
                    
                    let progress = progress(context.date, range)
                    
                    Circle() //foreground circle
                        .trim(from: 0, to: progress)
                        .stroke(LinearGradient(colors: [.primary, .cyan],
                                               startPoint: .top,
                                               endPoint: .bottom),
                                style: StrokeStyle(lineWidth: 20, lineCap: .round))
                        .rotationEffect(Angle(degrees: -90))
                        .onChange(of: progress){ newValue in
                            if(newValue == 1){showPlayButton = true}
                        }
                }
                
                /* Number Timer Countdown */
                VStack {
                    Spacer()
                    Text(timerInterval: range)
                        .font(.system(.body, design: .monospaced))
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                }
            }
        }.frame(width: size, height: size)
    }
    
    private func progress(_ currentTime: Date, _ timerRange: ClosedRange<Date>) -> Double{
        let elapsedTime = currentTime.timeIntervalSince(timerRange.lowerBound)
        let totalTime = (timerRange.upperBound.timeIntervalSince(timerRange.lowerBound))
        let progress = elapsedTime / totalTime
        
        return min(progress, 1)
    }
}

//Starting a timer using a button
struct CountdownTimer: View {
    
    @State var startTime = Date.now
    @State var timerRunning = false
    let max = 10
    
    var body: some View{
        
        ZStack{
            if(!timerRunning){
                Button("Play"){
                    timerRunning = true
                    startTime = Date.now
                }
            } else {
                
                TimelineView(.periodic(from: .now, by: 0.1)){ context in
                    let elapsed = context.date.timeIntervalSince(startTime)
                    let remaining = Swift.max(10 - elapsed, 0)
                    
                    Text(remaining.rounded().description)
                        .onChange(of: remaining){ newValue in
                            if(newValue <= 0){ timerRunning = false}
                        }
                }
            }
        }
    }
}

//My first non Ai attempt at creating a timer - it worked!
struct CircularCountdown: View {
    
    private let size: CGFloat = 300
    @State private var trim = 0.0
    @State private var startTimer = false
    @State private var timerRange = Date()...Date().addingTimeInterval(10)
    
    
    var body: some View {
        VStack{
            ZStack{
                
                Circle() //background circle
                    .stroke(.secondary.opacity(0.2), lineWidth: 20)
                
                if(startTimer){
                    TimelineView(.periodic(from: .now, by: 0.1)){ context in
                        
                        let lowerbound = (context.date.timeIntervalSince(timerRange.lowerBound))
                        
                        let upperbound = (timerRange.upperBound.timeIntervalSince(timerRange.lowerBound))
                        
                        let remaining = upperbound - lowerbound
                        
//                        if(remaining > 0){
                            
                            Circle() //foreground circle
                                .trim(from: 0, to: progress(currentDate: context.date))
                                .stroke(.cyan, style: StrokeStyle( lineWidth: 20, lineCap: .round))
                                .rotationEffect(Angle(degrees: -90))
//                        }
                            
                        
                        
                    }
                    Text(timerInterval: timerRange, countsDown: true)
                }
                
                if(!startTimer){
                    Button("Play"){
                        startTimer = true
                        timerRange = Date()...Date().addingTimeInterval(10)
                    }
                    
                }
            }
            .frame(width: size, height: size)
            
            Slider(value: $trim, in: 0...1).padding()
            Text(trim.description)
            
            
        }
    }
    
    func progress(currentDate: Date) -> Double{
        let lowerbound = (currentDate.timeIntervalSince(timerRange.lowerBound))
        
        let upperbound = (timerRange.upperBound.timeIntervalSince(timerRange.lowerBound))
        
        let progress = lowerbound / upperbound
        print("lowerbound: \(lowerbound) \t upperbound: \(upperbound) \t trim: \(progress)")
        
//        if(progress > 1.05){
//            //startTimer = false
//            progress = 0
//        }
        
        return min(progress, 1)
    }
}

//Gemini countdown
struct CircularCountdownTimer_test: View {
    
    
    // Define your 30-second window
    let timerRange = Date()...Date().addingTimeInterval(10)
    
    var body: some View {
        ZStack {
            // 1. The Visual Ring (Progress)
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 10)
            
            TimelineView(.periodic(from: .now, by: 0.01)) { context in
                Circle()
                    .trim(from: 0, to: getProgress(at: context.date))
//                    .stroke(.primary, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .stroke(
                        LinearGradient(colors: [.primary, .cyan], startPoint: .leading, endPoint: .bottom),
                        style: StrokeStyle(lineWidth: 15, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
            }
            
            // 2. The Built-in Countdown Label
            // This stays in sync with the ProgressView timer logic
            Text(timerInterval: timerRange, countsDown: true)
                .font(.system(.title, design: .monospaced))
                .fontWeight(.bold)
        }
        .frame(width: 200, height: 200)
        .padding()
    }
    
    // Helper to calculate circle fill percentage
    func getProgress(at date: Date) -> Double {
        let elapsed = date.timeIntervalSince(timerRange.lowerBound)
        let total = timerRange.upperBound.timeIntervalSince(timerRange.lowerBound)
        return min(max(elapsed / total, 0), 1)
    }
}

//Gemini Midnight countdown
struct MidnightCountdownView_test: View {
    // Calculate the range once when the view appears
    @State private var range: ClosedRange<Date>?

    var body: some View {
        VStack(spacing: 30) {
            if let timerRange = range {
                ZStack {
                    // Background Track
                    Circle()
                        .stroke(Color.gray.opacity(0.15), lineWidth: 15)
                    
                    // Progress Ring
                    TimelineView(.periodic(from: .now, by: 0.1)) { context in
                        Circle()
                            .trim(from: 0, to: getProgress(at: context.date, in: timerRange))
                            .stroke(
                                LinearGradient(colors: [.primary, .cyan], startPoint: .top, endPoint: .bottom),
                                style: StrokeStyle(lineWidth: 15, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                    }
                    
                    VStack(){
                        // Native Countdown Label
                        Spacer()
                        Text("\(timerInterval: timerRange, countsDown: true)")
                            .font(.system(.body, design: .monospaced))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 30)
                            //.font(.custom("Rajdhani-Bold", size: 50))
                    }
                }
                .frame(width: 250, height: 250)
            }
        }
        .onAppear {
            let now = Date()
            let midnight = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: now))!
            self.range = now...midnight
        }
    }
    
    func getProgress(at date: Date, in range: ClosedRange<Date>) -> Double {
        let elapsed = date.timeIntervalSince(range.lowerBound)
        let total = range.upperBound.timeIntervalSince(range.lowerBound)
        return min(max(elapsed / total, 0), 1)
    }
}



struct CircleProgressViewTest_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressViewTest()
    }
}
