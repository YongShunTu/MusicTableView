//
//  MusicTableViewController.swift
//  MusicTableView
//
//  Created by 塗詠順 on 2021/12/24.
//

import UIKit

class MusicTableViewController: UITableViewController {
    
    var items = [StoreItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        fetchItem()
    }
    
    // MARK: - Table view data source
    
        func fetchItem() {
            if let url = URL(string: "https://itunes.apple.com/search?term=blackpink&media=music&country=tw") {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    let decoder = JSONDecoder()
                    if let data = data, let content = String(data: data, encoding: .utf8) {
                        do{
                            let musicResponse = try decoder.decode(MusicResponse.self, from: data)
                            print(content)
                            DispatchQueue.main.async {
                                self.navigationItem.title = musicResponse.results[0].collectionArtistName
                                self.items = musicResponse.results
                                self.tableView.reloadData()
                            }
                        }catch{
                            print("Error")
                        }
                    }else{
                        print("Error")
                    }
                }.resume()
            }
        }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MusicTableViewCell.self)", for: indexPath) as! MusicTableViewCell
        
        let item = items[indexPath.row]
        cell.musicNameLabel.text = item.trackName
        cell.singerLabel.text = item.artistName
        cell.musicPhotoImage.image = UIImage(systemName: "music.note.list")
        
        URLSession.shared.dataTask(with: item.artworkUrl100) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    cell.musicPhotoImage.image = UIImage(data: data)
                }
            }
        }.resume()
        
        return cell
    }
    
    @IBSegueAction func shoeDetail(_ coder: NSCoder) -> DetailViewController? {
        if let row = tableView.indexPathForSelectedRow?.row{
            return DetailViewController(coder: coder, item: items, row: row)
        }else{
            return nil
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
         
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
