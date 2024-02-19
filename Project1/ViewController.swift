//
//  ViewController.swift
//  Project1
//
//  Created by Aharon Seidman on 1/5/24.
//

import UIKit

class ViewController: UITableViewController {

    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        let images = try! fm.contentsOfDirectory(atPath: path)
        
        for path in images {
            if path.hasPrefix("picture"){
                pictures.append(path)
                
            }
            pictures.sort { a, b in
                a < b
            }
        }
        
        ////        tableView.dataSource = self
        ////        tableView.delegate = self
        //        navigationItem.title = "Images"
        //        navigationController?.navigationBar.prefersLargeTitles = true
        
        print(pictures)
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(reccommendApp))
    }
    
    @objc func reccommendApp(){
        let vc = UIActivityViewController(activityItems: ["I LOOVE this app!!"], applicationActivities: [])
        present(vc, animated: true)
    }

}

extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
//        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let imageViewController = ImageViewController()
//        let image = UIImage(named: pictures[indexPath.row])!
        
        if let vc = storyboard?.instantiateViewController(identifier: "ImageViewController") as? ImageViewController  {
            vc.selectedImage = pictures[indexPath.row ]
            vc.xOfY = (indexPath.row + 1, pictures.count)
            navigationController?.pushViewController(vc, animated: true)
        }
        
//        imageViewController.setImage(image: image)
//        navigationController?.pushViewController(imageViewController, animated: true)
    }
}

