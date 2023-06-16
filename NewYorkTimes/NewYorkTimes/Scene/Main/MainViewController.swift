//
//  MainViewController.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 13.06.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// Main screen controller
final class MainViewController: ViewController<MainViewModel> {
    
    // MARK: - UI elements
    
    private let containerView = UIView()
    private let activityIndicatorView = UIActivityIndicatorView()
    private let tableView = UITableView()
    
    private lazy var viewSpinner: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
    
        view.addSubview(spinner)
        
        spinner.center = view.center
        spinner.startAnimating()
        
        return view
    }()
    
    private lazy var categoryMenu: UIMenu = {
        func select(_ name: String) {
            navigationItem.title = name.capitalized
            categorySelected.accept(name)
        }
        
        let menuActions = NewsCategory.allCases.map({ (item) -> UIAction in
            UIAction(title: item.rawValue.capitalized,
                     image: item.image?.image) { _ in
                select(item.rawValue)
            }
        })
        return UIMenu(title: Localizationable.Global.menuTitle.localized, children: menuActions)
    }()
    
    private let categorySelected: PublishRelay<String> = .init()
    
    // MARK: - Set Up VC
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(containerView)
        
        containerView.addSubview(activityIndicatorView)
        containerView.addSubview(tableView)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func setupView() {
        super.setupView()
        
        containerView.backgroundColor = .white
    }
    
    override func setupScrollCollection() {
        super.setupScrollCollection()
        
        tableView.registerCellClass(MainTableViewCell.self)
        tableView.rowHeight = 120
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        
        navigationItem.title = "General"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.setHidesBackButton(true, animated: false)
        
        let categoryMenuButton = UIBarButtonItem(title: nil,
                                                 image: Style.Images.menu.image,
                                                 primaryAction: nil,
                                                 menu: categoryMenu)
        categoryMenuButton.tintColor = .black
        navigationItem.rightBarButtonItem = categoryMenuButton
    }
    
    override func setupOutput() {
        super.setupOutput()
        
        let input = MainViewModel.Input(
            categorySelected: categorySelected.asObservable(),
            itemsSelected: tableView.rx.itemSelected.map({ $0.row }),
            loadMore: tableView.getScrollToBottomObserver(),
            disposeBag: disposeBag)
        
        viewModel.transform(input, outputHandler: setupInput(input:))
    }
    
    override func setupInput(input: MainViewModel.Output) {
        super.setupInput(input: input)
        
        disposeBag.insert(
            setUpItemsObserving(with: input.tableItems, tableView: tableView),
            setUpFooterStateObserving(with: input.hasMoreInfo, tableView: tableView, viewSpinner: viewSpinner),
            setUpLoadingObserving(with: input.isLoading, activityIndicatorView: activityIndicatorView)
        )
    }
    
    private func setUpItemsObserving(with signal: Driver<[MainCellModel]>, tableView: UITableView) -> Disposable {
        signal
            .drive(tableView.rx.items) { tableView, row, viewModel in
                let cell = tableView.dequeueReusableCell(
                    ofType: MainTableViewCell.self,
                    at: IndexPath(row: row, section: .zero)
                )
                cell.render(viewModel)
                return cell
            }
    }
    
    private func setUpFooterStateObserving(with signal: Observable<Bool>, tableView: UITableView, viewSpinner: UIView) -> Disposable {
        signal
            .subscribe { isAvaliable in
                guard let isAvaliable = isAvaliable.element else { return }
                tableView.tableFooterView = isAvaliable ? viewSpinner : UIView(frame: .zero)
            }
    }
    
    private func setUpLoadingObserving(with signal: Observable<Bool>, activityIndicatorView: UIActivityIndicatorView) -> Disposable {
        signal
            .subscribe { isLoading in
                guard let isLoading = isLoading.element else { return }
                if isLoading {
                    activityIndicatorView.startAnimating()
                } else {
                    activityIndicatorView.stopAnimating()
                }
            }
    }
}
