//
//  SingleImageViewController.swift
//  PixelStream
//
//  Created by Liz-Mary on 25.11.2024.
//

import UIKit

final class SingleImageViewController: UIViewController {
    
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image else { return }
            imageView.image = image
            rescaleAndCenterImageInScrollView(image: image)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = 0.1
        scrollView.maximumZoomScale = 1.25
        
        guard let image else { return }
        imageView.image = image
        rescaleAndCenterImageInScrollView(image: image)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard let image = image else { return }
        rescaleAndCenterImageInScrollView(image: image)
    }
    
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapShareButton() {
        guard let image else { return }
        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
    private func rescaleAndCenterImageInScrollView(image: UIImage) {
        // Обновляем интерфейс для применения новых размеров
        view.layoutIfNeeded()
        
        // Получаем размеры области прокрутки и изображения
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        
        //Проверяем размеры
        guard imageSize.width > 0 && imageSize.height > 0 else {
            print("Ошибка размеров изображения")
            return
        }
        
        // Рассчитываем масштаб, чтобы изображение пропорционально заполнило экран
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = max(hScale, vScale) // Используем максимальный масштаб, чтобы изображение заполнило экран
        
        // Устанавливаем минимальный и максимальный масштаб
        scrollView.minimumZoomScale = scale
        scrollView.zoomScale = scale
        
        // Масштабируем изображение
        imageView.frame.size = CGSize(width: imageSize.width * scale, height: imageSize.height * scale)
        
        // Вычисляем отступы для центрирования изображения в области прокрутки
        let horizontalInset = max((visibleRectSize.width - imageView.frame.width) / 2, 0)
        let verticalInset = max((visibleRectSize.height - imageView.frame.height) / 2, 0)
        
        // Центрируем изображение с учетом отступов
        scrollView.contentInset = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        
        // Центрируем содержимое прокрутки, чтобы показать центр изображения
        scrollView.setContentOffset(CGPoint(
            x: max((imageView.frame.width - visibleRectSize.width) / 2, 0),
            y: max((imageView.frame.height - visibleRectSize.height) / 2, 0)),
                                    animated: false)
    }
}

extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
