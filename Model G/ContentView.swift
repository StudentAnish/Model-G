//
//  ContentView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct Mission: Identifiable {
    /// Mission ID ( UUID() creates a universally unique ID )
    private(set) var id = UUID()
    
    /// Mission Name
    var name: String
    
    /// when Mission is created
    private(set) var dateCreated: Date = .now
    
    var inPlay: Bool
    
    var done: Bool = false
}

//rename MainView?
struct ContentView: View {
    
    @State var missions: [Mission] =
    [Mission(name: "", inPlay: false),
     Mission(name: "", inPlay: true),
     Mission(name: "", inPlay: false)]
    
    
    @State private var showTimer = false
    @State private var showPlayButton = true
    
    
//    @State private var level: Int = 0
    @State var level: Int
    
    var numCompletedMissions: Int {missions.filter{ $0.done }.count}
    
    @State private var showCongrats: Bool = false
    
    var body: some View {
        VStack(){
            
            RingMidnightTimer(showPlayButton: $showPlayButton)
                .overlay{
                    VStack{
                        
                        if(showPlayButton){}
                        else{
                            Text("Level \(level)")
                                .font(.custom("Rajdhani-Bold", size: 40))
                                .padding(.bottom, 10)
                            
                            HStack{
                                ForEach(missions) { mission in
                                    Image(systemName: mission.done ? "checkmark.circle.fill" : "circle.dashed")
                                        .foregroundColor(mission.done ? .cyan : .primary)
                                }
                            }
                        }
                    }
                }.padding(.vertical, 60)

            List($missions, editActions: .move){$mission in
                Top3MissionRowView(mission: $mission, number: 1)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .leading){
                        Button{
                            mission.done.toggle()
                            if(numCompletedMissions == 3){
                                level += 1
                                showCongrats = true
                            }
                        } label: {
                            Label("Complete", systemImage: "checkmark")
                        }
                        .tint(.cyan)
                    }
            }
            .listStyle(.plain)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $showCongrats){CongratsView()}
    }
}



                            /* Component Views */

struct RingMidnightTimer: View { //goal: < 48 lines of code
    
    private let size: CGFloat = 300
    
    @State var showTimer = false
    @Binding var showPlayButton: Bool
    
    @State var timerRange: ClosedRange<Date>?
    
    var body: some View {
        ZStack{

            if showPlayButton {
                VStack{
                    Button("Start Day"){
                        //finds today's midnight, then adds 1 day to get tomorrow's midnight
//                        let midnight = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))!
                        showTimer = true
//                        timerRange = Date()...midnight
                        timerRange = Date()...Date().addingTimeInterval(10)
                        showPlayButton = false
                    }.font(.custom("Rajdhani-Bold", size: 50))
                    //Button("Reset"){showTimer = false}
                }
            }

            /* Background Circle */
            Circle().stroke(.secondary.opacity(0.2), lineWidth: 20)
            
            /* Progress Ring */
            if showTimer, let range = timerRange {
                
                TimelineView(.periodic(from: .now, by: 1.0)){ context in
                    
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
                        .onTapGesture {
                            showTimer = false
                            showPlayButton = true
                        }
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



/**
 * Top 3 Mission Row Views
 */
struct Top3MissionRowView: View {
    
    @Binding var mission: Mission
    var number: Int
    
    var body: some View{
        HStack{
            TextField("enter your mission", text: $mission.name)
                //.font(.custom("Rajdhani-Medium", size: 18))
                .lineLimit(2)
        
       
            Image(systemName: "play.circle.fill")
                .font(.system(size: 20))
                .onTapGesture {
                    withAnimation{
                        mission.inPlay.toggle()
                        //mission.done.toggle()
                    }
                }
            
        }
        .frame(maxWidth: .infinity)
        .padding(20) //internal padding
        .background(Color(.systemBackground)).cornerRadius(100)
        .shadow(color: .cyan, radius: (mission.inPlay ? 5 : 0) )
        .overlay(
            RoundedRectangle(cornerRadius: 1000)
                .stroke((mission.inPlay ? .cyan : .secondary),
                        lineWidth: (mission.inPlay ? 2 : 1.5)))
        .padding(.vertical, 5) //external padding

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(level: 0)
    }
}

/** Notes:
 
 Why Mission is a struct instead of a class:
 – when the contents of a struct is updated, a new copy of the struct is created and then saved in the old struct's place. If an array of these structs is also declared Published, then Published detects this change (as the copying behaviour changes the array, whereas an array of classes would not be changed as only the property would be updated) triggering the view to update
 – modifiying a property in an object (class) in an array does not update the array, whereas updating a property in a struct does update the array
 
 
 //            Text("🐙")
 //                .font(.system(size: 200))
 //                .shadow(color: .primary, radius: 10)
 **/
