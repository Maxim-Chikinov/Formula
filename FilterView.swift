//
//  FilterView.swift
//  Formula
//
//  Created by Chikinov Maxim on 20.06.2024.
//

import SwiftUI

struct FilterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var storage: Storage
    @State private var selectedOrder = DisplayOrderType.alphabetical
    @State private var showFavouriteOnly: Bool = false
    @State private var maxCaloriesLevel = 5
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Сортировка") {
                    Picker("Порядок", selection: $selectedOrder) {
                        ForEach(DisplayOrderType.allCases, id: \.self) {
                            Text($0.text)
                        }
                    }
                }
                Section() {
                    Toggle("Только избранное", isOn: $showFavouriteOnly)
                    Stepper(value: $maxCaloriesLevel, in: 0...10) {
                        Text("Максимальный уровень каллорий: \(maxCaloriesLevel)")
                    }
                } header: {
                    Text("Фильтры")
                } footer: {
                    Text("Применяется по закрытию этого экрана")
                }

            }
            .navigationTitle("Filter")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        storage.displayOrder = selectedOrder.rawValue
                        storage.showFavouriteOnly = showFavouriteOnly
                        storage.maxCaloriesLevel = maxCaloriesLevel
                        dismiss()
                    }
                }
            })
            .onAppear(perform: {
                selectedOrder = .init(rawValue: storage.displayOrder) ?? .alphabetical
                showFavouriteOnly = storage.showFavouriteOnly
                maxCaloriesLevel = storage.maxCaloriesLevel
            })
        }
    }
}

#Preview {
    FilterView().environmentObject(Storage())
}

enum DisplayOrderType: Int, CaseIterable {
    case alphabetical = 0
    case favoriteFirst = 1
    case byDate = 2

    init(type: Int) {
        switch type {
        case 0: self = .alphabetical
        case 1: self = .favoriteFirst
        case 2: self = .byDate
        default: self = .alphabetical
        }
    }

    var text: String {
        switch self {
        case .alphabetical: return "Алфавитный порядок"
        case .favoriteFirst: return "Показывать сначала избранные"
        case .byDate: return "По дате"
        }
    }
    
    func predicate() -> ((RecipeSearchResult.Recipe, RecipeSearchResult.Recipe) -> Bool) {
        switch self {
        case .alphabetical: return { $0.label < $1.label }
        case .favoriteFirst: return { $0.isFavourite && !$1.isFavourite }
        case .byDate: return { $0.shareAs < $1.shareAs }
        }
    }
}
