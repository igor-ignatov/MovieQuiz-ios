//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Igor Ignatov on 05.02.2023.
//

import Foundation

protocol QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?)
    func didLoadDataFromServer()
    func didFailToLoadData(with error: Error)
}
