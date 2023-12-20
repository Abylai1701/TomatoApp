import UIKit

class CheckBox: UIButton {
    // Images
    var checkedImage: UIImage = UIImage(named:"Group 10508") ?? UIImage()
    var uncheckedImage: UIImage = UIImage(named:"Group 10508") ?? UIImage()
    
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setBackgroundImage(checkedImage, for: .normal)
            } else {
                self.setBackgroundImage(uncheckedImage, for: .normal)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: .zero)
        imageView?.contentMode = .scaleAspectFill
        addTarget(self, action: #selector(buttonClicked(sender:)),
                        for: .touchUpInside)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
