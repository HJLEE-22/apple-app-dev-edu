//
//  AthleteFormViewController.swift
//  FavoriteAthlete
//
//  Created by 이형주 on 2022/06/08.
//

import Foundation
import UIKit

class AthleteFormViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var leagueTextField: UITextField!
    @IBOutlet var teamTextField: UITextField!
    
//    var athlete: [Athlete] = []
//    var athlete = [Athlete]()
    // 아래 식과 위의 식의 차이는??
    // 근데 둘 다 아니었다.
    // FormVC는 데이터 리스트가 필요하지 않잖아!!!! 얘는 그냥 저 구조체 형식만 갖고오면 됐잖아!!! 그니까 그러지!
    
    var athlete: Athlete?
    
    override func viewDidLoad() {
        ageTextField.keyboardType = .numberPad
        // 숫자만 입력되게 어떻게 하지...?
        // textField의 delegate 확인해볼 것
        updateView()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, let age = ageTextField.text, let league = leagueTextField.text, let team = teamTextField.text else { return }
        guard let ageInt = Int(age) else { return }

        athlete = Athlete(name: name, age: ageInt, league: league, team: team)
//        let athleteExample = Athlete(name: name, age: ageInt, league: league, team: team)
        // 난 위에서 Athlete 인스턴스를 생성하고 이를 빈 [Athlete] 에 넣었는데,
        // 여기선 위의 Athlete을 그냥 타입만 바로 대입하는구만.
//        athlete.append(athleteExample)
       // 버튼을 누르면 이전 화면으로 되돌아가기 -> push
        // 입력한 데이터도 전송하기.
        // 밑에 맞는데 왜 안되지? ㅜ
        // 1. present 모달리 방식으로 온 게 아니기에 밑에 안됨
        //self.presentingViewController?.dismiss(animated: true)
        // 2. 액션버튼을 눌러 돌아가는 거니 네비게이션 화면전환 식도 안됨
        // self.navigationController?.popViewController(animated: true)
        // 3. 커스텀 세그웨이 방식으로 가야 되나요?
        
        // perform segue는 화면 전환 해! 라고 생각하면 될 듯.
        self.performSegue(withIdentifier: "UnwindToList", sender: nil)
    }
    func updateView() {
        // athlete 이 어떤 athlete인지 모르는데 어떻게? 그니까, indexPath 이런 것도 없이...
        guard let athlete = athlete else { return }
        nameTextField.text = athlete.name
        ageTextField.text = String(athlete.age)
        leagueTextField.text = athlete.league
        teamTextField.text = athlete.team
        
        
    }

    
}
