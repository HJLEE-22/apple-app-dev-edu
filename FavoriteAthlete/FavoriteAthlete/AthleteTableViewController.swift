import UIKit

class AthleteTableViewController: UITableViewController {
    
    struct PropertyKeys {
        static let athleteCell = "AthleteCell"
        static let editAthleteSegue = "EditAthlete"
    }
    
    var athletes: [Athlete] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return athletes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.athleteCell, for: indexPath)
        
        let athlete = athletes[indexPath.row]
        cell.textLabel?.text = athlete.name
        cell.detailTextLabel?.text = athlete.description
        
        return cell
    }


    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 해야할 것: 수정 버튼을 누를 때 테이블 뷰 셀의 데이터를 수정 페이지에 전송하기.
        // 테이블뷰턴트롤러 다운캐스팅 왜...?ㅜ
        let athleteFormViewController = segue.destination as! AthleteFormViewController
        if let indexPath = tableView.indexPathForSelectedRow, segue.identifier == PropertyKeys.editAthleteSegue {
            athleteFormViewController.athlete = athletes[indexPath.row]
        } else {
            // indexPath가 없는 신규일땐, 넣어줄 값이 없으니까 안써줘도 되는거 맞나...?
            // 맞네...
        }
        
    }
    // 근데 이 unwind 메소드가 왜 formViewController가 아니라 tableViewController에 있는 걸까?
    // unwind segue 함수가 있는 곳이 초기값이 됨. 이 함수가 있는 뷰 컨트롤러로 돌아오겠다는 뜻. 
    @IBAction func unwindToList(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as! AthleteFormViewController
        // Use data from the view controller which initiated the unwind segue
        guard let athlete = sourceViewController.athlete else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            athletes.remove(at: indexPath.row)
            athletes.insert(athlete, at: indexPath.row)
            tableView.deselectRow(at: indexPath, animated: true)
        } else {
            athletes.append(athlete)
        }
    }
    
}
