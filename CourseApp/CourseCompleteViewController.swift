//
//  CourseCompleteViewController.swift
//  CourseApp
//
//  Created by mbtec22 on 4/8/21.
//

import UIKit

class CourseCompleteViewController: UIViewController {
    
    @IBOutlet weak var lblNameCourse: UILabel!
    @IBOutlet weak var lblLabGrade: UILabel!
    @IBOutlet weak var lblTheoGrade: UILabel!
    
    var course : Course? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblNameCourse.text = "\(course!.name!)"
        lblTheoGrade.text = "\(course!.theoGrade)"
        lblLabGrade.text = "\(course!.labGrade)"
        
        let notaLab = Float(lblLabGrade.text!)!
        let notaTheo = Float(lblTheoGrade.text!)!
        
        if notaLab >= 13.0{
            lblLabGrade.textColor = UIColor.green
        }else if notaLab < 13.0 {
            lblLabGrade.textColor = UIColor.red
        }
        if notaTheo >= 13.0 {
            lblTheoGrade.textColor = UIColor.green
        }else if notaTheo < 13.0 {
            lblTheoGrade.textColor = UIColor.red
        }
        
    }
    
    @IBAction func btnOK(_ sender: UIButton) {
        navigationController!.popViewController(animated: true)

    }
    @IBAction func btnDeleteCourse(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(course!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    

}
