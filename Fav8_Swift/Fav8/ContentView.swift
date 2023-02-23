//
//  ContentView.swift
//  Fav8
//
//  Created by Administrator on 11/28/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainScreen(viewAdapter: .init())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
