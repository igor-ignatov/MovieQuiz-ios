//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Igor Ignatov on 05.02.2023.
//

import Foundation

protocol QuestionFactoryDelegate : AnyObject {
    func didRecieveNextQuestion(question: QuizQuestion?)
}
