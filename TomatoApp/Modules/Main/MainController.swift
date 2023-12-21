import UIKit

enum MethodType {
    case fifteen
    case twentyFive
    case fourtyFive
    
    var title:String {
        switch self{
        case .fifteen: return "15 min focus, 3-min break"
        case .twentyFive: return "25 min focus, 5-min break"
        case .fourtyFive: return "45 min focus, 10-min break"
        }
    }
    var background: UIColor {
        switch self{
        case .fifteen: return .orangeColor
        case .twentyFive: return .blueColor
        case .fourtyFive: return .greenColor2
        }
    }
}

class MainController: BaseController {
    
    //MARK: - Properties
    var sections: [MethodType] = [.fifteen,
                                  .twentyFive,
                                  .fourtyFive]
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 36)
        label.textColor = .black
        label.text = "Choose Pomodoro technique"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: 165, height: 236)
        
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.register(MainCell.self, forCellWithReuseIdentifier: MainCell.cellId)
        
        return collection
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .main
        
        view.addSubviews(titleLabel,collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.left.equalToSuperview().offset(18)
            make.right.equalToSuperview().offset(-18)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout extension
extension MainController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = 12 * 3
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 236)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 16, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}



//MARK: - UICollectionViewDataSource extension
extension MainController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vc = DetailPageController(initialFocusTime: 25 * 60, initialBreakTime: 5 * 60, breakTime: 0.3333, focusTime: 0.0667)
            Router.shared.push(vc)
        }else if indexPath.row == 2 {
            let vc = DetailPageController(initialFocusTime: 45 * 60, initialBreakTime: 10 * 60, breakTime: 0.1667, focusTime: 0.0370)
            Router.shared.push(vc)
        }else {
            let vc = DetailPageController(initialFocusTime: 15 * 60, initialBreakTime: 3 * 60, breakTime: 0.5556, focusTime: 0.1111)
            Router.shared.push(vc)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = sections[indexPath.row]

        switch model{
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCell.cellId, for: indexPath) as! MainCell
            cell.configure(model: model)
            return cell
        }
        
    }
}


//func updateCellAppearance(isSelected: Bool) {
//    if isSelected {
//        mainView.backgroundColor = .orangeColor
//    } else {
//        mainView.backgroundColor = .greenColor
//    }
//}
