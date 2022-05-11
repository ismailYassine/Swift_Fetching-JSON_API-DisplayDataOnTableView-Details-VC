//
//  ViewController.swift
//  Parse JSON API
//
//  Created by Ismail on 2022-04-27.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data1 = [AcategoryData]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        JSONLoader().jsonPasing { (data) in
//            print(data)
                        
            for item in data.categories{
                self.data1.append(item)
            }
            
            print("Data: \(self.data1[1])")
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        
        cell.titleCellLabel.text = data1[indexPath.row].strCategory
        let strCategory = data1[indexPath.row].strCategory
        
        let urlString = "https://www.themealdb.com/images/category/" + strCategory + ".png"
        let url = URL(string: urlString)
        
        cell.imgTableViewCell.downloaded(from: url!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsView", sender: self)    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController {
            destination.categories = data1[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    
}

