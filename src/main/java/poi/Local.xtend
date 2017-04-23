package poi

import com.fasterxml.jackson.annotation.JsonIgnore
import com.fasterxml.jackson.annotation.JsonProperty
import java.util.List
import java.util.Set
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.Id
import javax.persistence.ManyToOne
import javax.persistence.OneToMany
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import org.hibernate.annotations.LazyCollection
import org.joda.time.DateTime
import poi.utils.Punto
import poi.utils.RangoHorario

import static extension poi.utils.POIUtils.*

@Accessors
@Entity
class Local extends POI {
	
	@JsonIgnore
	@LazyCollection(FALSE)
	@OneToMany(cascade=ALL)
	List<RangoHorario> horario

	@ManyToOne(cascade=ALL)
	Punto ubicacion

	@ManyToOne(cascade=ALL)
	Rubro rubro

	@Transient
	Set<String> palabrasClave = newHashSet

	@Column(length=100)
	String nombre

	override estaCerca(Punto coordenada) {
		ubicacion.estaCerca(coordenada, rubro.radio)
	}

	override coincideBusqueda(String string) {
		nombre.comienzaCon(string) || rubro.nombre.coincideCon(string) || palabrasClave.contiene(string)
	}

	override estaDisponible(DateTime momento, String string) {
		estaDisponible(momento)
	}

	override estaDisponible(DateTime momento) {
		horario.exists[estaDisponible(momento)]
	}

	override getDistancia(Punto coordenada) {
		ubicacion.distance(coordenada)
	}
	
	@JsonProperty("horario")
	def getHorarioJSON(){
		horario.map[ asJson ]
	}
}

@Entity
@Accessors
class Rubro {
	@Id
	@GeneratedValue
	private Long id

	@Column
	int radio

	@Column(length=100)
	String nombre
}
