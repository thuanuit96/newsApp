
import UIKit

class AddNewsViewController: UIViewController, AddNewsView {
    
    var presenter: AddNewsPresenter!
    var configurator: AddNewsConfigurator!
    
    lazy var cancelButton : UIBarButtonItem = {
        let bt = UIBarButtonItem(title: "Cancel", style: .plain, target:self, action: #selector( self.cancelButtonPressed(_:)))
        return bt
    }()
    lazy var saveButton : UIBarButtonItem = {
        let bt = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed(_:)))
        return bt
    }()
    
    lazy var titleTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    lazy var contentTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    lazy var wrapperStackView : UIStackView = {
        let stv = UIStackView()
        stv.axis = .vertical
        stv.distribution = .equalSpacing
        stv.spacing = 20
        return stv
    }()
    
    
    lazy var rowStackView : UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.distribution = .fill
        stv.spacing = 8
        let lb = UILabel()
        lb.text = "Title"
        lb.sizeToFit()
        lb.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        titleTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        lb.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        stv.addArrangedSubview(lb)
        stv.addArrangedSubview(titleTextField)
        return stv
    }()
    
    
    lazy var linkTextField : UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    lazy var rowStackView2 : UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.distribution = .fill
        stv.spacing = 8
        let lb = UILabel()
        lb.text = "content"
        lb.sizeToFit()
        lb.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        contentTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stv.addArrangedSubview(lb)
        stv.addArrangedSubview(contentTextField)
        
        return stv
    }()
    
    let datePicker = UIDatePicker()
    lazy var rowStackView3 : UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.distribution = .fill
        stv.spacing = 8
        let lb = UILabel()
        lb.text = "Public date"
        lb.sizeToFit()
        lb.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        datePicker.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stv.addArrangedSubview(lb)
        stv.addArrangedSubview(datePicker)
        
        return stv
    }()
    
    lazy var linkDetail : UIStackView = {
        let stv = UIStackView()
        stv.axis = .horizontal
        stv.distribution = .fill
        stv.spacing = 8
        let lb = UILabel()
        lb.text = "Link "
        lb.sizeToFit()
        linkTextField.accessibilityIdentifier = "linkDetail"
        lb.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        linkTextField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stv.addArrangedSubview(lb)
        stv.addArrangedSubview(linkTextField)
        
        lb.widthAnchor.constraint(equalToConstant: 60).isActive = true

        
        return stv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = saveButton
        configurator.configure(addNewsViewController: self)
        presenter.setUp()
        view.backgroundColor = .white
        
        wrapperStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(wrapperStackView)
        
        
        let guide = view.safeAreaLayoutGuide
        self.wrapperStackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
        self.wrapperStackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        self.wrapperStackView.topAnchor.constraint(equalTo: guide.topAnchor,constant: 10).isActive = true
        self.contentTextField.heightAnchor.constraint(equalToConstant: 100).isActive = true

        rowStackView.translatesAutoresizingMaskIntoConstraints = false
        rowStackView2.translatesAutoresizingMaskIntoConstraints = false
        rowStackView3.translatesAutoresizingMaskIntoConstraints = false
        wrapperStackView.addArrangedSubview(rowStackView)
        wrapperStackView.addArrangedSubview(rowStackView2)
        wrapperStackView.addArrangedSubview(linkDetail)

        wrapperStackView.addArrangedSubview(rowStackView3)
    }
    
    func setUp(){
        self.view.accessibilityIdentifier = "addNewsView"
        self.titleTextField.accessibilityIdentifier = "titleTextField"
        self.contentTextField.accessibilityIdentifier = "contentTextField"
        //
        
        self.datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        cancelButton.accessibilityIdentifier = "cancelButton"
        saveButton.accessibilityIdentifier = "saveButton"
    }
    
    // MARK: - IBActions
    
    @objc func saveButtonPressed(_ sender: Any) {
        let addNewsParameter = AddNewsParameter(title: self.titleTextField.text!,
                                                content: self.contentTextField.text!,
                                                publicDate: datePicker.date,
                                                link:"https://tuoitre.vn/nhung-ai-duoc-bo-sung-nhan-ho-tro-tu-goi-26-000-ti-dong-20211014153318476.htm",
                                                imgURL: "https://cdn1.tuoitre.vn/zoom/80_50/2021/10/14/logo-z28455131312259f424462cbe43d254bc0a69a606682d0-16342005536761020287824-crop-16342005656442036612573.jpg")
        presenter.addButtonPressed(parameters: addNewsParameter)
    }
    
    @objc func cancelButtonPressed(_ sender: Any) {
        presenter.cancelButtonPressed()
    }
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
    func displayAddBookError(title:String, message: String) {
        //        presentAlert(withTitle: title, message: message)
    }
    
    
   
}
