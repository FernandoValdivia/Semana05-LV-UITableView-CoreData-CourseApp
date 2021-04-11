import UIKit

class AddCourseViewController: UIViewController {

    @IBOutlet weak var iptName: UITextField!
    @IBOutlet weak var iptLabGrade: UITextField!
    @IBOutlet weak var iptTheoGrade: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func btnAddCourse(_ sender: UIButton) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let course = Course(context: context)
        course.name = iptName.text!
        course.theoGrade = Float(iptTheoGrade.text!) ?? 0.0
        course.labGrade = Float(iptLabGrade.text!) ?? 0.0
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
    

}
