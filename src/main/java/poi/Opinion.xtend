package poi

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@JsonIgnoreProperties(ignoreUnknown=true)
@Accessors
@Entity
class Opinion {
	
	@Id
	@GeneratedValue
	private Long id
	
	@Column(name="calificacion")
	int calificacion
	
	@Column(length=255)
	String comentario
	
	@Column(length=150)
	String usuario
	
	new() {
		
	}
}
