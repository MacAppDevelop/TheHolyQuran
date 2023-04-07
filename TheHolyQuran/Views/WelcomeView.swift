//
//  WelcomeView.swift
//  Quran
//
//  Created by No one on 4/1/23.
//

import SwiftUI
import SQLite3

struct WelcomeView: View {
    var body: some View {
        VStack {
            Image("QuranBook") // Image Source: https://pixabay.com/vectors/koran-quran-book-muslim-islam-5520843/
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300)
                .padding(.vertical)
            
            Text("Free and open source Quran application made for macOS (as well as iPad and iPhone)")
            Link("Project's Github Page", destination: URL(string: "https://github.com/MacAppDevelop/TheHolyQuran")!)
                .padding(.bottom)
            
            Text("Developer Note: Thank you for using this application. Even though I have done my best to ensure that there are no mistakes and everything works correctly, there might still be some issues. Please [let me know](https://github.com/MacAppDevelop/TheHolyQuran) if you find any issues or mistakes so I can fix them.")
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(5)
                .font(.footnote)
            
            Text("All translations are from [Tanzil](https://tanzil.net/trans/) website. Last check for updates: April 7th, 2023")
                .font(.footnote)
                .padding(.top)
                .bold()
        }
        .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
