//
//  GroupsView.swift
//  SwiftUICardsDemo
//
//  Created by Artemii Shabanov on 25.11.2020.
//

import SwiftUI

struct GroupsView: View {

    // MARK: - Nested types
    
    private enum Constants {
        static let spacing: CGFloat = 10
    }
    
    // MARK: - Properties
    
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    @State var selectedItem: GroupItem?
    
    var minimumWidth: CGFloat {
        let gridWidth = UIScreen.main.bounds.width - 4 * Constants.spacing
        return sizeCategory.isAccessibilityCategory ? gridWidth : gridWidth / 4
    }
    
    // MARK: - View properties

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: minimumWidth), spacing: Constants.spacing)],
                    alignment: .center,
                    spacing: Constants.spacing
                ) {
                    Section(header: title) {
                        ForEach(MockService.main.groups) { group in
                            ItemButton(item: group) {
                                selectedItem = group
                            }
                            .sheet(item: $selectedItem) { group in
                                CardsView(group: group)
                            }
                        }
                    }
                }
                .padding(Constants.spacing)
            }
            .background(BackgroundView(style: .styleOne))
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .accentColor(.white)
    }
    
    var title: some View {
        Text("Крокодил")
            .foregroundColor(.white)
            .font(.largeTitle)
            .fontWeight(.black)
            .padding(.bottom)
    }
}

// MARK: - Item Button

fileprivate struct ItemButton: View {
    
    let item: GroupItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()

                VStack(alignment: .center, spacing: 5) {
                    Spacer()

                    Text(item.label)
                        .font(.largeTitle)
                        .shadow(color: .white, radius: 2)

                    Text(item.title)
                        .font(.caption)
                        .fontWeight(.bold)
                        .lineLimit(1)

                    Spacer()
                }

                Spacer()
            }
            .background(Color.black.opacity(0.6))
            .cornerRadius(15)
            .foregroundColor(.accentColor)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Previews

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
            .environment(\.sizeCategory, ContentSizeCategory.accessibilityExtraExtraLarge)
    }
}
