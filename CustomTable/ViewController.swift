//
//  ViewController.swift
//  CustomTable
//
//  Created by TA Trung Thanh on 08/12/2018.
//  Copyright © 2018 TA Trung Thanh. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    private var count = 1
    private var content = [[OneCell]]()
    
    override init(style: UITableView.Style) {
        super.init(style: style)
        self.tableView.separatorColor = .clear
        for _ in 1...3 { //because we don't use index
            var inSection = [OneCell]()
            for _ in 1...10 { //because index unused
                inSection += [OneCell(l: "Cell #\(count)", d: "Detail #\(count)")]
                count += 1
            }
            content += [inSection]
        }
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.title = "MyElements"
        // Buttons for update... could be done in viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCell))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func addCell() {
        self.content[0].insert(OneCell(l: "New cell #\(count)", d: "New detail #\(count)"), at: 0)
        count += 1
        self.tableView.reloadData()
    }
    
    // TableViewDataSource protocol
    override func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId = ""
        if (indexPath as NSIndexPath).row % 3 == 1 {
            cellId = "one"
        } else if (indexPath as NSIndexPath).row % 3 == 2{
            cellId = "two"
        } else {
            cellId = "three"
        }
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell === nil {
            var img : UIImage?
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
            if (indexPath as NSIndexPath).row % 3 == 1 {
                cell!.textLabel?.textColor = UIColor.red
                img = UIImage(named: "imgA")
            } else if (indexPath as NSIndexPath).row % 3 == 2 {
                cell!.textLabel?.textColor = UIColor.green
                img = UIImage(named: "imgB")
            } else {
                cell!.textLabel?.textColor = UIColor.blue
                img = UIImage(named: "imgC")
            }
            cell!.imageView?.image = img!
        }
        let cont = content[indexPath.section][indexPath.row]
        cell!.textLabel?.text = cont.label
        cell!.detailTextLabel?.text = cont.detail
        cell!.backgroundColor = UIColor.gray
        return cell!
    }
    
    
    //override to support editing the table view
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.content[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //can do it here, but we will do it in another place
        }
        self.tableView.reloadData() //because several types of cells
    }
    //override to support conditional rearranging of the table view
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row % 3 > 0  //some cell might be unmovable
    }
    
    //override to support rearranging of the table view
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let val = content[sourceIndexPath.section][sourceIndexPath.row]
        self.content[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        self.content[destinationIndexPath.section].insert(val, at: destinationIndexPath.row)
        self.tableView.reloadData() //because several types of cells
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //create the view controller to insert
        let s = self.content[indexPath.section][indexPath.row].label
        var img : UIImage?
        if (indexPath as NSIndexPath).row % 3 == 1 {
            img = UIImage(named: "imgA")
        } else if (indexPath as NSIndexPath).row % 3 == 2 {
            img = UIImage(named: "imgB")
        } else {
            img = UIImage(named: "imgC")
        }
        let detailVC = DetailViewController(str: s, img: img!)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    //UITableViewDelegate protocol
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width, height: 80.0))
        //hv.addSubview(UIImageView(image: )) //for background
        let l = UILabel(frame: CGRect(x: 20.0, y: 30.0, width: UIScreen.main.bounds.size.width - 30, height: 25.0))
        l.textColor = .yellow
        l.font = UIFont.boldSystemFont(ofSize: 20.0)
        l.text = "Section \(section + 1)"
        hv.addSubview(l)
        return hv
    }
}

