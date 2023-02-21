//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Igor Ignatov on 05.02.2023.
//

import Foundation
import UIKit

class AlertPresenter {
    func show(controller: UIViewController?, model: AlertModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion()
        }
        guard let viewController = controller else { return }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}

