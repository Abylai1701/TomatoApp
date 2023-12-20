import UIKit

class StartCell: UITableViewCell {
    
    //MARK: - Properties
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "start")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    //MARK: - Setup Views
    private func setupViews() {
        contentView.isUserInteractionEnabled = true
        layer.masksToBounds = true
        backgroundColor = .clear
        addSubviews(mainImage)
        
        mainImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-42)
        }
    }
}
