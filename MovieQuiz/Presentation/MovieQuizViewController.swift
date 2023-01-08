import UIKit

// для состояния "Вопрос задан"
struct QuizStepViewModel {
    let image: UIImage
    let question: String
    let questionNumber: String
}

struct QuizQuestion {
    let image: String
    let text: String
    let correctAnswer: Bool
}

struct Statistic {
    let result: Int
    let date: Date
}

final class MovieQuizViewController: UIViewController {
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        let currentQuestion = questions[currentQuestionIndex]
        let givenAnswer = false
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше чем 3?",
            correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше чем 7?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше чем 5?",
            correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше чем 3?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше чем 9?",
            correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше чем 7?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше чем 8?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма больше чем 4?",
            correctAnswer: false)
    ]
    private var currentQuestionIndex: Int = 0
    private var correctAnswers: Int = 0
    private var quizCount: Int = 0
    private var stats: [Statistic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        show(quiz: questions[currentQuestionIndex])
    }
    
    private func show(quiz step: QuizQuestion) {
        let question = convert(model: step)
        
        imageView.layer.borderWidth = 0
        
        textLabel.text = question.question
        counterLabel.text = question.questionNumber
        imageView.image = question.image
    }
    
    private func showResult() {
        quizCount += 1
        stats.append(Statistic(result: correctAnswers, date: Date()))
        
        let record: Statistic? = stats.max { a, b in a.result < b.result }
        let sumResults: Int = stats.reduce(0) { $0 + $1.result }
        let totalQuestionsCount: Int = quizCount * questions.count
        let averagePercentage: Float = Float(sumResults) / Float(totalQuestionsCount) * 100
        var message = ""

        if (record != nil) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy HH:mm"
            let date = formatter.string(from: record!.date)
            
            let resultText = "Ваш результат: \(self.correctAnswers)/\(self.questions.count)"
            let quizCountText = "Количество сыгранных квизов: \(self.quizCount)"
            let recordText = "Рекорд: \(record!.result)/\(self.questions.count) (\(date))"
            let averageText = "Средняя точность: \(String(format: "%.2f", averagePercentage))%"
            
            message = "\(resultText)\n\(quizCountText)\n\(recordText)\n\(averageText)"
        }
        
        let alert = UIAlertController(title: "Этот раунд окончен! ", message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Сыграть ещё раз", style: .default, handler: { _ in
            self.correctAnswers = 0
            self.currentQuestionIndex = 0
            self.show(quiz: self.questions[self.currentQuestionIndex])
        })
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)"
        )
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if (isCorrect) {
            correctAnswers += 1
        }
        
        noButton.isEnabled = false
        yesButton.isEnabled = false

        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        imageView.layer.cornerRadius = 20
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
            
            self.noButton.isEnabled = true
            self.yesButton.isEnabled = true
        }
    }
    
    private func showNextQuestionOrResults() {
        if (currentQuestionIndex == questions.count - 1) {
            showResult()
        } else {
            currentQuestionIndex += 1
            show(quiz: questions[currentQuestionIndex])
        }
    }
}
