//
//  Question.swift
//  quiz
//
//  Created by Ng Qi An on 27/5/23.
//

import Foundation

struct Question {
    var text: String
    var options: Array<Option>
}

struct Option {
    var text: String
    var correct: Bool
}
