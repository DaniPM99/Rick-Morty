//
//  DetailListView.swift
//  RickAndMorty
//
//  Created by Daniel Parra Martin on 31/7/23.
//

import SwiftUI

struct DetailListView: View {
    
    var character: Character
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 5){
                Spacer()
                Group{
                    DetailRow(leftLabel: Text("Name"), rightLabel: Text(character.name))
                    DetailRow(leftLabel: Text("Status"), rightLabel: Text(character.status))
                    DetailRow(leftLabel: Text("Species"), rightLabel: Text(character.species))
                    DetailRow(leftLabel: Text("Type"), rightLabel: Text(character.type))
                    DetailRow(leftLabel: Text("Gender"), rightLabel: Text(character.gender))
                    DetailRow(leftLabel: Text("Origin"), rightLabel: Text(character.origin.name))
                    DetailRow(leftLabel: Text("Location"), rightLabel: Text(character.location.name))
                    DetailRow(leftLabel: Text("First Episode Appearence"), rightLabel: Text(loadFirstAppearence(character:character)))
                    Button("Back to characters"){
                        dismiss()
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 460)
        .navigationBarBackButtonHidden(true)
        Spacer()
    }
}

// MARK: - Displaying Content

private extension DetailListView {
    func loadFirstAppearence(character: Character) -> String{
        if character.episode.count > 0 {
            let fullEpisode = character.episode[0].components(separatedBy: "/")
            if let epi = fullEpisode.last {
                return epi
            } else {
                return "Not seen yet."
            }
        }
        return "Not seen yet."
    }
}

struct DetailListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailListView(character: Results.mockedData.results[0])
    }
}
