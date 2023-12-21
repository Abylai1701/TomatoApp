import UIKit

class MainCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var coverImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "main")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 16)
        label.textColor = .black
        label.text = "10-15 min focus, 3-min break"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var reminderLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratRegular(ofSize: 12)
        label.textColor = .black
        label.text = "Recommended Pomodoro intervals for emails, calls, communication"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //MARK: - Setup Views
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        layer.cornerRadius = 16
        backgroundColor = .orangeColor
        addSubviews(coverImageView,
                    titleLabel,
                    reminderLabel)
        
        coverImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(90)
            make.width.equalTo(81)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(coverImageView.snp.bottom).offset(2)
        }
        reminderLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
    }
    func configure(model: MethodType) {
        titleLabel.text = model.title
        backgroundColor =  model.background
    }
}
