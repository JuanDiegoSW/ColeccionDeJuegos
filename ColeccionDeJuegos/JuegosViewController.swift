//
//  JuegosViewController.swift
//  ColeccionDeJuegos
//
//  Created by Juan Diego on 10/13/21.
//  Copyright © 2021 empresa. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var JuegosImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var categoriaTextField: UITextField!
    
    @IBOutlet weak var eliminarBoton: UIButton!
    @IBOutlet weak var agregarActualizarBoton: UIButton!
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    var categoria:Categoria?=nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        if(juego != nil){
            JuegosImageView.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTextField.text = juego!.titulo
            categoriaTextField.text = juego!.categoria
            agregarActualizarBoton.setTitle("Actualizar", for: .normal)
        }else{
            eliminarBoton.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func fotosTapper(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker,animated: true,completion: nil)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo! = tituloTextField.text!
            juego!.imagen = JuegosImageView.image?.jpegData(compressionQuality: 0.50)
            //categoria!.nomCategoria! = categoriaTextField.text!
            juego!.categoria! = categoriaTextField.text!
            
        }else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            //let context1 = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context:context)
            juego.titulo = tituloTextField.text
            juego.imagen = JuegosImageView.image?.jpegData(compressionQuality: 0.50)
            juego.categoria = categoriaTextField.text
            
            //let categoria = Categoria(context: context)
            //categoria.nomCategoria = categoriaTextField.text!
            ///juego.categoria = nombrecategoria
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as? UIImage
        JuegosImageView.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
