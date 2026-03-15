//
//  AmbientStoryView.swift
//  Model G
//
//  Created by Anish  Sinha on 3/10/26.
//

import SwiftUI

struct AmbientStoryView: View {
    
    @State var story: Int
    
    var body: some View {
        if(story == 0){
            view0()
        } else if (story == 1){
            view1()
        }
//        ImageCarouselView()
    }
}

struct view0: View {
    
    @State var pageNum: Int = 0
    @State var showNexPage: Bool = false
    
    var body: some View {
        VStack{
            Image("page-\(pageNum)")
                .resizable()
                //.aspectRatio(contentMode: .fit)
                .scaledToFill()
            
                            
            Button{
                withAnimation{
                    if(pageNum < 4) { pageNum += 1 }
                    else {showNexPage = true}
                }
            } label: {
                Image(systemName: "arrow.forward")
                    .scaleEffect(y: -1)
            }
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .font(.system(size: 50))
            .padding(.vertical, 10)
            .navigationDestination(isPresented: $showNexPage){ TutorialView() }
            
        }
        .background(.black)
        .navigationBarBackButtonHidden(true)
    }
}

struct view1: View {
    
    @State var pageNum: Int = 5
    @State var showNexPage: Bool = false
    
    var body: some View {
        VStack{
            Image("page-\(pageNum)")
                .resizable()
                //.aspectRatio(contentMode: .fit)
                .scaledToFill()
            
                            
            Button{
                withAnimation{
                    if(pageNum < 7) { pageNum += 1 }
                    else {showNexPage = true}
                }
            } label: {
                Image(systemName: "arrow.forward")
                    .scaleEffect(y: -1)
            }
            .buttonStyle(.plain)
            .foregroundColor(.white)
            .font(.system(size: 50))
            .padding(.vertical, 10)
            .navigationDestination(isPresented: $showNexPage){ ContentView(level: 1) }
            
        }
        .background(.black)
        .navigationBarBackButtonHidden(true)
    }
}


struct ImageCarouselView: View {
    let imageNames: [String] = ["page-0", "page-1", "page-2", "page-3", "page-4"] // Replace with your image asset names
    
    var body: some View {
        TabView {
            ForEach(imageNames, id: \.self) { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .clipped()
            }
        }
        //.frame(height: 300) // Set a frame for the TabView itself
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)) // Enables horizontal paging with dots
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}


struct AmbientStoryView_Previews: PreviewProvider {
    static var previews: some View {
        AmbientStoryView(story: 0)
        AmbientStoryView(story: 1)
    }
}



//struct view0: View {
//
//    @State var pageNum: Int = 0
//
//    var body: some View {
//        ZStack{
//            Image("page-\(pageNum)")
//                .resizable()
////                .scaledToFit()
//                .scaledToFill()
//                //.aspectRatio(contentMode: .fit)
//
//            VStack(alignment: .center){
//                Spacer()
//
//                HStack{
//                    //Spacer()
//                    Button{
//                        withAnimation{
//                            pageNum = (pageNum + 1) % 5
//                        }
//                    } label: {
//                        Image(systemName: "arrow.up.right.square.fill")
//
//                    }
//                    .buttonStyle(.plain)
//                    .foregroundColor(.black)
//                    .shadow(radius: 0)
//                    .rotationEffect(Angle(degrees: 45))
//                    .font(.system(size: 50))
//                    //Spacer()
//                }
//            }.padding(.bottom, 25)
//        }.ignoresSafeArea()
//    }
//}
