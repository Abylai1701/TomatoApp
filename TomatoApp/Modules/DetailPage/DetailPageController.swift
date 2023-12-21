import UIKit
import SnapKit

enum DetailMenuType {
    case times
    case start
}

enum CycleType {
    case one
    case two
    case three
    case four
    case five
    
    var cycleStep:String {
        switch self{
        case .one: return "1/5 cycle"
        case .two: return "2/5 cycle"
        case .three: return "3/5 cycle"
        case .four: return "4/5 cycle"
        case .five: return "5/5 cycle"
        }
    }
    var timeType:String {
        switch self{
        case .one: return "Focus time"
        case .two: return "Break time"
        case .three: return "Focus time"
        case .four: return "Break time"
        case .five: return "Focus time"
        }
    }
}

class DetailPageController: BaseController {
    
    private var selectedIndexPath: IndexPath?
    var initialFocusTime: Double
    var initialBreakTime: Double
    var focusTime: Double
    var breakTime: Double

    var sections: [DetailMenuType] = [.times,
                                      .start]
    var types: [CycleType] = [.one,
                              .two,
                              .three,
                              .four,
                              .five]
    var initialTimes: [Double] = []
    var whiteTimes: [Double] = []
    var nextTimer: (() -> Void)?
    private var currentIndex: Int = 0

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.layer.masksToBounds = false
        button.addTarget(self,
                         action: #selector(tapBack),
                         for: .touchUpInside)
        button.isUserInteractionEnabled = true
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
    //MARK: - Init
    init(initialFocusTime: Double ,initialBreakTime: Double , breakTime: Double, focusTime: Double ) {
        self.initialFocusTime = initialFocusTime
        self.initialBreakTime = initialBreakTime
        self.breakTime = breakTime
        self.focusTime = focusTime

        self.initialTimes = [initialFocusTime, initialBreakTime, initialFocusTime, initialBreakTime, initialFocusTime]
        self.whiteTimes = [focusTime, breakTime, focusTime, breakTime, focusTime]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        print(initialTimes)
        print(whiteTimes)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    //MARK: - SetupViews

    private func setupViews() {
        navigationItem.hidesBackButton = false

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
    private func start() {
        guard currentIndex < 5 else {
            currentIndex = 0
            return
        }
        if let cell = tableView.cellForRow(at: IndexPath(row: currentIndex, section: 0)) as? DetailPageCell {
            cell.updateCellAppearance(isSelected: true)
            tableView.beginUpdates()
            tableView.endUpdates()
            cell.pauseViewTapped()
        }
    }
    private func getNextIndexPath() -> IndexPath? {
        guard currentIndex + 1 < initialTimes.count else {
            return nil
        }
        return IndexPath(row: currentIndex + 1, section: 0)
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
        let types = types[indexPath.row]
        let timerTimes = self.initialTimes[indexPath.row]
        let whiteTimes = self.whiteTimes[indexPath.row]

        switch model{
        case .times:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailPageCell.cellId, for: indexPath) as! DetailPageCell
            cell.configure(model: types, initialTime: timerTimes, time: whiteTimes)
            cell.timerCompletionHandler = { [weak self] in
                self?.currentIndex += 1
                self?.tableView.beginUpdates()
                self?.tableView.endUpdates()
                self?.start()
            }
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
        
        if indexPath.section == 1 {
            start()
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}
