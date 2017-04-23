package poi.utils

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.List
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.OneToMany
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.joda.time.DateTime

import static extension poi.utils.POIUtils.*

@Entity
@Accessors
class Servicio {

	@Id
	@GeneratedValue
	private Long id
	
	@JsonIgnore
	@LazyCollection(FALSE)
	@OneToMany(cascade=ALL)
	List<RangoHorario> horario

	@Column(length=100)
	String nombre

	def boolean coincideNombre(String string) {
		nombre.comienzaCon(string)
	}

	def boolean estaDisponible(DateTime momento) {
		horario.exists[estaDisponible(momento)]
	}

	override toString() {
		nombre + "\n" + horario
	}
	
	@JsonProperty("horario")
	def getHorarioJSON(){
		horario.map[ asJson ]
	}
}
