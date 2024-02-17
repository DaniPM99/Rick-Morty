//
//  SwapPageView.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 31/7/23.
//

import SwiftUI

struct SwapPageView: View {
    var image: UIImage
    var text: String
    
    var body: some View {
            VStack {
                ImageView(image: Image(uiImage: image))
                ZStack{
                    Text("")
                        .frame(width: UIScreen.main.bounds.width, height: 75)
                        .background(Color.gray)
                    Text(text)
                        .foregroundColor(Color.black)
                }
                .offset(CGSize(width: 0, height: -82))
                .opacity(0.7)
            }
        }
}

struct SwapPageView_Previews: PreviewProvider {
    static var previews: some View {
        SwapPageView(image: UIImage(named: "BackImage")!, text: "Previous Page")
    }
}
