package poi

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import org.bson.types.ObjectId
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id

@JsonIgnoreProperties(ignoreUnknown=true)
@Entity(noClassnameStored=true)
@Accessors
class Opinion {
	@Id
	ObjectId id
	
	int calificacion
	
	String comentario
	
	String usuario
	
	String poi
}