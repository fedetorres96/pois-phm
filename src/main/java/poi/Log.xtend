package poi

import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id
import org.mongodb.morphia.annotations.Converters
import morphia.utils.UsuarioConverter

@Accessors
@Entity(noClassnameStored=true)
@Converters(UsuarioConverter)
class Log {
	@Id
	ObjectId id

	String fechaHora

	Usuario usuario
	
	boolean exitoso
	
}
