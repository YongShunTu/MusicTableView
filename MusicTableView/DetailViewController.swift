//
//  DetailViewController.swift
//  MusicTableView
//
//  Created by 塗詠順 on 2021/12/24.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var musicPhotoDetailImage: UIImageView!
    @IBOutlet weak var musicNameDetailLabel: UILabel!
    @IBOutlet weak var singerDetailLabel: UILabel!
    @IBOutlet weak var playerButton: UIButton!
    
    var item: [StoreItem]
    
    var row: Int {
        didSet{
            music = AVPlayer(url: item[row].previewUrl)
            fetchImage()
        }
    }
    
    var music: AVPlayer?
    
    var _player: Bool = false
    var player: Bool {
        _player = !_player
        return _player
    }
    
    

    init?(coder: NSCoder, item: [StoreItem], row: Int){
        self.item = item
        self.row = row
        self.music = AVPlayer(url: item[row].previewUrl)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchImage()
        

    }
    func fetchImage() {
        URLSession.shared.dataTask(with: item[row].artworkUrl100) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.musicPhotoDetailImage.image = image
                }
            }
        }.resume()
        musicNameDetailLabel.text = item[row].trackName
        singerDetailLabel.text = item[row].artistName
    }
    
    @IBAction func playMusicButtonClicked(_ sender: UIButton) {
        if player{
            music?.play()
        }else{
            music?.pause()
        }
        changePlayerButtonImage(_player)
    }
    
    func changePlayerButtonImage(_ player: Bool) {
        if player{
            playerButton.setBackgroundImage(UIImage(named: "pause"), for: .normal)
        }else{
            playerButton.setBackgroundImage(UIImage(named: "play"), for: .normal)
        }

    }
    
    @IBAction func nextMusicButtonClicked(_ sender: UIButton) {
        row += 1
        _player = true
        music?.play()
        changePlayerButtonImage(_player)
    }
    
    @IBAction func previousMusicButtonClicked(_ sender: UIButton) {
        row -= 1
        _player = true
        music?.play()
        changePlayerButtonImage(_player)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
