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
        CircularCountdown()
    }
}

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
                    TimelineView(.animation(minimumInterval: 1.0, paused: false)){ context in
                    
//                    TimelineView(.periodic(from: Date(), by: 1)){ context in
                    
                        let _ = progress(currentDate: context.date)
                        Circle() //foreground circle
                            .trim(from: 0, to: trim)
                            .stroke(.cyan, lineWidth: 20)
                            .rotationEffect(Angle(degrees: -90))
                    }
                }
                
                if(!startTimer){
                    Button("Start"){
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
    
    func progress(currentDate: Date){
        let lowerbound = (currentDate.timeIntervalSince(timerRange.lowerBound))
        
        let upperbound = (timerRange.upperBound.timeIntervalSince(timerRange.lowerBound))
        
        trim = lowerbound / upperbound
        print("lowerbound: \(lowerbound) \t upperbound: \(upperbound) \t trim: \(trim)")
        
        if(trim > 1){
            startTimer = false
            trim = 0
        }
    }
}

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
