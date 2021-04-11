
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var courses:[Course] = []
    let course : Course? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //Cambiar color de barra de estado
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .default
    }
    
    @IBAction func addCourse(_ sender: Any) {
        performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCourses()
        tableView.reloadData()
        
    }
    
    //Cambiar color de celda
    var colorCellSelected = UIColor.darkGray
    
    func getCourses(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            courses = try context.fetch(Course.fetchRequest()) as! [Course]
        } catch {
            print("SOMETHING WENT WRONG")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "courseSelectedSegue" {
            let nextVC = segue.destination as! CourseCompleteViewController
            nextVC.course = sender as? Course
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = courses[indexPath.row]
        performSegue(withIdentifier: "courseSelectedSegue", sender: course)
        
    }
    
    //Eliminar deslizando
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(courses[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        //print(course)
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let course = courses[indexPath.row]
        
        if course.name != nil {
            cell.textLabel?.text = "✅ \(course.name!)"
            cell.textLabel?.textColor = UIColor.white
                    
            let promfinal = course.labGrade * 0.6 + course.theoGrade * 0.4
                    
            if promfinal < 13.0 {
                cell.backgroundColor = #colorLiteral(red: 1, green: 0.8398956841, blue: 0.3066194231, alpha: 1)
            }else if promfinal >= 13.0 {
                cell.backgroundColor = UIColor.systemGreen
            }else{
                cell.backgroundColor = UIColor.black
            }
            
            return cell
        }
        
        return cell
        
    }
    
}
