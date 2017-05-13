package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import com.fasterxml.jackson.annotation.JsonProperty
import javax.persistence.Column
import javax.persistence.GeneratedValue
import javax.persistence.OneToOne
import morphia.utils.POIConverter
import morphia.utils.UsuarioConverter
import org.eclipse.xtend.lib.annotations.Accessors
import org.mongodb.morphia.annotations.Converters
import org.mongodb.morphia.annotations.Entity
import org.mongodb.morphia.annotations.Id

@JsonIgnoreProperties(ignoreUnknown=true)
@Entity(noClassnameStored=true)
@javax.persistence.Entity
@Converters(UsuarioConverter,POIConverter)
@Accessors
class Opinion {
	@GeneratedValue
	@javax.persistence.Id
	@Id
	int id
	
	@Column	
	int calificacion
	
	@Column	
	String comentario
	
	@JsonIgnore
	@OneToOne
	Usuario usuario
	
	@JsonIgnore
	@OneToOne
	POI poi
	
	@JsonProperty("usuario")
	def String getNombreUsuario(){
		usuario.nombre
	}
}