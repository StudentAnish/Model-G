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
    
    @State private var level: Int = 0
    
    var numCompletedMissions: Int {
        missions.filter{ $0.done }.count
    }
    
    var body: some View {
        VStack(){
            
            Text("Level \(level)")
                .font(.custom("Rajdhani-Bold", size: 40))
                .padding(.bottom, 10)
            
            HStack{
                ForEach(missions) { mission in
                    Image(systemName: mission.done ? "checkmark.circle.fill" : "circle.dashed")
                        .foregroundColor(mission.done ? .cyan : .primary)
                }
            }
            
            List($missions, editActions: .move){$mission in
                Top3MissionRowView(mission: $mission, number: 1)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .leading){
                        Button{
                            mission.done.toggle()
                        } label: {
                            Label("Complete", systemImage: "checkmark")
                                
                        }
                        .tint(.cyan)
                    }
            }
            .listStyle(.plain)
            
            //Text(numCompletedMissions.description)
            
        }
        .padding()
        .navigationBarBackButtonHidden(true)

    }
}

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
        ContentView()
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
