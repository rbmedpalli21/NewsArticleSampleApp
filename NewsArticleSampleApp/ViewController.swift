//
//  ViewController.swift
//  NewsArticleSampleApp
//
//  Created by Rakesh Medpalli on 01/07/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var newsTableView: UITableView!
    var activityView: UIActivityIndicatorView?
    let viewModel: NewsArticlesViewModel = NewsArticlesViewModel()
    static let cellID = "NewsArticlesTableViewCellID"
    
    private enum CellConstant: CGFloat {
        case cellHeight = 180.0
    }

    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async {
            if (self.activityView != nil){
                self.activityView?.stopAnimating()
            }
        }
    }
    
    private func setUPUI() {
        newsTableView.dataSource = self
        newsTableView.delegate = self
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Articles"
        setUPUI()
        showActivityIndicator()
        viewModel.getNewsArticlesList(requestModel: NewArticleReqModel())
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCellCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellID) as? NewsArticlesTableViewCell else { return UITableViewCell() }
        guard let model: Results = viewModel.responseModel?.results?[indexPath.row] else { return cell }
        cell.titleLbl.sizeToFit()
        cell.titleLbl.numberOfLines = 0
        cell.titleLbl.text = model.title
        cell.abstractLbl.sizeToFit()
        cell.abstractLbl.numberOfLines = 0
        cell.abstractLbl.text = model.abstract
        cell.autherLbl.text = model.byline
        cell.dateLbl.text = model.published_date
        cell.newsImageView.imageFromServerURL(urlString: model.media?.first?.mediaMetadata?.first?.url ?? "", PlaceHolderImage: UIImage(systemName: "multiply.circle.fill")!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellConstant.cellHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return CellConstant.cellHeight.rawValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let model = viewModel.responseModel?.results?[indexPath.row] else { return }
        navigateToDetailsView(model: model)
    }
    
    private func navigateToDetailsView(model: Results) {
        let storyBoard : UIStoryboard = UIStoryboard(name: StoryboardConstant.main, bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: StoryboardConstant.webviewVCIdentifier) as! NewsArticleWebViewVC
        nextViewController.urlStr = model.url ?? ""
        self.navigationController?.pushViewController(nextViewController, animated: false)
    }
    
}

extension ViewController: ResponseHandler {
    @objc func updateUI() {
        hideActivityIndicator()
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }

    @objc func onError() {
        hideActivityIndicator()
    }
}
