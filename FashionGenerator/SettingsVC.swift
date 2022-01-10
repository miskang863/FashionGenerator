import UIKit

class SettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let settings = UserSettings(priceRange: 50.0, category: [], size: "", size2: "")
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var jacketsButton: UIButton!
    @IBOutlet weak var shirtsButton: UIButton!
    @IBOutlet weak var sweatersButton: UIButton!
    @IBOutlet weak var skirtsButton: UIButton!
    @IBOutlet weak var dressesButton: UIButton!
    @IBOutlet weak var pantsButton: UIButton!
    @IBOutlet weak var blousesButton: UIButton!
    @IBOutlet weak var shoesButton: UIButton!
    @IBOutlet weak var jumpsuitsButton: UIButton!
    @IBOutlet weak var bagsButton: UIButton!
    @IBOutlet weak var blazersButton: UIButton!
    @IBOutlet weak var othersButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func priceSlider(_ sender: UISlider) {
        priceLabel.text = "Select max price: " + String(Int(sender.value)) + "€"
        settings.priceRange = Double(sender.value)
    }
    
    @IBAction func jacketsButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "6"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("6")
            }
        }
    }
    
    @IBAction func shirtsButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "9"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("9")
            }
        }
    }
    
    @IBAction func sweatersButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "2"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("2")
            }
        }
    }
    
    @IBAction func dressesButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "3"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("3")
            }
        }
    }
    
    @IBAction func pantsButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "5"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("5")
            }
        }    }
    
    @IBAction func skirtsButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "4"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("4")
            }
        }
    }
    
    @IBAction func shoesButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "8"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("8")
            }
        }
    }
    
    @IBAction func blousesButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "1"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("1")
            }
        }
    }
    
    @IBAction func bagsButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "7"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("7")
            }
        }
    }
    
    @IBAction func blazersButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "10"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("10")
            }
        }
    }
    
    @IBAction func jumpsuitsButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "11"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("11")
            }
        }
    }
    
    @IBAction func othersButton(_ sender: UIButton) {
        if let button = sender as? UIButton {
            if button.isSelected {
                // set deselected
                button.isSelected = false
                settings.category.removeAll { value in
                  return value == "0"
                }
            } else {
                // set selected
                button.isSelected = true
                settings.category.append("0")
            }
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        print(settings.category, settings.priceRange, settings.size, settings.size2 )
    }
    
    @IBOutlet weak var sizePicker: UIPickerView!
    
    
    //let choices = Choices()
    var data = ["XS", "S", "M", "L", "XL", "XXL"]
    var data2 = Array(30...49)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sizePicker.delegate = self
        self.sizePicker.dataSource = self
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (component == 0) {
        return data.count
        } else {
        return data2.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (component == 0) {
            settings.size = String(data[row])
            return data[row]
        } else {
            settings.size2 = String(data2[row])
            return String(data2[row])
        }
    }
}
