//
//  TodayPageViewModel.swift
//  25 - Arcitectural Patterns (Additional Task)
//
//  Created by Ani's Mac on 18.11.23.
//

import UIKit

protocol TodayFactsViewModelDelegate: AnyObject {
    func factsFetched(_ text: String)
    func showError(_ error: Error)
}

final class TodayFactsViewModel {
    weak var delegate:TodayFactsViewModelDelegate?
    
    func viewDidLoad() {
        fetchFacts()
    }
    
    private func fetchFacts() {
        NetworkManager.shared.fetchFacts { [weak self] result in
            switch result {
            case .success(let fetchedFacts):
                let textToDisplay = fetchedFacts.text ?? "Default Text"
                self?.delegate?.factsFetched(textToDisplay)
            case .failure(let error):
                self?.delegate?.showError(error)
            }
        }
    }
}

