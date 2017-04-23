package creacionales

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Observable
import poi.Usuario
import poi.utils.Punto

@Observable
@Accessors
class UsuarioBuilder {
	Usuario usuario = new Usuario

	def build() {
		usuario
	}

	def nombre(String string) {
		usuario.setNombre(string)
		this
	}
	
	def contrasenia(String string) {
		usuario.setContrasenia(string)
		this
	}
	
	def ubicacion( double x , double y){
		usuario.ubicacion = new Punto( x , y)
		this
	}
}
