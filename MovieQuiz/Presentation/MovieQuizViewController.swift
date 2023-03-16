
import UIKit

final class MovieQuizViewController: UIViewController, MovieQuizViewControllerProtocol {
    private var alertPresenter: AlertPresenter?
    private var presenter: MovieQuizPresenter!
    
    //MARK: - Outlets
    
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    
    //MARK: - Actions
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        presenter.noButtonClicked()
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.yesButton.isEnabled = false
        self.noButton.isEnabled = false
        
        alertPresenter = AlertPresenter()
        presenter = MovieQuizPresenter(viewController: self)
        presenter.resetQuestionIndex()
        presenter.restartGame()
    }
    
    
    // MARK: - Alerts
    
    func showEndGameAlert() {
        let alertTitle = "Этот раунд окончен!"
        let alertButtonText = "Сыграть ещё раз"
        let alertText = presenter.getResultsMessage()
        let resultsAlertModel = AlertModel(title: alertTitle, message: alertText, buttonText: alertButtonText) { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        alertPresenter?.show(controller: self, model: resultsAlertModel)
    }
    
    func showNetworkErrorAlert(message: String) {
        hideLoadingIndicator()
        let errorAlertModel = AlertModel(title: "Ошибка",
                                         message: message,
                                         buttonText: "Попробовать еще раз") { [weak self] in
            guard let self = self else { return }
            self.presenter.restartGame()
        }
        
        alertPresenter?.show(controller: self, model: errorAlertModel)
    }
    
    // MARK: - functions
    
    private func getAppColor(_ name: String) -> CGColor {
        if let color = UIColor(named: name) {
            return color.cgColor
        } else {
            return UIColor.white.cgColor
        }
    }
    
    func showImageBorder(isCorrect: Bool) {
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? getAppColor("ypGreen") : getAppColor("ypRed")
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
        self.yesButton.isEnabled = true
        self.noButton.isEnabled = true
    }
    
    func showLoadingIndicator() {
        self.yesButton.isEnabled = false
        self.noButton.isEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderWidth = 0
    }
    
}
