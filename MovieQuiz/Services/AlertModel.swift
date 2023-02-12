//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Igor Ignatov on 05.02.2023.
//

import Foundation
import UIKit

public struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: () -> Void
}

