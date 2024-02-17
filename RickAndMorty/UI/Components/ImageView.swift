//
//  ImageView.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 27/7/23.
//

import SwiftUI

struct ImageView: View {
    
    let image: Image
    
    var body: some View {
        image
            .resizable()
            .shadow(color: Color.gray, radius: 4)
            .frame(width: UIScreen.main.bounds.width, height: 400)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: Image("ImageTest"))
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 400))
    }
}
