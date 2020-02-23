import UIKit

protocol GifSearchViewOutput {
    var randomGifDataProvider: GifDataProvider { get }
    var searchQueryProvider: GifSearchQueryProvider { get }
    var searchResultsFetcher: GifSearchResultsFetcher { get }
    var onGifSelected: (String) -> Void { get }
    func searchTextDidChange(text: String)
    func cancelSearch()
}

public final class GifSearchViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "GifSearchViewController"
    static let storyboardName = "GifSearchViewController"

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var searchBar: UISearchBar!

    private weak var randomGifViewController: RandomGifViewController?
    private weak var searchResultsViewController: GifSearchResultsViewController?

    var presenter: GifSearchViewOutput!

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupKeyboardDismissal()
        setupRandomGifViewController()
        setupSearchResultsViewController()
        configure(for: .empty)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        hideNavigationBar()
    }

    private func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupSearchBar() {
        searchBar.delegate = self
    }

    private func setupRandomGifViewController() {
        let randomGifViewController = RandomGifBuilder.build(gifDataProvider: presenter.randomGifDataProvider)
        addChildViewController(randomGifViewController, into: containerView)
        self.randomGifViewController = randomGifViewController
    }

    private func setupSearchResultsViewController() {
        let searchResultsViewController = GifSearchResultsBuilder.build(queryProvider: presenter.searchQueryProvider,
                                                                        fetcher: presenter.searchResultsFetcher,
                                                                        onGifSelected: presenter.onGifSelected)
        addChildViewController(searchResultsViewController, into: containerView)
        self.searchResultsViewController = searchResultsViewController
    }

    private func setupKeyboardDismissal() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        panGesture.cancelsTouchesInView = false
        panGesture.delegate = self
        [tapGesture, panGesture].forEach(containerView.addGestureRecognizer)
    }

    @objc private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}

extension GifSearchViewController: GifSearchViewInput {
    func configure(for state: GitSearchViewState) {
        switch state {
        case .empty:
            randomGifViewController?.view.isHidden = false
            searchResultsViewController?.view.isHidden = true
        case .searchResults:
            randomGifViewController?.view.isHidden = true
            searchResultsViewController?.view.isHidden = false
        }
    }
}

extension GifSearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchTextDidChange(text: searchText)
    }

    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }

    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? true {
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.cancelSearch()
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

extension GifSearchViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        guard gestureRecognizer is UIPanGestureRecognizer,
            otherGestureRecognizer is UIPanGestureRecognizer else {
                return false
        }
        return true
    }
}
