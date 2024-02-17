//
//  BackgroundView.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 31/7/23.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("Background")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity)
            .opacity(0.3)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
