import UIKit

protocol GifSearchResultsViewOutput {
    var cellModels: [GifCell.Model] { get }
    func didSelectItem(at indexPath: IndexPath)
}

public final class GifSearchResultsViewController: UIViewController, StoryboardInstantiable {
    static let identifier = "GifSearchResultsViewController"
    static let storyboardName = "GifSearchResultsViewController"

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!

    var presenter: GifSearchResultsViewOutput!

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GifCell.self)
    }
}

extension GifSearchResultsViewController: GifSearchResultsViewInput {
    func configure(for state: GifSearchResultsState) {
        onMain { [weak self] in
            switch state {
            case .loading(let stage): self?.configureLoadingState(for: stage)
            case .loaded(let stage): self?.configureLoadedState(for: stage)
            }
        }
    }

    private func configureLoadingState(for stage: GifSearchResultsState.Stage) {
        switch stage {
        case .initial:
            collectionView.isHidden = true
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
        }
    }

    private func configureLoadedState(for stage: GifSearchResultsState.Stage) {
        switch stage {
        case .initial:
            loadingIndicator.isHidden = true
            loadingIndicator.stopAnimating()
            collectionView.isHidden = false
            collectionView.reloadData()
            collectionView.scrollToItem(at: .init(row: 0, section: 0),
                                        at: .top, animated: false)
        }
    }
}

extension GifSearchResultsViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cellModels.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(GifCell.self, for: indexPath)
        cell.configure(with: presenter.cellModels[indexPath.row])

        return cell
    }
}

extension GifSearchResultsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
}

extension GifSearchResultsViewController: UICollectionViewDelegateFlowLayout {
    private var itemsPerRow: Int { 3 }
    private var interitemSpacing: CGFloat { 10 }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = interitemSpacing * CGFloat(itemsPerRow - 1)
        let cellWidth = Int((collectionView.bounds.width - spacing) / CGFloat(itemsPerRow))
        return .init(width: cellWidth, height: cellWidth)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpacing
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return interitemSpacing
    }
}
