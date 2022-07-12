
import UIKit

class EmployeeDetailTableViewController: UITableViewController, UITextFieldDelegate, EmployeeTypeDelegate {

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue"
    }
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var employeeTypeLabel: UILabel!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    @IBAction func dobDatePickerAction(_ sender: UIDatePicker) {
        if #available(iOS 15.0, *) {
            dobLabel.text = dobDatePicker.date.formatted(date: .numeric, time: .omitted)
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    var employee: Employee?
    var employeeType: EmployeeType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    
    func updateView() {
        if let employee = employee {
            navigationItem.title = employee.name
            nameTextField.text = employee.name
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth)
            dobLabel.textColor = .black
            employeeTypeLabel.text = employee.employeeType.description()
            employeeTypeLabel.textColor = .black
        } else {
            navigationItem.title = "New Employee"
        }
    }
    
    var isEditingBirthday: Bool = false {
        didSet {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text {
            guard let employeeType = employeeType else { return }

            employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType)
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self)
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }

    
    let birthDayDatePickerIndexPath = IndexPath(row: 2, section: 0)
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath {
        case birthDayDatePickerIndexPath:
            if isEditingBirthday {
                return dobDatePicker.frame.height
            } else {
                return 0
            }
        default:
            return 44 // UITableView.automaticDimension
        }
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath == IndexPath(row: 1, section: 0) {
//            isEditingBirthday = true
//        } else if isEditingBirthday == true {
//            isEditingBirthday = false
//        } else {
//            isEditingBirthday = false
//        }
        // 위의 식으로는 토글처럼 작동 안함.
        // 잘 생각해보자...
// 와 대박!! 아래처럼 하면 된다...
        // if가 "indexPath가 ~라면 ~해" 라면,
        // switch/case는 "indexPath가 ~일 경우 ~라면 ~해",
        // 즉 조건이 두 번 들어갈 수 있군!
        // switch 를 return 없이 태우는 것도 배웠음.
        // 근데... if를 중첩해도 똑같은거 아닌가?
        
        switch indexPath {
        case IndexPath(row: 1, section: 0):
            if isEditingBirthday {
                isEditingBirthday = false
            } else {
                isEditingBirthday = true
            }
        default:
            break
        }
        
        if #available(iOS 15.0, *) {
            dobLabel.text = dobDatePicker.date.formatted(date: .numeric, time: .omitted)
        } else {
            // Fallback on earlier versions
        }
        dobLabel.textColor = .black
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let employeeTypeTableViewController = segue.destination as? EmployeeTypeTableViewController
        employeeTypeTableViewController?.delegate = self
        employeeTypeTableViewController?.employeeType = employeeType
        
        
    }
    
    func didSelect(employeeType: EmployeeType) {
        let employeeType = self.employeeType
        print(employeeType!)
        employeeTypeLabel.text = employeeType?.description()
        employeeTypeLabel.textColor = .black
    }
}


