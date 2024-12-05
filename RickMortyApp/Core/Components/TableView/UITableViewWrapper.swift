//
//  UITableViewWrapper.swift
//  RickMortyApp
//
//  Created by Rana Mahmoud on 04/12/2024.
//

import SwiftUI
import UIKit

struct UITableViewWrapper: UIViewControllerRepresentable {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var isPresent:Bool
    
    func makeUIViewController(context: Context) -> UITableViewController {
        let controller = UITableViewController(style: .plain)
   
        controller.tableView.allowsSelection = true // Allow selection in the table view
        controller.tableView.tableFooterView = UIView()
        controller.tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.identifier)
        

        
        controller.tableView.delegate = context.coordinator
        controller.tableView.dataSource = context.coordinator
        
        controller.tableView.backgroundColor = .clear
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UITableViewController, context: Context) {
        uiViewController.tableView.reloadData()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(viewModel: viewModel , isPresent: $isPresent)
    }
}

class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
    var viewModel: HomeViewModel
    @Binding var isPresent: Bool
        
    init(viewModel: HomeViewModel, isPresent: Binding<Bool>) {
            self.viewModel = viewModel
            self._isPresent = isPresent
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier, for: indexPath) as! CharacterTableViewCell
        let character = viewModel.characters[indexPath.row]
        cell.selectionStyle = .default
        tableView.allowsSelection = true
        cell.configure(with: character)
        
        if indexPath.row == viewModel.characters.count - 1 {
            viewModel.loadMoreCharacters()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        print(character.status)
        viewModel.selectedCharacter = character
        withAnimation {
            isPresent = true
        }
    }
}

