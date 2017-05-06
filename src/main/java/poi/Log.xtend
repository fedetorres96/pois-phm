package poi

import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.bson.types.ObjectId
import java.util.Date
import org.mongodb.morphia.annotations.Embedded
import org.mongodb.morphia.annotations.Property
import org.uqbar.commons.utils.Observable

@Observable
@Accessors
@Entity(value="LogLogin", noClassnameStored=true)
class Log {
	
	public static String PRESTADO = "P"
	public static String DISPONIBLE = "D"
	
	@Id ObjectId id
	
	@Property("fechaLogin")
	int fecha
	//Date fecha
	
	
	@Property("horaLogin")
	int hora
	//Date hora
	
	@Embedded	
	String usuario
	//Usuario usuario
	
	Boolean exitoso
	String estado // "P" prestado / "D" disponible
	
	new() {
		exitoso = true
		estado = DISPONIBLE
	}
}
