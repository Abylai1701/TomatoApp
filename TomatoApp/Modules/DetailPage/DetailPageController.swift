import UIKit
import SnapKit

enum DetailMenuType {
    case times
    case start
}

class DetailPageController: UIViewController {
    
    private var selectedIndexPath: IndexPath?

    var sections: [DetailMenuType] = [.times,
                                      .start]
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.layer.masksToBounds = false
        button.addTarget(self,
                         action: #selector(tapBack),
                         for: .touchUpInside)
        
        return button
    }()
    lazy var backTitle: UILabel = {
        let label = UILabel()
        label.font = .montserratSemiBold(ofSize: 14)
        label.text = "Back"
        label.textColor = .black
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBack))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(DetailPageCell.self, forCellReuseIdentifier: DetailPageCell.cellId)
        tableView.register(StartCell.self, forCellReuseIdentifier: StartCell.cellId)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .main
        view.addSubviews(backButton,backTitle,tableView)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(65)
        }
        backTitle.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right)
            make.top.equalToSuperview().offset(68)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(8)
            make.right.left.bottom.equalToSuperview()
        }
    }
    @objc func tapBack() {
        Router.shared.pop()
    }
}
// MARK: - UITableViewDelegate and UITableViewDataSource methods
extension DetailPageController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = sections[section]
        
        switch model {
        case .times: return 5
        default:
            return 1
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section]
        switch model{
        case .times:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPageCell.cellId, for: indexPath) as! DetailPageCell
            return cell
        case .start:
            let cell = tableView.dequeueReusableCell(withIdentifier: StartCell.cellId, for: indexPath) as! StartCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailPageCell else {
            return
        }

        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
            cell.updateCellAppearance(isSelected: false)

        } else {
            selectedIndexPath = indexPath
            cell.updateCellAppearance(isSelected: true)

        }
        tableView.beginUpdates()
        tableView.endUpdates()
        
    }
}
