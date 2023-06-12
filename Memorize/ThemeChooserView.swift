//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Maryia Karpava on 08/06/2023.
//

import SwiftUI

struct ThemeChooserView: View {
    @EnvironmentObject var store: ThemeStore
    @State private var editMode: EditMode = .inactive
    @State private var editing = false
    @State private var selectedTheme: Theme?

    
    private var addNewThemeButton: some View {
            Button {
            
            } label : {
                Image(systemName: "plus")
            }
    }
    
//    private func getDestination(for theme: Theme) -> some View{
//            if games[theme] == nil {
//                let newGame = EmojiMemoryGame(theme: theme)
//                games.updateValue(newGame, forKey: theme)
//                return EmojiMemoryGameView(game: newGame)
//            }
//            return EmojiMemoryGameView(game: games[theme]!)
//    }
    
    
//    private func destinationForChosenTheme() -> some View {
//
//
//
//
//        return ContentView(viewModel: <#T##EmojiMemoryGame#>)
//    }
//
    
    func makeTapGesture(selectedTheme: Theme) -> some Gesture {
        TapGesture().onEnded {
            self.selectedTheme = selectedTheme
        }
    }
    

    
    var body: some View {
        VStack { // TODO: do we need this stack?
            NavigationView {
                List {
                    ForEach(store.themes) { theme in
                        NavigationLink(destination: ContentView(viewModel: EmojiMemoryGame(theme: theme))) {
                            VStack(alignment: .leading) {
                                let color = Color(rgbaColor: theme.colour)
                                
                                Text(theme.name).foregroundColor(color)
                                Text(theme.emojis.joined())
                                
                            }
                            .lineLimit(1)
                            .gesture(editMode == .active ? makeTapGesture(selectedTheme: theme) : nil)
                        }
                    }
                    //teach the ForEach how to delete items
                    // at the indices in indexSet from its array
                    .onDelete { indexSet in
                        
                    }
                    // teach the ForEach how to move items
                    // at the indices in indexSet to a newOffset in its array
                    .onMove { indexSet, newOffset in
                        
                    }
                }
                .navigationTitle("Memorize") // TODO: should it belong here (to the List) or to the NavigationView?
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    addNewThemeButton
                    EditButton()
                }
                .environment(\.editMode, $editMode)
                .sheet(item: $selectedTheme) { theme in
                    let indexOfSelectedTheme = store.themes.firstIndex(where: { $0.id == theme.id })
                    ThemeEditor(theme: $store.themes[indexOfSelectedTheme!])
                }
            }
        }
        
    }
}

struct ThemeChooserView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
    }
}


