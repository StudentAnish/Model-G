//
//  AmbientStoryView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct AmbientStoryView: View {
    var body: some View {
        view1()
    }
}

struct view0: View {
    
    @State var pageNum: Int = 0
    
    var body: some View {
        ZStack{
            Image("page-\(pageNum)")
                .resizable()
//                .scaledToFit()
                .scaledToFill()
                //.aspectRatio(contentMode: .fit)
            
            VStack(alignment: .center){
                Spacer()
                
                HStack{
                    Spacer()
                    Button{
                        withAnimation{
                            pageNum = (pageNum + 1) % 5
                        }
                    } label: {
                        Image(systemName: "arrow.up.right.square.fill")
                            
                    }
                    .buttonStyle(.plain)
                    .foregroundColor(.black)
                    .shadow(radius: 0)
                    .rotationEffect(Angle(degrees: 45))
                    .font(.system(size: 50))
                    Spacer()
                }
            }.padding(.bottom, 25)
        }.ignoresSafeArea()
    }
}

struct view1: View {
    
    @State var pageNum: Int = 0
    
    var body: some View {
        VStack{
//            Image(systemName: "square.split.diagonal.2x2")
            Image("page-\(pageNum)")
                .resizable()
                //.aspectRatio(contentMode: .fit)
                .scaledToFill()
            
            //Spacer()
                
            //Text("Story Text")
            
            Button{
                withAnimation{
                    pageNum = (pageNum + 1) % 5
                }
            } label: {
                //Image(systemName: "arrow.up.right.square.fill")
                //Image(systemName: "arrowshape.turn.up.right.fill")
                Image(systemName: "arrow.forward")
                    .scaleEffect(y: -1)
                    
            }
            .buttonStyle(.plain)
            .foregroundColor(.white)
            //.shadow(radius: 0)
            .font(.system(size: 50))
            .padding(.vertical, 10)
            
            
//            NavigationLink(destination: ContentView()){
//                Image(systemName: "arrowshape.turn.up.right.fill")
//                    .scaleEffect(y: -1)
//            }
            
            //Spacer()
        }
        .background(.black)
        .frame(width: .infinity, height: .infinity)
        .navigationBarBackButtonHidden(true)
    }
}

struct AmbientStoryView_Previews: PreviewProvider {
    static var previews: some View {
        AmbientStoryView()
    }
}
