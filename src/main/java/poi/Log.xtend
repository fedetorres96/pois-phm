package poi

import java.util.Date
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id

@Accessors
@Entity(noClassnameStored=true)
class Log {
	@Id
	ObjectId id
    
	Date fechaHora

	String usuario
	
	boolean exitoso
	
}
