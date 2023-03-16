//
//  MovieQuizViewControllerProtocolMock.swift
//  MovieQuizTests
//
//  Created by Igor Ignatov on 16.03.2023.
//

import XCTest
@testable import MovieQuiz

final class MovieQuizViewControllerProtocolMock: MovieQuizViewControllerProtocol {
    func show(quiz step: MovieQuiz.QuizStepViewModel) {
    }
    
    func showImageBorder(isCorrect: Bool) {
    }
    
    func showLoadingIndicator() {
    }
    
    func hideLoadingIndicator() {
    }
    
    func showNetworkErrorAlert(message: String) {
    }
    
}
