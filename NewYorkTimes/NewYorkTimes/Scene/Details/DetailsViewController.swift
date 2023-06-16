//
//  DetailsViewController.swift
//  NewYorkTimes
//
//  Created by Alena Drobko on 15.06.23.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

/// Details screen controller
final class DetailsViewController: ViewController<BaseDetailsViewModel> {
    
    // MARK: - UI elements
    
    private let containerView = UIView()
    private let tableView = UITableView()
    
    // MARK: - Set Up VC
    
    override func setupConstraints() {
        super.setupConstraints()
        
        view.addSubview(containerView)
        
        containerView.addSubview(tableView)
        
        containerView.snp.makeConstraints { make in
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
        
        tableView.registerCellClass(ImageTableViewCell.self)
        tableView.registerCellClass(TextTableCell.self)
        tableView.registerCellClass(ButtonTableViewCell.self)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationController?.navigationBar.tintColor = .black
        navigationItem.setHidesBackButton(false, animated: false)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func setupOutput() {
        super.setupOutput()
        
        let input = BaseDetailsViewModel.Input(
            backTapped: navigationItem.backBarButtonItem?.rx.tap.asObservable() ?? .never(),
            disposeBag: disposeBag
        )
        
        viewModel.transform(input, outputHandler: setupInput(input:))
    }
    
    override func setupInput(input: BaseDetailsViewModel.Output) {
        super.setupInput(input: input)
        
        disposeBag.insert(
            setUpItemsObserving(with: input.tableItems, tableView: tableView)
        )
    }
    
    private func setUpItemsObserving(with signal: Driver<[DetailsCellModel]>, tableView: UITableView) -> Disposable {
        signal
            .drive(tableView.rx.items) { tableView, row, viewModel in
                switch viewModel {
                case .image(let model):
                    let cell = tableView.dequeueReusableCell(ofType: ImageTableViewCell.self,
                                                             at: IndexPath(row: row, section: .zero))
                    cell.render(model)
                    return cell
                case .text(let model):
                    let cell = tableView.dequeueReusableCell(ofType: TextTableCell.self,
                                                             at: IndexPath(row: row, section: .zero))
                    cell.render(model)
                    return cell
                case .button(let model):
                    let cell = tableView.dequeueReusableCell(ofType: ButtonTableViewCell.self,
                                                             at: IndexPath(row: row, section: .zero))
                    cell.render(model)
                    return cell
                }
            }
    }
}
